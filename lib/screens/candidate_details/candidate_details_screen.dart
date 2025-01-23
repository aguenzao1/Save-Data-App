import 'package:flutter/material.dart';
import '../../database/database.dart' as db;

class CaidatDetailsScreen extends StatefulWidget {
  final int candidateId;

  const CaidatDetailsScreen({super.key, required this.candidateId});

  @override
  _CaidatDetailsScreenState createState() => _CaidatDetailsScreenState();
}

class _CaidatDetailsScreenState extends State<CaidatDetailsScreen> {
  late db.AppDatabase database;
  List<db.CandidateDetail> details = [];

  @override
  void initState() {
    super.initState();
    database = db.AppDatabase();
    _loadDetails();
  }

  @override
  void dispose() {
    database.close();
    super.dispose();
  }

  Future<void> _loadDetails() async {
    final data = await database.fetchCandidateDetails(widget.candidateId);
    setState(() {
      details = data;
    });
  }

  Future<void> _addDetail(Map<String, String> detailData) async {
    for (var entry in detailData.entries) {
      await database.addCandidateDetails(widget.candidateId, entry.key, entry.value);
    }
    await _loadDetails();
  }

  void _showDetailDialog(List<db.CandidateDetail> personDetails) {
    final Map<String, String> details = {};
    for (var detail in personDetails) {
      details[detail.key] = detail.value;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('View Details'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: const Text('Name'),
                subtitle: Text(details['name'] ?? ''),
              ),
              ListTile(
                title: const Text('Number'),
                subtitle: Text(details['number'] ?? ''),
              ),
              ListTile(
                title: const Text('ID Card'),
                subtitle: Text(details['idCard'] ?? ''),
              ),
              ListTile(
                title: const Text('Place'),
                subtitle: Text(details['place'] ?? ''),
              ),
              ListTile(
                title: const Text('Description'),
                subtitle: Text(details['description'] ?? ''),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showAddEditDialog({List<db.CandidateDetail>? personDetails}) {
    final Map<String, String> currentDetails = {};
    if (personDetails != null) {
      for (var detail in personDetails) {
        currentDetails[detail.key] = detail.value;
      }
    }

    final nameController = TextEditingController(text: currentDetails['name'] ?? '');
    final numberController = TextEditingController(text: currentDetails['number'] ?? '');
    final idCardController = TextEditingController(text: currentDetails['idCard'] ?? '');
    final placeController = TextEditingController(text: currentDetails['place'] ?? '');
    final descriptionController = TextEditingController(text: currentDetails['description'] ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(personDetails == null ? 'Add New Person' : 'Edit Person'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: numberController,
                decoration: const InputDecoration(labelText: 'Number'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: idCardController,
                decoration: const InputDecoration(labelText: 'ID Card Number'),
              ),
              TextField(
                controller: placeController,
                decoration: const InputDecoration(labelText: 'Place'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                final detailData = {
                  'name': nameController.text,
                  'number': numberController.text,
                  'idCard': idCardController.text,
                  'place': placeController.text,
                  'description': descriptionController.text,
                };
                
                if (personDetails == null) {
                  _addDetail(detailData);
                } else {
                  // Delete old details and add new ones
                  _updateDetails(personDetails, detailData);
                }
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _updateDetails(List<db.CandidateDetail> oldDetails, Map<String, String> newData) async {
    // Delete old details
    for (var detail in oldDetails) {
      await database.deleteCandidateDetail(detail.id);
    }
    // Add new details
    await _addDetail(newData);
  }

  @override
  Widget build(BuildContext context) {
    // Group details by person (every 5 details belong to one person)
    final List<List<db.CandidateDetail>> groupedDetails = [];
    for (var i = 0; i < details.length; i += 5) {
      if (i + 5 <= details.length) {
        groupedDetails.add(details.sublist(i, i + 5));
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('People in Caidat'),
      ),
      body: groupedDetails.isEmpty
          ? const Center(child: Text('No people added yet'))
          : ListView.builder(
              itemCount: groupedDetails.length,
              itemBuilder: (context, index) {
                final personDetails = groupedDetails[index];
                final name = personDetails.firstWhere((d) => d.key == 'name', orElse: () => const db.CandidateDetail(id: 0, candidateId: 0, key: 'name', value: 'Unknown')).value;
                
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(name),
                    onTap: () => _showDetailDialog(personDetails),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _showAddEditDialog(personDetails: personDetails),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            for (var detail in personDetails) {
                              await database.deleteCandidateDetail(detail.id);
                            }
                            _loadDetails();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEditDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}