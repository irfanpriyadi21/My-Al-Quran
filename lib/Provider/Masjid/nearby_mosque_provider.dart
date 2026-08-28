import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:my_quran/Model/model_mosque.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class NearbyMosqueProvider with ChangeNotifier {
  double? userLat;
  double? userLng;
  String userLocationName = "Mendeteksi lokasi...";

  bool isLoadingLocation = false;
  bool isLoadingMosques = false;
  String? errorMessage;
  bool isPermissionDenied = false;
  bool isGpsDisabled = false;

  double selectedRadius = 3000.0; // Default 3 km (in meters)
  final List<double> availableRadii = [1000.0, 3000.0, 5000.0, 10000.0, 20000.0];

  List<ModelMosque> _allMosques = [];
  String _searchQuery = '';
  ModelMosque? selectedMosque;
  bool isMapView = false;

  List<ModelMosque> get mosques {
    if (_searchQuery.trim().isEmpty) {
      return _allMosques;
    }
    final q = _searchQuery.toLowerCase().trim();
    return _allMosques.where((m) {
      return m.name.toLowerCase().contains(q) ||
          m.address.toLowerCase().contains(q) ||
          m.type.toLowerCase().contains(q);
    }).toList();
  }

  int get totalFound => _allMosques.length;
  String get searchQuery => _searchQuery;

  // 1. Initializer: Get GPS & Fetch Mosques
  Future<void> initLocationAndFetch({bool forceRefresh = false}) async {
    if (_allMosques.isNotEmpty && !forceRefresh && userLat != null) {
      return;
    }

    isLoadingLocation = true;
    errorMessage = null;
    isPermissionDenied = false;
    isGpsDisabled = false;
    notifyListeners();

    try {
      // Check if location services are enabled
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        isGpsDisabled = true;
        errorMessage = "Layanan GPS perangkat belum aktif. Mohon aktifkan GPS.";
        isLoadingLocation = false;
        notifyListeners();
        return;
      }

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          isPermissionDenied = true;
          errorMessage = "Izin akses lokasi ditolak oleh pengguna.";
          isLoadingLocation = false;
          notifyListeners();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        isPermissionDenied = true;
        errorMessage =
            "Izin akses lokasi ditolak permanen. Silakan izinkan melalui Pengaturan Aplikasi.";
        isLoadingLocation = false;
        notifyListeners();
        return;
      }

      // Get current position with timeout & high accuracy
      Position? position;
      try {
        position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            timeLimit: Duration(seconds: 10),
          ),
        );
      } catch (_) {
        position = await Geolocator.getLastKnownPosition();
      }

      if (position != null) {
        userLat = position.latitude;
        userLng = position.longitude;
        userLocationName = "Posisi GPS (${userLat!.toStringAsFixed(4)}, ${userLng!.toStringAsFixed(4)})";
      } else {
        // Fallback default coordinate (e.g. Jakarta Pusat)
        userLat = -6.175392;
        userLng = 106.827153;
        userLocationName = "Lokasi Default (Jakarta Pusat)";
      }

      isLoadingLocation = false;
      notifyListeners();

      // Fetch nearby mosques
      await fetchNearbyMosques();
    } catch (e) {
      errorMessage = "Terjadi kendala saat membaca lokasi: $e";
      isLoadingLocation = false;
      notifyListeners();
    }
  }

  // 2. Fetch Nearby Mosques from Overpass API (Multi-Mirror Failover)
  Future<void> fetchNearbyMosques({double? customRadius}) async {
    if (userLat == null || userLng == null) {
      await initLocationAndFetch();
      return;
    }

    final radius = customRadius ?? selectedRadius;
    isLoadingMosques = true;
    errorMessage = null;
    notifyListeners();

    // Overpass QL Query for Muslim Places of Worship (Mosque & Musholla)
    final overpassQuery = """
[out:json][timeout:20];
(
  node["amenity"="place_of_worship"]["religion"="muslim"](around:$radius,$userLat,$userLng);
  way["amenity"="place_of_worship"]["religion"="muslim"](around:$radius,$userLat,$userLng);
  relation["amenity"="place_of_worship"]["religion"="muslim"](around:$radius,$userLat,$userLng);
  node["amenity"="mosque"](around:$radius,$userLat,$userLng);
  way["amenity"="mosque"](around:$radius,$userLat,$userLng);
  node["building"="mosque"](around:$radius,$userLat,$userLng);
  way["building"="mosque"](around:$radius,$userLat,$userLng);
  node["building"="musholla"](around:$radius,$userLat,$userLng);
  way["building"="musholla"](around:$radius,$userLat,$userLng);
);
out center body;
""";

    final mirrors = [
      "https://overpass-api.de/api/interpreter",
      "https://overpass.kumi.systems/api/interpreter",
      "https://maps.mail.ru/osm/tools/overpass/api/interpreter",
    ];

    bool success = false;

    for (final mirror in mirrors) {
      try {
        final res = await http.post(
          Uri.parse(mirror),
          body: {'data': overpassQuery},
          headers: {'User-Agent': 'MyQuranApp/1.0 (Flutter Mobile App)'},
        ).timeout(const Duration(seconds: 12));

        if (res.statusCode == 200) {
          final decoded = json.decode(utf8.decode(res.bodyBytes));
          if (decoded['elements'] is List) {
            final List elements = decoded['elements'];
            final List<ModelMosque> parsed = [];
            final Set<String> seenIds = {};

            for (final item in elements) {
              final mosque = ModelMosque.fromOsmElement(
                item as Map<String, dynamic>,
                userLat!,
                userLng!,
              );
              // Avoid duplicate places
              if (mosque.lat != 0.0 && mosque.lng != 0.0 && !seenIds.contains(mosque.id)) {
                seenIds.add(mosque.id);
                parsed.add(mosque);
              }
            }

            // Sort by nearest distance
            parsed.sort((a, b) => a.distanceInMeters.compareTo(b.distanceInMeters));
            _allMosques = parsed;
            success = true;
            break;
          }
        }
      } catch (_) {
        // Try next mirror
        continue;
      }
    }

    // If Overpass failed, try Nominatim OSM fallback
    if (!success) {
      success = await _fetchFromNominatimFallback(radius);
    }

    if (!success && _allMosques.isEmpty) {
      errorMessage = "Tidak dapat memuat data masjid. Periksa koneksi internet Anda.";
    }

    isLoadingMosques = false;
    notifyListeners();
  }

  // 3. Fallback to Nominatim API
  Future<bool> _fetchFromNominatimFallback(double radiusMeters) async {
    try {
      final delta = radiusMeters / 111000.0;
      final viewbox =
          "${userLng! - delta},${userLat! + delta},${userLng! + delta},${userLat! - delta}";
      final url =
          "https://nominatim.openstreetmap.org/search?q=masjid&format=json&bounded=1&viewbox=$viewbox&limit=40";

      final res = await http.get(
        Uri.parse(url),
        headers: {'User-Agent': 'MyQuranApp/1.0 (Flutter)'},
      ).timeout(const Duration(seconds: 10));

      if (res.statusCode == 200) {
        final List decoded = json.decode(utf8.decode(res.bodyBytes));
        final List<ModelMosque> parsed = [];
        for (final item in decoded) {
          final mosque = ModelMosque.fromNominatim(
            item as Map<String, dynamic>,
            userLat!,
            userLng!,
          );
          if (mosque.distanceInMeters <= radiusMeters * 1.5) {
            parsed.add(mosque);
          }
        }
        parsed.sort((a, b) => a.distanceInMeters.compareTo(b.distanceInMeters));
        _allMosques = parsed;
        return true;
      }
    } catch (_) {}
    return false;
  }

  // 4. UI Actions & State Modifiers
  void setRadius(double radiusMeters) {
    if (selectedRadius != radiusMeters) {
      selectedRadius = radiusMeters;
      notifyListeners();
      fetchNearbyMosques();
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSelectedMosque(ModelMosque? mosque) {
    selectedMosque = mosque;
    notifyListeners();
  }

  void toggleViewMode() {
    isMapView = !isMapView;
    notifyListeners();
  }

  void setViewMode(bool mapMode) {
    isMapView = mapMode;
    notifyListeners();
  }

  // 5. Open Navigation Route in External Maps (Google Maps / Apple Maps)
  Future<void> openNavigation(ModelMosque mosque) async {
    final lat = mosque.lat;
    final lng = mosque.lng;
    final name = Uri.encodeComponent(mosque.name);

    // Google Maps Navigation Intent URL
    final googleMapsUrl =
        Uri.parse("https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving");

    // Geo URI fallback
    final geoUri = Uri.parse("geo:$lat,$lng?q=$lat,$lng($name)");

    try {
      if (await canLaunchUrl(googleMapsUrl)) {
        await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
      } else if (await canLaunchUrl(geoUri)) {
        await launchUrl(geoUri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(
          Uri.parse("https://maps.google.com/?q=$lat,$lng"),
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      debugPrint("Could not launch navigation: $e");
    }
  }

  // 6. Share Mosque Information
  Future<void> shareMosque(ModelMosque mosque) async {
    final mapLink = "https://maps.google.com/?q=${mosque.lat},${mosque.lng}";
    final text = """
🕌 *${mosque.name}* (${mosque.type})
📍 Alamat: ${mosque.address}
📏 Jarak: ${mosque.formattedDistance} dari lokasi saat ini
🧭 Arah: ${mosque.directionName} (Kiblat: ${mosque.qiblaAngle.toStringAsFixed(1)}°)

🗺 Buka di Google Maps:
$mapLink

Dibagikan melalui *My Al-Quran Mobile App*
""";

    await Share.share(text.trim(), subject: "Lokasi ${mosque.name}");
  }

  // 7. Open Device Location Settings
  Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  // 8. Open App Permission Settings
  Future<void> openAppSettings() async {
    await Geolocator.openAppSettings();
  }
}
