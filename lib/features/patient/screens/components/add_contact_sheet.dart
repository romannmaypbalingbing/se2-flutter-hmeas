import 'package:flutter/material.dart';

class AddContactSheet extends StatefulWidget {
  final Map<String, dynamic>? existingContact;
  final Function(Map<String, dynamic>) onAdd;

  const AddContactSheet({super.key, required this.onAdd, this.existingContact});

  @override
  State<AddContactSheet> createState() => _AddContactSheetState();
}

class _AddContactSheetState extends State<AddContactSheet> {
  late TextEditingController nameController;
  late TextEditingController subtitleController;
  late TextEditingController phoneController;
  bool alerted = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: widget.existingContact?['name'] ?? '',
    );
    subtitleController = TextEditingController(
      text: widget.existingContact?['subtitle'] ?? '',
    );
    phoneController = TextEditingController(
      text: widget.existingContact?['phone'] ?? '',
    );
    alerted = widget.existingContact?['alerted'] ?? false;
  }

  @override
  void dispose() {
    nameController.dispose();
    subtitleController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _submit() {
    if (nameController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter both name and phone number'),
        ),
      );
      return;
    }

    final newContact = {
      'name': nameController.text.trim(),
      'subtitle': subtitleController.text.trim(),
      'phone': phoneController.text.trim(),
      'alerted': alerted,
    };

    widget.onAdd(newContact);
    Navigator.pop(context); // Close the bottom sheet after adding/updating
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingContact != null;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 24,
        left: 16,
        right: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isEditing ? 'Edit Emergency Contact' : 'Add Emergency Contact',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: subtitleController,
              decoration: const InputDecoration(labelText: 'Subtitle'),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
              keyboardType: TextInputType.phone,
            ),
            Row(
              children: [
                Checkbox(
                  value: alerted,
                  onChanged: (value) {
                    setState(() {
                      alerted = value ?? false;
                    });
                  },
                ),
                const Text('Alert first when emergency triggered'),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _submit,
              child: Text(isEditing ? 'Save Contact' : 'Add Contact'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
