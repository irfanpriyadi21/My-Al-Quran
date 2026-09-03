import 'package:flutter/foundation.dart';
import 'package:home_widget/home_widget.dart';
import 'package:my_quran/Model/model_jadwal_sholat.dart';

class PrayerHomeWidgetService {
  static final PrayerHomeWidgetService _instance =
      PrayerHomeWidgetService._internal();
  factory PrayerHomeWidgetService() => _instance;
  PrayerHomeWidgetService._internal();

  static const String androidWidgetName = 'PrayerWidgetProvider';

  // Hitung shalat berikutnya
  Map<String, String> _calculateNextPrayer(ModelJadwalSholat jadwal) {
    final now = DateTime.now();
    final prayers = [
      {'name': 'Subuh', 'time': jadwal.subuh},
      {'name': 'Dzuhur', 'time': jadwal.dzuhur},
      {'name': 'Ashar', 'time': jadwal.ashar},
      {'name': 'Maghrib', 'time': jadwal.maghrib},
      {'name': 'Isya', 'time': jadwal.isya},
    ];

    for (var prayer in prayers) {
      final timeStr = prayer['time'] ?? '';
      final parts = timeStr.split(':');
      if (parts.length == 2) {
        final hour = int.tryParse(parts[0]) ?? 0;
        final minute = int.tryParse(parts[1]) ?? 0;
        final prayerDate =
            DateTime(now.year, now.month, now.day, hour, minute);

        if (prayerDate.isAfter(now)) {
          return {
            'name': prayer['name']!,
            'time': timeStr,
          };
        }
      }
    }

    // Jika semua shalat hari ini sudah lewat, maka shalat berikutnya adalah Subuh besok
    return {
      'name': 'Subuh (Besok)',
      'time': jadwal.subuh,
    };
  }

  // Update Data Home Widget
  Future<void> updateWidgetData({
    required ModelJadwalSholat jadwal,
    required String cityName,
  }) async {
    if (kIsWeb) return;
    try {
      final nextPrayer = _calculateNextPrayer(jadwal);

      // Simpan data ke widget preferences
      await HomeWidget.saveWidgetData<String>('city_name', cityName);
      await HomeWidget.saveWidgetData<String>(
          'next_prayer_name', nextPrayer['name']);
      await HomeWidget.saveWidgetData<String>(
          'next_prayer_time', nextPrayer['time']);
      await HomeWidget.saveWidgetData<String>('subuh', jadwal.subuh);
      await HomeWidget.saveWidgetData<String>('dzuhur', jadwal.dzuhur);
      await HomeWidget.saveWidgetData<String>('ashar', jadwal.ashar);
      await HomeWidget.saveWidgetData<String>('maghrib', jadwal.maghrib);
      await HomeWidget.saveWidgetData<String>('isya', jadwal.isya);

      // Trigger update pada sistem operasi
      await HomeWidget.updateWidget(
        name: androidWidgetName,
        androidName: androidWidgetName,
      );

      debugPrint("Prayer Home Widget successfully updated for $cityName");
    } catch (e) {
      debugPrint("Error updating Prayer Home Widget: $e");
    }
  }
}
