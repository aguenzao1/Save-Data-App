import 'package:flutter/material.dart';
import '../../database/database_helper.dart';
import '../../dialogs/app_drawer.dart';
import '../../dialogs/candidate_dialogs.dart';
import '../../screen/candidate_details_screen.dart';
// import '../home/home_page.dart';

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
          style: TextStyle(fontSize: 10),
        ),
      ],
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => NewCandidateDialog(onSave: _addCandidate),
        ),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      drawer: const AppDrawer(),
      appBar: AppBar(
        elevation: 2.0,
        centerTitle: true,
        backgroundColor: Colors.grey[300],
        title: const Text(
          'DATA SAVER',
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
        itemCount: candidates.length,
        itemBuilder: (context, index) {
          final candidate = candidates[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12.0),
              title: Text(candidate['name']),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CandidateDetails(
                    candidateId: candidate['id'],
                  ),
                ),
              ),
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
