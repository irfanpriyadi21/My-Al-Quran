import 'dart:math' as math;

class QiblaCalculator {
  // Koordinat Ka'bah (Makkah Al-Mukarramah)
  static const double kaabaLatitude = 21.422487;
  static const double kaabaLongitude = 39.826206;

  static double _degToRad(double deg) => deg * (math.pi / 180.0);
  static double _radToDeg(double rad) => rad * (180.0 / math.pi);

  // 1. Menghitung sudut derajat arah kiblat (0° - 360° searah jarum jam dari Utara Sejati)
  static double calculateQibla(double latitude, double longitude) {
    final phi1 = _degToRad(latitude);
    final lambda1 = _degToRad(longitude);
    final phi2 = _degToRad(kaabaLatitude);
    final lambda2 = _degToRad(kaabaLongitude);

    final deltaLambda = lambda2 - lambda1;

    final y = math.sin(deltaLambda);
    final x = math.cos(phi1) * math.tan(phi2) - math.sin(phi1) * math.cos(deltaLambda);

    double qiblaRad = math.atan2(y, x);
    double qiblaDeg = _radToDeg(qiblaRad);

    return (qiblaDeg + 360.0) % 360.0;
  }

  // 2. Menghitung jarak presisi ke Ka'bah dalam Kilometer (Great Circle Distance)
  static double calculateDistance(double latitude, double longitude) {
    const double earthRadiusKm = 6371.0;
    final dLat = _degToRad(kaabaLatitude - latitude);
    final dLng = _degToRad(kaabaLongitude - longitude);

    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_degToRad(latitude)) * math.cos(_degToRad(kaabaLatitude)) *
        math.sin(dLng / 2) * math.sin(dLng / 2);

    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadiusKm * c;
  }

  // 3. Nama arah mata angin dalam bahasa Indonesia
  static String getDirectionName(double degrees) {
    final deg = (degrees % 360 + 360) % 360;
    if (deg >= 337.5 || deg < 22.5) return "Utara";
    if (deg >= 22.5 && deg < 67.5) return "Timur Laut";
    if (deg >= 67.5 && deg < 112.5) return "Timur";
    if (deg >= 112.5 && deg < 157.5) return "Tenggara";
    if (deg >= 157.5 && deg < 202.5) return "Selatan";
    if (deg >= 202.5 && deg < 247.5) return "Barat Daya";
    if (deg >= 247.5 && deg < 292.5) return "Barat";
    return "Barat Laut";
  }

  // 4. Perkiraan koordinat kota-kota di Indonesia berdasarkan nama lokasi
  static Map<String, double> getCityCoordinates(String cityName) {
    final upper = cityName.toUpperCase();

    if (upper.contains("JAKARTA")) return {"lat": -6.2088, "lng": 106.8456};
    if (upper.contains("BANDUNG")) return {"lat": -6.9175, "lng": 107.6191};
    if (upper.contains("SURABAYA")) return {"lat": -7.2575, "lng": 112.7521};
    if (upper.contains("SEMARANG")) return {"lat": -6.9667, "lng": 110.4167};
    if (upper.contains("YOGYAKARTA") || upper.contains("JOGJA")) return {"lat": -7.7956, "lng": 110.3695};
    if (upper.contains("MEDAN")) return {"lat": 3.5952, "lng": 98.6722};
    if (upper.contains("PALEMBANG")) return {"lat": -2.9909, "lng": 104.7565};
    if (upper.contains("MAKASSAR")) return {"lat": -5.1477, "lng": 119.4327};
    if (upper.contains("DENPASAR") || upper.contains("BALI")) return {"lat": -8.6705, "lng": 115.2126};
    if (upper.contains("BANJARMASIN")) return {"lat": -3.3167, "lng": 114.5900};
    if (upper.contains("SAMARINDA")) return {"lat": -0.5022, "lng": 117.1537};
    if (upper.contains("BALIKPAPAN")) return {"lat": -1.2379, "lng": 116.8289};
    if (upper.contains("PADANG")) return {"lat": -0.9471, "lng": 100.4172};
    if (upper.contains("PEKANBARU")) return {"lat": 0.5071, "lng": 101.4478};
    if (upper.contains("BATAM")) return {"lat": 1.1301, "lng": 104.0529};
    if (upper.contains("BANDA ACEH") || upper.contains("ACEH")) return {"lat": 5.5483, "lng": 95.3238};
    if (upper.contains("LAMPUNG")) return {"lat": -5.4500, "lng": 105.2667};
    if (upper.contains("PONTIANAK")) return {"lat": -0.0263, "lng": 109.3425};
    if (upper.contains("MANADO")) return {"lat": 1.4748, "lng": 124.8428};
    if (upper.contains("MATARAM") || upper.contains("LOMBOK")) return {"lat": -8.5833, "lng": 116.1167};
    if (upper.contains("KUPANG")) return {"lat": -10.1772, "lng": 123.6070};
    if (upper.contains("AMBON")) return {"lat": -3.6958, "lng": 128.1831};
    if (upper.contains("JAYAPURA") || upper.contains("PAPUA")) return {"lat": -2.5337, "lng": 140.7181};
    if (upper.contains("MALANG")) return {"lat": -7.9797, "lng": 112.6304};
    if (upper.contains("SURAKARTA") || upper.contains("SOLO")) return {"lat": -7.5755, "lng": 110.8243};
    if (upper.contains("BOGOR")) return {"lat": -6.5971, "lng": 106.8060};
    if (upper.contains("BEKASI")) return {"lat": -6.2383, "lng": 106.9756};
    if (upper.contains("TANGERANG")) return {"lat": -6.1783, "lng": 106.6319};
    if (upper.contains("DEPOK")) return {"lat": -6.4025, "lng": 106.7942};

    // Default ke koordinat Indonesia Barat (Jakarta)
    return {"lat": -6.2088, "lng": 106.8456};
  }
}
