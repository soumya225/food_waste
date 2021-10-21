import 'package:food_waste/models/storage_locations_enum.dart';

class FoodItem {
  final String name;
  final String description;
  DateTime expiry = DateTime.now();
  var location = StorageLocationEnum.fridge;
  int amount = 1;

  FoodItem({required this.name, required this.description});

  @override
  String toString() {
    return 'FoodItem{name: $name, description: $description}';
  }
}

var demoFoodItems = [
  FoodItem(
    name: "Mangoes",
    description: "7pcs, Priceg",
  ),
  FoodItem(
    name: "Red Apple",
    description: "1kg, Priceg",
  ),
  FoodItem(
    name: "Bell Pepper Red",
    description: "1kg, Priceg",
  ),
  FoodItem(
    name: "Ginger",
    description: "250gm, Priceg",
  ),
  FoodItem(
    name: "Garlic",
    description: "250gm, Priceg",
  ),
  FoodItem(
    name: "Onions",
    description: "250gm, Priceg",
  ),
  FoodItem(
    name: "Bananas",
    description: "250gm, Priceg",
  ),
  FoodItem(
    name: "Tomatoes",
    description: "250gm, Priceg",
  ),
];
