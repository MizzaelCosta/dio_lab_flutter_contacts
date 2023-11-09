import 'package:hive/hive.dart';

import '../../src/models/contact_model.dart';

abstract class LocalStorage {
  Future<List<Contact>> get();
  Future<void> put(Contact contact);
  Future<void> update(Contact contact);
  Future<void> delete(Contact contact);
}

class LocalStorageWithHive extends LocalStorage {
  final boxName = 'contactsBox';

  @override
  Future<List<Contact>> get() async {
    final storage = await Hive.openBox(boxName);
    final contactsList =
        (storage.values).map((e) => Contact.fromMap(e)).toList();

    return contactsList;
  }

  @override
  Future<void> put(Contact contact) async {
    final storage = await Hive.openBox(boxName);
    final map = contact.toMap();

    await storage.put(contact.id, map);
  }

  @override
  Future<void> update(Contact contact) async {
    await put(contact);
  }

  @override
  Future<void> delete(Contact contact) async {
    final storage = await Hive.openBox(boxName);

    await storage.delete(contact.id);
  }
}
