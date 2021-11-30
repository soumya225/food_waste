import 'package:flutter/material.dart';
import 'package:food_waste/models/inventory_item.dart';
import 'package:food_waste/screens/item_details.dart';
import 'package:food_waste/services/analytics_service.dart';
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
      AnalyticsService().deletedFoodItem();
    }
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ItemDetails(item: item)),
        );
      },
      child: Card(
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
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              alignment: Alignment.centerLeft,
              child: Text(
                "Expires in ${daysToExpiry(DateTime.now(), item.expiry)} days",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () => _decreaseItemCount(context),
                    icon: item.count > 1 ? Icon(Icons.indeterminate_check_box_rounded) : Icon(Icons.delete_rounded)
                ),
                Column(
                  children: [
                    Text(
                      item.count.toString(),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      "${item.count}00g",
                      style: Theme.of(context).textTheme.bodyText2,
                    )
                  ],
                ),
                IconButton(
                    onPressed: () => _increaseItemCount(context),
                    icon: Icon(Icons.add_box_rounded)
                ),
              ],
            )
          ],
        )
      ),
    );
  }
}
