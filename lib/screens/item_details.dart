import 'package:flutter/material.dart';
import 'package:food_waste/models/inventory_item.dart';
import 'package:food_waste/services/database_service.dart';
import 'package:food_waste/utilities.dart';
import 'package:intl/intl.dart';


class ItemDetails extends StatefulWidget {
  final InventoryItem item;
  ItemDetails({Key? key, required this.item}) : super(key: key);

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _dateController.text = DateFormat.yMd().format(widget.item.expiry);
  }

  _handleDatePicker() async {
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: widget.item.expiry,
        firstDate: DateTime.now().difference(widget.item.expiry).inDays < 0 ? DateTime.now() : widget.item.expiry,
        lastDate: DateTime(2050));
    if (date != null) {
      DatabaseService().updateInventoryItem(widget.item, newExpiry: date);
      String formattedDate = DateFormat.yMd().format(date);
      _dateController.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Item details"),
        leading: IconButton(
          icon: Icon(Icons.check),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(32.0),
          children: [
            Text(
              widget.item.description,
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              widget.item.foodCategory,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(
              height: 32.0,
            ),
            DropdownButtonFormField<String>(
              value: widget.item.location,
              items: storageLocations
                  .map((e) => DropdownMenuItem<String>(
                child: Text(e.toString()),
                value: e,
              ))
                  .toList(),
              onChanged: (value) {
                widget.item.location = value;
              },
              decoration: InputDecoration(
                  labelText: "Storage location", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 16.0,
            ),
            TextFormField(
              readOnly: true,
              controller: _dateController,
              onTap: _handleDatePicker,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a date';
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: "Expiry Date", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              "Nutrition information (per 100g)",
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                color: Theme.of(context).colorScheme.secondary
              ),
            ),
            Text(
              "Protein value: " + widget.item.proteinValue.toString() + "g",
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Text(
              "Carbohydrate value: " + widget.item.carbValue.toString() + "g",
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Text(
              "Fat value: " + widget.item.fatValue.toString() + "g",
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
      ),
    );
  }
}
