import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_waste/models/food_item.dart';


//To track what food items the user wants to add to their inventory
class Cart with ChangeNotifier {
  List<FoodItem> foodItems = [];

  void addToCart(FoodItem foodItem) {
    foodItems.add(foodItem);
    notifyListeners();
  }

  void removeFromCart(FoodItem foodItem) {
    foodItems.remove(foodItem);
    notifyListeners();
  }

  void clearCart() {
    foodItems.clear();
    notifyListeners();
  }

  void changeExpiryDateOfItem(int index, DateTime d) {
    foodItems[index].expiry = d;
    notifyListeners();
  }

  void changeItemCountOfItem(int index, int i) {
    foodItems[index].count = i;
    notifyListeners();
  }
}