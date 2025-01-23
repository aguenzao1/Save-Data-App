import 'package:flutter/material.dart';
import '../../database/database.dart';
import '../candidate_details/candidate_details_screen.dart';
import '../../dialogs/app_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AppDatabase database;
  List<Candidate> caidats = [];

  @override
  void initState() {
    super.initState();
    database = AppDatabase();
    _loadCaidats();
  }

  @override
  void dispose() {
    database.close();
    super.dispose();
  }

  void _loadCaidats() async {
    final fetchedCaidats = await database.fetchCandidates();
    setState(() {
      caidats = fetchedCaidats;
    });
  }

  void _deleteCaidat(int id) async {
    await database.deleteCandidate(id);
    _loadCaidats();
  }

  void _addCaidat(String name) async {
    await database.addCandidate(name);
    _loadCaidats();
  }

  void _editCaidat(int id, String newName) async {
    await database.updateCandidate(id, newName);
    _loadCaidats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: const [
        Text(
          textAlign: TextAlign.center,
          '© BY AGUENZAO  -  2024',
          style: TextStyle(fontSize: 10),
        ),
      ],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final nameController = TextEditingController();
              return AlertDialog(
                title: const Text('Add New Caidat'),
                content: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Caidat Name'),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isNotEmpty) {
                        _addCaidat(nameController.text);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      drawer: const AppDrawer(),
      appBar: AppBar(
        elevation: 2.0,
        centerTitle: true,
        backgroundColor: Colors.grey[300],
        title: const Text(
          'CAIDAT MANAGER',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
            fontSize: 19.0,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: ListView.builder(
        itemCount: caidats.length,
        itemBuilder: (context, index) {
          final caidat = caidats[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12.0),
              leading: const Icon(Icons.location_city),
              title: Text(caidat.name),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CaidatDetailsScreen(
                      candidateId: caidat.id,
                    ),
                  ),
                );
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      final editController = TextEditingController(text: caidat.name);
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Edit Caidat'),
                          content: TextField(
                            controller: editController,
                            decoration: const InputDecoration(labelText: 'Caidat Name'),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (editController.text.isNotEmpty) {
                                  _editCaidat(caidat.id, editController.text);
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text('Save'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  IconButton(
                    onPressed: () => _deleteCaidat(caidat.id),
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}