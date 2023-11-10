import 'dart:io';

import 'package:flutter/material.dart';

import '/src/widget/contact_screen/contact_screen.dart';
import '../home_controller.dart';

class Contacts extends StatelessWidget {
  const Contacts(
    this.controller, {
    super.key,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    final list = controller.contactsList;
    const double width = 15.0;

    return ListView.builder(
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (context, index) {
        var contact = list[index];

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContactScreen(
                  title: 'Visualizar Contato',
                  contact: contact,
                  readOnly: true,
                ),
              ),
            ).then((_) => controller.getAllContacts());
          },
          child: Card(
            elevation: 4.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: CircleAvatar(
                          backgroundImage: (contact.image != null)
                              ? FileImage(
                                  File(contact.image!),
                                )
                              : null,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(contact.name),
                            Text(contact.phone),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                PopupMenuButton(
                  elevation: 10.0,
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContactScreen(
                              title: 'Editar Contato',
                              contact: contact,
                              labelButton: 'Atualizar',
                            ),
                          ),
                        ).then((_) => controller.getAllContacts());
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.edit),
                          SizedBox(width: width),
                          Text('Editar'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () => controller.deleteContact(contact),
                      child: const Row(
                        children: [
                          Icon(Icons.delete_outlined),
                          SizedBox(width: width),
                          Text('Apagar'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
