import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

import '../../../models/contact_model.dart';
import '../../../widget/add_button.dart';
import '../../../widget/input_text.dart';
import '../add_contact_controller.dart';
import 'contact_image.dart';

class ContactsFormEditing extends StatefulWidget {
  const ContactsFormEditing(
    this.contact, {
    super.key,
  });

  final Contact? contact;

  @override
  State<ContactsFormEditing> createState() => _ContactsFormEditingState();
}

class _ContactsFormEditingState extends State<ContactsFormEditing> {
  final formKey = GlobalKey<FormState>();
  late AddContactController controller;
  late VoidCallback backToPreviousPage;
  late TextEditingController name;
  late TextEditingController phone;
  late TextEditingController mail;

  @override
  void initState() {
    controller = context.read<AddContactController>();
    backToPreviousPage = controller.backToPreviousPage(context);
    name = TextEditingController(text: widget.contact?.name ?? '');
    phone = TextEditingController(
        text: controller.mask(widget.contact?.phone) ?? '');
    mail = TextEditingController(text: widget.contact?.mail);

    super.initState();
  }

  @override
  void dispose() {
    formKey.currentState?.dispose();
    name.dispose();
    phone.dispose();
    mail.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double spaceBetween;
    final double padding =
        spaceBetween = MediaQuery.of(context).size.width * 0.03;

    return ListView(
      children: [
        Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: padding * 2, horizontal: padding),
            child: Column(
              children: [
                ContactImage(
                  imagePath: widget.contact?.image,
                ),
                SizedBox(
                  height: spaceBetween * 2,
                ),
                InputText(
                  label: 'Nome',
                  border: true,
                  controller: name,
                  textCapitalization: TextCapitalization.words,
                  validator:
                      Validatorless.required('Nome deve ser preenchido.'),
                ),
                SizedBox(
                  height: spaceBetween,
                ),
                InputText(
                  label: 'Celular',
                  border: true,
                  controller: phone,
                  keyBoardType: TextInputType.phone,
                  validator: Validatorless.multiple([
                    Validatorless.required('Telefone deve ser preenchido.'),
                    Validatorless.min(16, 'O número deve ter 11 dígitos'),
                    Validatorless.max(16, ''),
                  ]),
                  formatter: [
                    MaskTextInputFormatter(
                      mask: '(XX) X XXXX-XXXX',
                      filter: {"X": RegExp(r'[0-9]')},
                    )
                  ],
                ),
                SizedBox(
                  height: spaceBetween,
                ),
                InputText(
                  label: 'E-mail',
                  border: true,
                  controller: mail,
                  keyBoardType: TextInputType.emailAddress,
                  validator: Validatorless.email('E-mail inválido.'),
                ),
                SizedBox(
                  height: spaceBetween * 2,
                ),
                AddButton(
                  label: 'Salvar',
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      if (widget.contact != null) {
                        final contact = widget.contact!.copyWith(
                          name: name.text,
                          phone: phone.text.replaceAll(RegExp(r'\D'), ''),
                          mail: mail.text,
                          image: await controller.returnImagePath(),
                        );

                        controller.updateContact(contact);
                        backToPreviousPage();
                        return;
                      }

                      final contact = Contact(
                        //TODO implementar id único
                        id: DateTime.now().toString(),
                        name: name.text,
                        phone: phone.text.replaceAll(RegExp(r'\D'), ''),
                        mail: mail.text,
                        image: await controller.returnImagePath(),
                      );

                      controller.insertContact(contact);
                      backToPreviousPage();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
