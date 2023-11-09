import '../../../src/models/contact_model.dart';
import '../../../src/repositories/local_storage.dart';
import 'home_state.dart';

typedef StringCallback = String? Function(String?)?;

class HomeController {
  HomeController(
    this._storage,
    this._state,
  );

  final LocalStorage _storage;
  final HomeState _state;

  HomeState get state => _state;

  StringCallback filterContacts() {
    return (newValue) {
      Future(() {
        if (newValue != state.filter) {
          state.setfilter(newValue!);
        }
      });
      return null;
    };
  }

  List<Contact> get contactsList => _returnContactsList();

  List<Contact> _returnContactsList() {
    if (state.filter.isNotEmpty) {
      final filteredList = state.list
          .where((contact) =>
              contact.name.toLowerCase().contains(state.filter.toLowerCase()) ||
              contact.phone
                  .toString()
                  .toLowerCase()
                  .contains(state.filter.toLowerCase()))
          .toList();

      return filteredList;
    }

    return state.list;
  }

  Future<void> getAllContacts() async {
    final list = await _storage.get();
    state.setlist(list);
  }

  Future<void> insertContact(Contact contact) async {
    await _storage.put(contact);
    getAllContacts();
  }

  Future<void> updateContact(Contact contact) async {
    await _storage.update(contact);
    getAllContacts();
  }

  Future<void> deleteContact(Contact contact) async {
    await _storage.delete(contact);
    getAllContacts();
  }
}
