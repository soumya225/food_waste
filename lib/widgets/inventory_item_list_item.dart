import 'package:flutter/material.dart';
import 'package:food_waste/models/inventory_item.dart';
import 'package:food_waste/services/database_service.dart';

import 'package:food_waste/utilities.dart';

class InventoryItemListItem extends StatelessWidget {
  final InventoryItem item;
  final int index;

  InventoryItemListItem({Key? key, required this.item, required this.index}) : super(key: key);

  void _increaseItemCount(BuildContext context) {
    item.count += 1;
    DatabaseService().updateInventoryItem(item);
  }

  void _decreaseItemCount(BuildContext context) {
    if (item.count > 1) {
      item.count -= 1;
      DatabaseService().updateInventoryItem(item);
    } else {
      DatabaseService().deleteInventoryItem(item);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 4.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListTile(
            title: Text(
              item.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              item.foodCategory,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            alignment: Alignment.centerLeft,
            child: Text("Expires in ${daysToExpiry(DateTime.now(), item.expiry)} days"),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () => _decreaseItemCount(context),
                  icon: item.count > 1 ? Icon(Icons.indeterminate_check_box_rounded) : Icon(Icons.delete_rounded)
              ),
              Text(item.count.toString()),
              IconButton(
                  onPressed: () => _increaseItemCount(context),
                  icon: Icon(Icons.add_box_rounded)
              ),
            ],
          )
        ],
      )
    );
  }
}
