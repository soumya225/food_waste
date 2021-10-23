import 'package:flutter/material.dart';
import 'package:food_waste/models/inventory.dart';
import 'package:food_waste/widgets/inventory_item_list_item.dart';
import 'package:provider/provider.dart';

class StorageLocation extends StatelessWidget {
  const StorageLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Inventory>(
        builder: (BuildContext context, Inventory inventory, Widget? child) {
      return GridView.builder(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0
        ),
        itemCount: inventory.inventoryItems.length,
        itemBuilder: (context, index) {
          return InventoryItemListItem(
            index: index,
            item: inventory.inventoryItems[index],
          );
        },
      );
    });
  }
}
