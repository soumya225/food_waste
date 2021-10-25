import 'package:food_waste/utilities.dart';
import 'package:food_waste/widgets/storage_location.dart';

class InventoryItem {
  final String description;
  final String foodCategory;
  final DateTime expiry;
  var location;
  int count;

  InventoryItem({required this.description, required this.foodCategory, required this.expiry, required this.location, required this.count});
}
