import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/src/pages/home/components/contacts.dart';
import '../../pages/home/home_controller.dart';
import '../../widget/add_button.dart';
import '../../widget/contact_screen/contact_screen.dart';
import 'components/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  late final HomeController _homeController;
  @override
  void initState() {
    super.initState();
    _homeController = context.read<HomeController>()
      ..state.addListener(onUpdateState)
      ..getAllContacts();
  }

  @override
  void dispose() {
    _homeController.state.dispose();
    super.dispose();
  }

  void onUpdateState() {
    (context as Element).markNeedsBuild();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Contatos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Search(_formKey),
            const SizedBox(height: 32.0),
            Contacts(_homeController),
          ],
        ),
      ),
      floatingActionButton: AddButton(
        label: 'Novo',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ContactScreen(
                title: 'Adicionar Contato',
                labelButton: 'Salvar',
              ),
            ),
          ).then((_) => _homeController.getAllContacts());
        },
      ),
    );
  }
}
