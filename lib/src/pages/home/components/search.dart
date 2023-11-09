import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widget/input_text.dart';
import '../home_controller.dart';

class Search extends StatelessWidget {
  const Search(
    this.formKey, {
    super.key,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<HomeController>();

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: InputText(
        label: 'Buscar Contato',
        border: true,
        radius: 30,
        validator: controller.filterContacts(),
      ),
    );
  }
}
