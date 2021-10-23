import 'package:flutter/material.dart';
import 'package:food_waste/models/cart.dart';
import 'package:food_waste/models/food_item.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SelectedProductListItem extends StatefulWidget {
  final FoodItem foodItem;
  final int index;

  SelectedProductListItem({Key? key, required this.foodItem, required this.index}) : super(key: key);

  @override
  State<SelectedProductListItem> createState() =>
      _SelectedProductListItemState();
}

class _SelectedProductListItemState extends State<SelectedProductListItem> {
  TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _dateController.text = DateFormat.yMd().format(widget.foodItem.expiry);
  }

  void _increaseItemCount() {
    context.read<Cart>().changeItemCountOfItem(widget.index, widget.foodItem.count + 1);
  }

  void _decreaseItemCount() {
    if (widget.foodItem.count > 1) {
      context.read<Cart>().changeItemCountOfItem(
          widget.index, widget.foodItem.count - 1);
    } else {
      context.read<Cart>().removeFromCart(widget.foodItem);
    }
  }

  _handleDatePicker() async {
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: widget.foodItem.expiry,
        firstDate: DateTime.now(),
        lastDate: DateTime(2050));
    if (date != null && date != widget.foodItem.expiry) {
      context.read<Cart>().changeExpiryDateOfItem(widget.index, date);
      String formattedDate = DateFormat.yMd().format(widget.foodItem.expiry);
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
              widget.foodItem.description,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              widget.foodItem.foodCategory,
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
                    icon: widget.foodItem.count > 1 ? Icon(Icons.indeterminate_check_box_rounded) : Icon(Icons.delete_rounded)
                ),
                Text(widget.foodItem.count.toString()),
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
