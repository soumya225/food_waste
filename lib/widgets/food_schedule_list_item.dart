import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FoodScheduleListItem extends StatelessWidget {
  final DateTime day;
  final Map<String, dynamic> suggestedItems;
  
  const FoodScheduleListItem({Key? key, required this.day, required this.suggestedItems}) : super(key: key);

  Widget _buildListOfSuggestedItems(BuildContext context) {
    StringBuffer sb = StringBuffer();

    suggestedItems.forEach((key, value) {
      sb.write("• $key: $value \n");
    });

    return Text(
      sb.toString(),
      style: Theme.of(context).textTheme.subtitle1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            DateFormat.yMMMMEEEEd().format(day),
            style: Theme.of(context).textTheme.headline6!.copyWith(
              color: Theme.of(context).colorScheme.secondary
            ),
          ),
          _buildListOfSuggestedItems(context)
        ],
      ),
    );
  }
}
