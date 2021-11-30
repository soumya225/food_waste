import 'package:flutter/material.dart';
import 'package:food_waste/models/inventory_item.dart';
import 'package:food_waste/services/analytics_service.dart';
import 'package:food_waste/services/schedule_service.dart';
import 'package:food_waste/widgets/food_schedule_list_item.dart';
import 'package:provider/provider.dart';

class FoodScheduleScreen extends StatefulWidget {
  FoodScheduleScreen({Key? key}) : super(key: key);

  @override
  State<FoodScheduleScreen> createState() => _FoodScheduleScreenState();
}

class _FoodScheduleScreenState extends State<FoodScheduleScreen> {
  bool isLoading = true;
  List<FoodScheduleListItem> schedule = [];

  @override
  void initState() {
    super.initState();
    _buildSchedule(context);
    AnalyticsService().viewedSchedule();
  }

  void _buildSchedule(BuildContext context) async {
    List<InventoryItem> inventoryItems = [];
    Provider.of<List<InventoryItem>>(context, listen: false).forEach((element) {
      inventoryItems.add(InventoryItem(
          description: element.description,
          foodCategory: element.foodCategory,
          expiry: element.expiry,
          proteinValue: element.proteinValue,
          carbValue: element.carbValue,
          fatValue: element.fatValue,
          count: element.count)
      );
    });

    for (int d = 0; d < 3; d++) {
      if(inventoryItems.isEmpty){
        isLoading = false;
        break;
      }
      var day = await ScheduleService().calculateDay(inventoryItems);
      var item = FoodScheduleListItem(
          day: DateTime.now().add(Duration(days: d)), suggestedItems: day);
      item.suggestedItems.removeWhere((key, value) => value == 0.0);
      if (item.suggestedItems.isNotEmpty) {
        schedule.add(item);
      } else {
        setState(() {
          isLoading = false;
        });
        break;
      }
      setState(() {
        isLoading = false;
        inventoryItems.forEach((element) {
          if (item.suggestedItems.containsKey(element.description)) {
            element.count -= item.suggestedItems[element.description] as int;
          }
        });
        inventoryItems.removeWhere((element) => element.count == 0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
          child: SizedBox (
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              ),
          ),
        )
        : schedule.length <= 0
            ? ListView(
              padding: const EdgeInsets.all(32.0),
              children: [
                Image.asset(
                  "assets/images/empty.png",
                  fit: BoxFit.contain
                ),
                SizedBox(
                  height: 32,
                ),
                Center(
                  child: Text(
                    "Not enough food items in inventory to develop a schedule. Please add more.",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ],
            )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: schedule.length,
                    itemBuilder: (BuildContext context, int i) {
                      return schedule[i];
                    },
                  ),
                ),
              );
  }
}
