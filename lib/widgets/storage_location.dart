import 'package:flutter/material.dart';
import 'package:food_waste/models/inventory_item.dart';
import 'package:food_waste/services/database_service.dart';
import 'package:food_waste/widgets/inventory_item_list_item.dart';
import 'package:provider/provider.dart';

class StorageLocation extends StatelessWidget {
  final String? location;

  const StorageLocation({Key? key, required this.location}) : super(key: key);

  List<InventoryItemListItem> _buildGridItems(BuildContext context) {
    List<InventoryItemListItem> gridItems = [];
    // final inventoryItems = context.read<Inventory>().inventoryItems;
    final inventoryItems = Provider.of<List<InventoryItem>>(context);
    for(int i = 0; i < inventoryItems.length; i++) {
      InventoryItemListItem inventoryItem = InventoryItemListItem(
        index: i,
        item: inventoryItems[i],
      );
      if(location == null || inventoryItems[i].location == location) {
        gridItems.add(inventoryItem);
      }
    }
    return gridItems;
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<InventoryItem>>.value(
        value: DatabaseService().getInventoryItems(),
        initialData: [],
        builder: (ctx, value) {
          return GridView(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0
            ),
            children: _buildGridItems(ctx),
          );
        },
    );
  }
}
