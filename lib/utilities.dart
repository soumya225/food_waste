List<String> storageLocations = ["fridge", "freezer", "pantry"];

enum ConnectivityStatus {
  Loading,
  WiFi,
  Cellular,
  Offline
}

int daysToExpiry(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}