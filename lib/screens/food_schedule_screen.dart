import 'package:flutter/material.dart';
import 'package:food_waste/widgets/food_schedule_list_item.dart';

class FoodScheduleScreen extends StatelessWidget {
  FoodScheduleScreen({Key? key}) : super(key: key);

  int dayOffset = -1;

  List<Map<String, String>> suggestedItemsForEachDay = [
    {
      "onions": "100g",
      "tomatoes": "200g",
      "potatoes": "150g"
    },
    {
      "bread": "100g",
      "apples": "200g",
      "avocados": "150g"
    },
    {
      "onions": "100g",
      "tomatoes": "200g",
      "potatoes": "150g"
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: suggestedItemsForEachDay.length,
          itemBuilder: (BuildContext context, int i) {
            dayOffset++;
            return FoodScheduleListItem(
                day: DateTime.now().add(Duration(days: dayOffset)),
                suggestedItems: suggestedItemsForEachDay[i]
            );
          },
        ),
      ),
    );
  }
}
