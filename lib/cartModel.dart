import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final List<Map> _items = [];

  UnmodifiableListView<Map> get items => UnmodifiableListView(_items);

  void add(Map map) {
    for (int i = 0; i < items.length; i++) {
      Map m = _items[i];
      if (m['p_id'] == map["p_id"]) {
        m["qty"]++;
        return;
      }
    }

    map["qty"] = 1;

    _items.add(map);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void remove(Map map) {
    _items.remove(map);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  List<Map> getList() {
    return _items;
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
