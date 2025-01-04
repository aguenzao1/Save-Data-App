import 'package:flutter/material.dart';

class NewCandidateDialog extends StatelessWidget {
  final Function(String) onSave;

  const NewCandidateDialog({super.key, required this.onSave});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();

    return AlertDialog(
      title: const Text('Add New Candidate'),
      content: TextField(
        controller: nameController,
        decoration: const InputDecoration(
          labelText: 'Candidate Name',
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
              onSave(nameController.text);
              Navigator.pop(context);
            }
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

  const EditCandidateDialog({
    super.key,
    required this.candidateName,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final candidateController = TextEditingController(text: candidateName);

    return AlertDialog(
      title: const Text('Edit Candidate'),
      content: TextField(
        controller: candidateController,
        decoration: const InputDecoration(
          labelText: 'Candidate Name',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (candidateController.text.isNotEmpty) {
              onSave(candidateController.text);
              Navigator.pop(context);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}