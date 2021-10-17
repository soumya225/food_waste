import 'package:flutter/material.dart';
import 'package:food_waste/models/food_item.dart';

class InventoryItemListItem extends StatelessWidget {
  final FoodItem foodItem;

  const InventoryItemListItem({Key? key, required this.foodItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Column(
        children: [
          ListTile(
            title: Text(foodItem.name),
            subtitle: Text(foodItem.description),
            trailing: Icon(Icons.check_box_outline_blank_rounded),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.centerLeft,
            child: Text("Expires in 10 days"),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () => {},
                  icon: Icon(Icons.indeterminate_check_box_rounded)
              ),
              Text("5"),
              IconButton(
                  onPressed: () => {},
                  icon: Icon(Icons.add_box_rounded)
              ),
            ],
          )
        ],
      )
    );
  }
}
