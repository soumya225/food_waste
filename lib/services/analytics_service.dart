import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';


class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  final FirebaseAnalytics _analytics = FirebaseAnalytics();

  factory AnalyticsService() {
    return _instance;
  }

  AnalyticsService._internal();

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  Future setUserProperties({required String userID}) async {
    await _analytics.setUserId(userID);
  }

  Future logLogin() async {
    await _analytics.logLogin(loginMethod: "email");
  }

  Future viewedSchedule() async {
    await _analytics.logEvent(
      name: "viewed_schedule",
    );
  }

  Future addedFoodItem() async {
    await _analytics.logEvent(
        name: "added_food_item"
    );
  }

  Future deletedFoodItem() async {
    await _analytics.logEvent(
      name: "deleted_food_item",
    );
  }
}