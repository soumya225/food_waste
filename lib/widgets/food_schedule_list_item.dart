import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FoodScheduleListItem extends StatelessWidget {
  final DateTime day;
  final Map<String, String> suggestedItems;
  
  const FoodScheduleListItem({Key? key, required this.day, required this.suggestedItems}) : super(key: key);

  Widget _buildListOfSuggestedItems() {
    StringBuffer sb = StringBuffer();

    suggestedItems.forEach((key, value) {
      sb.write("~ $key: $value \n");
    });

    return Text(sb.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          DateFormat.yMMMMEEEEd().format(day),
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
            color: Theme.of(context).colorScheme.secondary
          ),
        ),
        _buildListOfSuggestedItems()
      ],
    );
  }
}
