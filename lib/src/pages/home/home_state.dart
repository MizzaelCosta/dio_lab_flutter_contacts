import 'package:flutter/material.dart';

import '../../models/contact_model.dart';

class HomeState extends ChangeNotifier {
  String? _filter;
  List<Contact> _list = [];

  String get filter {
    if (_filter == null) {
      return '';
    }
    return _filter!;
  }

  void setfilter(String filter) {
    _filter = filter;
    notifyListeners();
  }

  List<Contact> get list => _list;

  void setlist(List<Contact> value) {
    _list = value;
    notifyListeners();
  }
}
