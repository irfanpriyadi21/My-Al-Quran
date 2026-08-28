import 'dart:math' as math;

class ModelMosque {
  final String id;
  final String name;
  final double lat;
  final double lng;
  final double distanceInMeters;
  final String address;
  final String? street;
  final String? subdistrict;
  final String? city;
  final String type; // 'Masjid', 'Musholla', 'Islamic Center'
  final String? wheelchair;
  final String? openingHours;
  final String? phone;
  final String? website;
  final double qiblaAngle;
  final double bearingAngle;

  ModelMosque({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    required this.distanceInMeters,
    required this.address,
    this.street,
    this.subdistrict,
    this.city,
    required this.type,
    this.wheelchair,
    this.openingHours,
    this.phone,
    this.website,
    required this.qiblaAngle,
    required this.bearingAngle,
  });

  /// Format distance into readable text, e.g. "450 m" or "2.3 km"
  String get formattedDistance {
    if (distanceInMeters < 1000) {
      return "${distanceInMeters.round()} m";
    } else {
      final km = distanceInMeters / 1000;
      return "${km.toStringAsFixed(1)} km";
    }
  }

  /// Approximate walking time (average 4.5 km/h)
  String get estimatedWalkingTime {
    final minutes = (distanceInMeters / (4500 / 60)).round();
    if (minutes < 1) return "< 1 mnt jalan kaki";
    if (minutes < 60) return "$minutes mnt jalan kaki";
    final hours = minutes ~/ 60;
    final rem = minutes % 60;
    return "$hours jam ${rem > 0 ? '$rem mnt' : ''} jalan kaki";
  }

  /// Approximate driving time (average 25 km/h in city)
  String get estimatedDrivingTime {
    final minutes = (distanceInMeters / (25000 / 60)).round();
    if (minutes <= 1) return "~1 mnt berkendara";
    if (minutes < 60) return "$minutes mnt berkendara";
    final hours = minutes ~/ 60;
    final rem = minutes % 60;
    return "$hours jam ${rem > 0 ? '$rem mnt' : ''} berkendara";
  }

  /// Direction name from user to mosque (Utara, Timur Laut, etc.)
  String get directionName {
    final deg = (bearingAngle + 360) % 360;
    if (deg >= 337.5 || deg < 22.5) return "Utara";
    if (deg >= 22.5 && deg < 67.5) return "Timur Laut";
    if (deg >= 67.5 && deg < 112.5) return "Timur";
    if (deg >= 112.5 && deg < 157.5) return "Tenggara";
    if (deg >= 157.5 && deg < 202.5) return "Selatan";
    if (deg >= 202.5 && deg < 247.5) return "Barat Daya";
    if (deg >= 247.5 && deg < 292.5) return "Barat";
    return "Barat Laut";
  }

  /// Factory from Overpass / OSM JSON element
  factory ModelMosque.fromOsmElement(
    Map<String, dynamic> json,
    double userLat,
    double userLng,
  ) {
    final tags = (json['tags'] as Map<String, dynamic>?) ?? {};
    final id = "${json['type'] ?? 'node'}_${json['id'] ?? ''}";

    // Coordinates: node uses 'lat'/'lon', way/relation uses 'center'
    double lat = 0.0;
    double lng = 0.0;
    if (json['lat'] != null && json['lon'] != null) {
      lat = (json['lat'] as num).toDouble();
      lng = (json['lon'] as num).toDouble();
    } else if (json['center'] != null) {
      lat = (json['center']['lat'] as num).toDouble();
      lng = (json['center']['lon'] as num).toDouble();
    }

    // Name resolution
    String name = (tags['name'] ??
            tags['name:id'] ??
            tags['name:en'] ??
            tags['official_name'] ??
            tags['alt_name'] ??
            '')
        .toString()
        .trim();

    // Determine type
    String type = "Masjid";
    final lowerName = name.toLowerCase();
    if (lowerName.contains("musholla") ||
        lowerName.contains("mushola") ||
        lowerName.contains("musala") ||
        lowerName.contains("surau") ||
        tags['amenity'] == 'place_of_worship' &&
            (tags['building'] == 'musholla' || tags['building'] == 'musalla')) {
      type = "Musholla";
    } else if (lowerName.contains("islamic center") ||
        lowerName.contains("pusat islam")) {
      type = "Islamic Center";
    }

    if (name.isEmpty) {
      name = type == "Musholla" ? "Musholla (Tanpa Nama)" : "Masjid";
    }

    // Address construction
    final street = tags['addr:street']?.toString();
    final houseNumber = tags['addr:housenumber']?.toString();
    final subdistrict = tags['addr:subdistrict']?.toString() ??
        tags['addr:village']?.toString() ??
        tags['addr:hamlet']?.toString();
    final city = tags['addr:city']?.toString() ??
        tags['addr:county']?.toString() ??
        tags['addr:district']?.toString();

    final addressParts = <String>[];
    if (street != null && street.isNotEmpty) {
      addressParts.add(
        houseNumber != null && houseNumber.isNotEmpty
            ? "Jl. $street No. $houseNumber"
            : "Jl. $street",
      );
    }
    if (subdistrict != null && subdistrict.isNotEmpty) {
      addressParts.add(subdistrict);
    }
    if (city != null && city.isNotEmpty) {
      addressParts.add(city);
    }

    String address = addressParts.join(", ");
    if (address.isEmpty) {
      address = "Lokasi terdekat (${lat.toStringAsFixed(4)}, ${lng.toStringAsFixed(4)})";
    }

    // Calculate distance (Haversine)
    final distance = _calculateHaversineDistance(userLat, userLng, lat, lng);

    // Calculate Bearing
    final bearing = _calculateBearing(userLat, userLng, lat, lng);

    // Calculate Qibla Angle from this mosque
    final qibla = _calculateQiblaAngle(lat, lng);

    return ModelMosque(
      id: id,
      name: name,
      lat: lat,
      lng: lng,
      distanceInMeters: distance,
      address: address,
      street: street,
      subdistrict: subdistrict,
      city: city,
      type: type,
      wheelchair: tags['wheelchair']?.toString(),
      openingHours: tags['opening_hours']?.toString(),
      phone: tags['phone']?.toString() ?? tags['contact:phone']?.toString(),
      website:
          tags['website']?.toString() ?? tags['contact:website']?.toString(),
      qiblaAngle: qibla,
      bearingAngle: bearing,
    );
  }

  /// Factory from Nominatim search JSON
  factory ModelMosque.fromNominatim(
    Map<String, dynamic> json,
    double userLat,
    double userLng,
  ) {
    final lat = double.tryParse(json['lat']?.toString() ?? '0') ?? 0.0;
    final lng = double.tryParse(json['lon']?.toString() ?? '0') ?? 0.0;
    final displayName = json['display_name']?.toString() ?? '';
    final nameParts = displayName.split(',');
    final name = nameParts.isNotEmpty ? nameParts.first.trim() : 'Masjid';
    final address = displayName;

    String type = "Masjid";
    if (name.toLowerCase().contains("musholla") ||
        name.toLowerCase().contains("musala")) {
      type = "Musholla";
    }

    final distance = _calculateHaversineDistance(userLat, userLng, lat, lng);
    final bearing = _calculateBearing(userLat, userLng, lat, lng);
    final qibla = _calculateQiblaAngle(lat, lng);

    return ModelMosque(
      id: "nominatim_${json['osm_id'] ?? json['place_id'] ?? DateTime.now().millisecondsSinceEpoch}",
      name: name,
      lat: lat,
      lng: lng,
      distanceInMeters: distance,
      address: address,
      type: type,
      qiblaAngle: qibla,
      bearingAngle: bearing,
    );
  }

  // --- Utility Math Helpers ---

  static double _calculateHaversineDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const double earthRadius = 6371000; // in meters
    final dLat = _degreesToRadians(lat2 - lat1);
    final dLon = _degreesToRadians(lon2 - lon1);

    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_degreesToRadians(lat1)) *
            math.cos(_degreesToRadians(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);

    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadius * c;
  }

  static double _calculateBearing(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    final phi1 = _degreesToRadians(lat1);
    final phi2 = _degreesToRadians(lat2);
    final deltaLambda = _degreesToRadians(lon2 - lon1);

    final y = math.sin(deltaLambda) * math.cos(phi2);
    final x = math.cos(phi1) * math.sin(phi2) -
        math.sin(phi1) * math.cos(phi2) * math.cos(deltaLambda);

    final theta = math.atan2(y, x);
    return (_radiansToDegrees(theta) + 360) % 360;
  }

  static double _calculateQiblaAngle(double lat, double lng) {
    // Ka'bah coordinates in Makkah
    const double makkahLat = 21.422487;
    const double makkahLng = 39.826206;

    final double phiK = makkahLat * (math.pi / 180.0);
    final double lambdaK = makkahLng * (math.pi / 180.0);
    final double phi = lat * (math.pi / 180.0);
    final double lambda = lng * (math.pi / 180.0);

    final double psi = math.atan2(
      math.sin(lambdaK - lambda),
      math.cos(phi) * math.tan(phiK) -
          math.sin(phi) * math.cos(lambdaK - lambda),
    );

    return (psi * (180.0 / math.pi) + 360.0) % 360.0;
  }

  static double _degreesToRadians(double degrees) => degrees * math.pi / 180.0;
  static double _radiansToDegrees(double radians) => radians * 180.0 / math.pi;
}
