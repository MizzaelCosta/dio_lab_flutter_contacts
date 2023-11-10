import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/src/models/contact_model.dart';
import 'components/contact_form_editing.dart';
import 'contact_screen_controller.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({
    super.key,
    required this.title,
    this.contact,
    this.readOnly = false,
    this.labelButton,
  });

  final String title;
  final Contact? contact;
  final bool readOnly;
  final String? labelButton;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ContactScreenController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        leading: IconButton(
          onPressed: controller.backToPreviousPage(context),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: ContactFormEditing(
        contact: contact,
        readOnly: readOnly,
        labelButton: labelButton,
      ),
    );
  }
}
