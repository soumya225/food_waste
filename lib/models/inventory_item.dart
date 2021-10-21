import 'package:food_waste/models/storage_locations_enum.dart';
import 'package:food_waste/widgets/storage_location.dart';

class InventoryItem {
  final String name;
  final String description;
  final DateTime expiry;
  var location = StorageLocationEnum.fridge;
  int amount = 3;

  InventoryItem({required this.name, required this.description, required this.expiry});
}

var demoInventoryItems = [
  InventoryItem(
    name: "Organic Bananas",
    description: "7pcs, Priceg",
    expiry: DateTime.utc(2022,3,22)
  ),
  InventoryItem(
    name: "Red Apple",
    description: "1kg, Priceg",
    expiry: DateTime.utc(2022,10,2),),
  InventoryItem(
    name: "Bell Pepper Red",
    description: "1kg, Priceg",
    expiry: DateTime.utc(2022,11,3),),
  InventoryItem(
    name: "Ginger",
    description: "250gm, Priceg",
    expiry: DateTime.utc(2022,10,19),),
  InventoryItem(
    name: "Garlic",
    description: "250gm, Priceg",
    expiry: DateTime.utc(2021,10,15),),
  InventoryItem(
    name: "Onions",
    description: "250gm, Priceg",
    expiry: DateTime.utc(2022,5,22),),
  InventoryItem(
    name: "Bananas",
    description: "250gm, Priceg",
    expiry: DateTime.utc(2022,9,26),),
  InventoryItem(
    name: "Tomatoes",
    description: "250gm, Priceg",
    expiry: DateTime.utc(2022,1,5),),
];