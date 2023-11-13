import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/src/models/contact_model.dart';
import 'components/contact_form_editing.dart';
import 'contact_screen_controller.dart';

class ContactScreen extends StatefulWidget {
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
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  late ContactScreenController controller;
  bool readOnly = false;
  String? labelButton = '';

  @override
  void initState() {
    super.initState();
    readOnly = widget.readOnly;
    labelButton = widget.labelButton;
    controller = context.read<ContactScreenController>();
  }

  void needsRebuild() {
    (context as Element).markNeedsBuild();
  }

  void _editingContact() {
    readOnly = false;
    labelButton = 'Atualizar';
    needsRebuild();
  }

  List<Widget>? actions(BuildContext context) {
    return (readOnly)
        ? [
            IconButton(
              onPressed: () {
                _editingContact();
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Apagar Contato'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          controller.deleteContact(widget.contact!);
                          Navigator.popUntil(
                              context, ((route) => route.isFirst));
                        },
                        child: const Text('Ok'),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.delete_outlined),
            )
          ]
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        leading: IconButton(
          onPressed: controller.backToPreviousPage(context),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        actions: actions(context),
      ),
      body: ContactFormEditing(
        contact: widget.contact,
        readOnly: readOnly,
        labelButton: labelButton,
      ),
    );
  }
}
