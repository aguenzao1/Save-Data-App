import 'package:flutter/material.dart';

class AddDetailDialog extends StatelessWidget {
  final Function(String, String) onSave;

  const AddDetailDialog({super.key, required this.onSave});

  @override
  Widget build(BuildContext context) {
    final keyController = TextEditingController();
    final valueController = TextEditingController();

    return AlertDialog(
      title: const Text('Add Detail'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: keyController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: valueController,
            decoration: const InputDecoration(labelText: 'Role'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (keyController.text.isNotEmpty && valueController.text.isNotEmpty) {
              onSave(keyController.text, valueController.text);
              Navigator.pop(context);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}