import 'package:flutter/material.dart';
import 'package:food_waste/models/cart.dart';
import 'package:food_waste/models/food_item.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SelectedProductListItem extends StatefulWidget {
  final FoodItem foodItem;

  SelectedProductListItem({Key? key, required this.foodItem}) : super(key: key);

  @override
  State<SelectedProductListItem> createState() =>
      _SelectedProductListItemState();
}

class _SelectedProductListItemState extends State<SelectedProductListItem> {
  DateTime _current = DateTime.now();
  TextEditingController _dateController = TextEditingController();
  int itemCount = 1;

  @override
  void initState() {
    super.initState();

    _dateController.text = DateFormat.yMd().format(_current);
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
      else {
        context.read<Cart>().removeFromCart(widget.foodItem);
        print(context.read<Cart>().foodItems.toString());
      }
    });
  }

  _handleDatePicker() async {
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: _current,
        firstDate: DateTime.now(),
        lastDate: DateTime(2050));
    if (date != null && date != _current) {
      setState(() {
        _current = date;
      });
      String formattedDate = DateFormat.yMd().format(_current);
      _dateController.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 32),
      child: IntrinsicHeight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.foodItem.name,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              widget.foodItem.description,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            SizedBox(
              height: 16.0,
            ),
            Form(
              child: TextFormField(
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
        ),
      ),
    );
  }
}
