import 'package:flutter/material.dart';
import '../../database/database_helper.dart';
import '../dialogs/add_detail_dialog.dart';

class CandidateDetails extends StatefulWidget {
  final int candidateId;

  const CandidateDetails({super.key, required this.candidateId});

  @override
  _CandidateDetailsState createState() => _CandidateDetailsState();
}

class _CandidateDetailsState extends State<CandidateDetails> {
  List<Map<String, dynamic>> details = [];

  @override
  void initState() {
    super.initState();
    _loadDetails();
  }

  Future<void> _loadDetails() async {
    final data = await DatabaseHelper.instance.fetchCandidateDetails(widget.candidateId);
    setState(() {
      details = data;
    });
  }

  Future<void> _addDetail(String key, String value) async {
    await DatabaseHelper.instance.addCandidateDetails(widget.candidateId, key, value);
    await _loadDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Candidate ${widget.candidateId}'),
      ),
      body: details.isEmpty
          ? const Center(child: Text('No details added yet'))
          : ListView.builder(
              itemCount: details.length,
              itemBuilder: (context, index) {
                final detail = details[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(detail['key']),
                    subtitle: Text(detail['value']),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AddDetailDialog(onSave: _addDetail),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}