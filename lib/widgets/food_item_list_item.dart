import 'package:flutter/material.dart';
import 'package:food_waste/models/food_item.dart';

class FoodItemListItem extends StatelessWidget {
  final FoodItem foodItem;

  const FoodItemListItem({Key? key, required this.foodItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(foodItem.name),
        subtitle: Text(foodItem.description),
        trailing: IconButton(
          icon: Icon(Icons.add_box_rounded),
          onPressed: () => {},
        )
    );
  }
}
