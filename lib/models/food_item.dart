import 'dart:convert';
import 'package:food_waste/utilities.dart';

class FoodItem {
  late String description;
  late String foodCategory;
  // double proteinValue;
  // double fatValue;
  // double carbValue;
  DateTime expiry = DateTime.now();
  String location = storageLocations[0];
  int count = 1;

  static List<FoodItem> fromJson(String jsonString) {
    final Iterable<dynamic> data = jsonDecode(jsonString)["foods"];
    return data.map<FoodItem>((dynamic d) => FoodItem()
      ..description = d["lowercaseDescription"]
      ..foodCategory = d['foodCategory']
      // ..proteinValue = data['email']
      // ..fatValue = data['imageUrl']
      // ..carbValue = data['imageUrl']
    ).toList();
  }

  @override
  String toString() {
    return 'FoodItem{description: $description, foodCategory: $foodCategory, expiry: $expiry, location: $location, count: $count}\n';
  }
}


