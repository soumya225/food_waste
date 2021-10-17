import 'package:flutter/material.dart';
import 'package:food_waste/models/food_item.dart';

class SelectedProductListItem extends StatelessWidget {
  final FoodItem foodItem;

  const SelectedProductListItem({Key? key, required this.foodItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 32),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  foodItem.name,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  foodItem.description,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                SizedBox(
                  height: 8,
                ),
              ],
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
        ),
      ),
    );
  }
}
