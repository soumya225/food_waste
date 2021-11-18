import 'package:food_waste/utilities.dart';
import 'package:food_waste/widgets/storage_location.dart';

class InventoryItem {
  final String description;
  final String foodCategory;
  DateTime expiry;
  final double proteinValue;
  final double carbValue;
  final double fatValue;
  var location;
  int count;

  InventoryItem({required this.description,
    required this.foodCategory,
    required this.expiry,
    required this.proteinValue,
    required this.carbValue,
    required this.fatValue,
    this.location,
    required this.count});
}
