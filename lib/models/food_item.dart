import 'dart:convert';
import 'package:food_waste/utilities.dart';

class FoodItem {
  DateTime now = DateTime.now();

  late String description;
  late String foodCategory;
  late double proteinValue;
  late double fatValue;
  late double carbValue;
  late DateTime expiry;
  String location = storageLocations[0];
  int count = 1;

  FoodItem() {
    expiry = now.subtract(Duration(microseconds: now.microsecond));
  }

  static List<FoodItem> fromJson(String jsonString) {

    final Iterable<dynamic> data = jsonDecode(jsonString)["foods"];
    return data.map<FoodItem>((dynamic d) {
      FoodItem newItem = FoodItem()
        ..description = d["lowercaseDescription"]
        ..foodCategory = d["foodCategory"];

      List nutrients = d["foodNutrients"];

      nutrients.forEach((element) {
        if(element["nutrientId"] == 1003) {
          newItem.proteinValue =  element["value"].toDouble();
        } else if (element["nutrientId"] == 1004) {
          newItem.fatValue = element["value"].toDouble();
        } else if (element["nutrientId"] == 1005) {
          newItem.carbValue = element["value"].toDouble();
        }
      });

      return newItem;

    }).toList();
  }

  @override
  String toString() {
    return 'FoodItem{description: $description, foodCategory: $foodCategory, proteinValue: $proteinValue, fatValue: $fatValue, carbValue: $carbValue, expiry: $expiry, location: $location, count: $count} \n';
  }
}


