import 'package:firebase_analytics/firebase_analytics.dart';

final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

void logEvent(String name, Map<String, dynamic> parameters) {
  analytics.logEvent(name: name, parameters: parameters);
}
