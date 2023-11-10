import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/contact_model.dart';
import '../../repositories/local_storage.dart';

class ContactScreenController {
  ContactScreenController(this._storage);

  final LocalStorage _storage;
  XFile? _photo;
  String? _imagePath;

  XFile? get photo => _photo;
  String? get imagePath => _imagePath;

  void setPhoto(XFile? photo) {
    _photo = photo;
  }

  void setImagePath(String? imagePath) {
    _imagePath = imagePath;
  }

  Future<String?> returnImagePath() async {
    return (photo == null && imagePath == null)
        ? null
        : await _saveTo().then((path) => path) ?? imagePath;
  }

  VoidCallback backToPreviousPage(BuildContext context) {
    return () {
      setPhoto(null);
      Navigator.pop(context);
    };
  }

  Future<void> getImageFromGallery() async {
    final picker = ImagePicker();
    setPhoto(await picker.pickImage(source: ImageSource.gallery));
  }

  Future<String?> _saveTo() async {
    final diretory = await getApplicationDocumentsDirectory();
    final imagePath = '${diretory.path}/${photo?.name}';

    if (photo != null) {
      await photo!.saveTo(imagePath);
      return imagePath;
    }
    return null;
  }

  String? mask(String? phone) {
    if (phone != null) {
      var mask = '(XX) X XXXX-XXXX';
      for (var index = 0; index < phone.length; index++) {
        mask = mask.replaceFirst('X', phone[index]);
      }
      return mask;
    }
    return phone;
  }

  Future<void> insertContact(Contact contact) async {
    await _storage.put(contact);
  }

  Future<void> updateContact(Contact contact) async {
    await _storage.update(contact);
  }
}
