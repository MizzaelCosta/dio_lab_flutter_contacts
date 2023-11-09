import 'dart:io';

import 'package:dio_lab_flutter_contacts/src/pages/add/add_contact_page.dart';
import 'package:flutter/material.dart';

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

    return ListView.builder(
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (context, index) {
        var contact = list[index];

        return Card(
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
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddContactPage(
                                title: 'Editar Contato',
                                contact: contact,
                              ),
                            ),
                          ).then((_) => controller.getAllContacts());
                        },
                        icon: const Icon(Icons.edit)),
                    IconButton(
                        onPressed: () {
                          controller.deleteContact(contact);
                        },
                        icon: const Icon(Icons.delete_outlined))
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
