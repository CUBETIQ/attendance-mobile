import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:timesync360/core/model/organization_model.dart';

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const double earthRadius = 6371000.0; // Earth radius in meters

  // Convert degrees to radians
  final double lat1Rad = degreesToRadians(lat1);
  final double lon1Rad = degreesToRadians(lon1);
  final double lat2Rad = degreesToRadians(lat2);
  final double lon2Rad = degreesToRadians(lon2);

  // Calculate the change in coordinates
  final double dlat = lat2Rad - lat1Rad;
  final double dlon = lon2Rad - lon1Rad;

  // Haversine formula to calculate distance
  final double a = pow(sin(dlat / 2), 2) +
      cos(lat1Rad) * cos(lat2Rad) * pow(sin(dlon / 2), 2);
  final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  // Calculate distance in meters
  final double distance = earthRadius * c;

  return distance;
}

double degreesToRadians(double degrees) {
  return degrees * pi / 180.0;
}

bool isWithinRadius(Position userLocation,
    OranizationLocationModel companyLocation, double radius) {
  double distance = calculateDistance(userLocation.latitude,
      userLocation.longitude, companyLocation.lat!, companyLocation.lng!);

  return distance <= radius;
}
