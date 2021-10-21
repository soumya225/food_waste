import 'package:flutter/material.dart';
import 'package:food_waste/models/inventory_item.dart';

class InventoryItemListItem extends StatefulWidget {
  final InventoryItem foodItem;

  InventoryItemListItem({Key? key, required this.foodItem}) : super(key: key);

  @override
  State<InventoryItemListItem> createState() => _InventoryItemListItemState();
}

class _InventoryItemListItemState extends State<InventoryItemListItem> {
  int itemCount = 1;

  int _daysToExpiry(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  void _increaseItemCount() {
    setState(() {
      itemCount++;
    });
  }

  void _decreaseItemCount() {
    setState(() {
      if (itemCount > 1)
        itemCount--;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 4.0,
      child: Column(
        children: [
          ListTile(
            title: Text(widget.foodItem.name),
            subtitle: Text(widget.foodItem.description),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.centerLeft,
            child: Text("Expires in ${_daysToExpiry(DateTime.now(), widget.foodItem.expiry)} days"),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () => _decreaseItemCount(),
                  icon: itemCount > 1 ? Icon(Icons.indeterminate_check_box_rounded) : Icon(Icons.delete_rounded)
              ),
              Text(itemCount.toString()),
              IconButton(
                  onPressed: () => _increaseItemCount(),
                  icon: Icon(Icons.add_box_rounded)
              ),
            ],
          )
        ],
      )
    );
  }
}
