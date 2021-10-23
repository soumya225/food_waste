import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_waste/models/inventory_item.dart';

class Inventory with ChangeNotifier {
  List<InventoryItem> inventoryItems = [];

  void addToInventory(InventoryItem item) {
    inventoryItems.add(item);
    notifyListeners();
  }

  void removeFromInventory(InventoryItem item) {
    inventoryItems.remove(item);
    notifyListeners();
  }

  void changeItemCountOfItem(int index, int i) {
    inventoryItems[index].count = i;
    notifyListeners();
  }

}