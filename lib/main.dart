import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'candidatepages.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        '/home': (context) => const HomePage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> candidates = [];

  @override
  void initState() {
    super.initState();
    _loadCandidates();
  }

  void _loadCandidates() async {
    final fetchedCandidates = await DatabaseHelper.instance.fetchCandidates();
    setState(() {
      candidates = fetchedCandidates;
    });
  }

  void _deleteCandidate(int id) async {
    await DatabaseHelper.instance.deleteCandidate(id);
    _loadCandidates();
  }

  void _addCandidate(String name) async {
    await DatabaseHelper.instance.addCandidate(name);
    _loadCandidates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: const [
        Text(
          textAlign: TextAlign.center,
          '© BY AGUENZAO  -  2024',
          style: TextStyle(
            fontSize: 10,
          ),
        ),
      ],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final nameController = TextEditingController();
              return AlertDialog(
                title: const Text('Add Candidate'),
                content: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _addCandidate(nameController.text);
                      Navigator.pop(context);
                    },
                    child: const Text('Save'),
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[50],
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            child: ListView(
              children: [
                DrawerHeader(
                  child: Container(
                    height: 150.0,
                    width: 150.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/mrclogo.png",
                          height: 98.0,
                          width: 98.0,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          "DATA SAVER",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const HomePage(),
                          transitionDuration: const Duration(milliseconds: 700),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return child;
                          },
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(12),
                    ),
                    icon: const Icon(
                      Icons.home,
                      size: 25.0,
                    ),
                    label: const Text(
                      'HOME',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 2.0,
        centerTitle: true,
        backgroundColor: Colors.grey[300],
        title: Container(
          child: const Text(
            textAlign: TextAlign.center,
            'DATA SAVER',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
              fontSize: 19.0,
              color: Colors.black,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: ListView.builder(
        itemCount: candidates.length,
        itemBuilder: (context, index) {
          final candidate = candidates[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12.0),
              title: Text(candidate['name']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CandidateDetails(
                      candidateId: candidate['id'],
                    ),
                  ),
                );
              },
              trailing: IconButton(
                onPressed: () => _deleteCandidate(candidate['id']),
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
            ),
          );
        },
      ),
    );
  }
}

class NewCandidateDialog extends StatelessWidget {
  final Function(String) onSave;
  final TextEditingController candidateController = TextEditingController();

  NewCandidateDialog({super.key, required this.onSave});

  @override
  Widget build(BuildContext context) {
    final TextEditingController candidateController = TextEditingController();

    return AlertDialog(
      title: const Text('Add New Candidate'),
      content: TextField(
        controller: candidateController,
        decoration: const InputDecoration(
          labelText: 'Candidate Name',
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            String candidateName = candidateController.text;
            onSave(candidateName);
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

class EditCandidateDialog extends StatelessWidget {
  final String candidateName;
  final Function(String) onSave;
  EditCandidateDialog(
      {super.key, required this.candidateName, required this.onSave});

  final TextEditingController candidateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    candidateController.text = candidateName;

    return AlertDialog(
      title: const Text('Edit Candidate'),
      content: TextField(
        controller: candidateController,
        decoration: const InputDecoration(
          labelText: 'Candidate Name',
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            String newCandidateName = candidateController.text;
            onSave(newCandidateName);
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
