import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/src/models/contact_model.dart';
import '/src/pages/add/components/form_editing.dart';
import '../../../src/pages/add/add_contact_controller.dart';

class AddContactPage extends StatelessWidget {
  const AddContactPage({
    super.key,
    required this.title,
    this.contact,
  });

  final String title;
  final Contact? contact;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<AddContactController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        leading: IconButton(
          onPressed: controller.backToPreviousPage(context),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: ContactsFormEditing(contact),
    );
  }
}
