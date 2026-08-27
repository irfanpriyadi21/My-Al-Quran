import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_quran/Model/model_jadwal_sholat.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class AdzanNotificationService {
  static final AdzanNotificationService _instance =
      AdzanNotificationService._internal();
  factory AdzanNotificationService() => _instance;
  AdzanNotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  // Prayer Notification IDs
  static const Map<String, int> _prayerIds = {
    'Subuh': 101,
    'Dzuhur': 102,
    'Ashar': 103,
    'Maghrib': 104,
    'Isya': 105,
    'Imsak': 106,
    'Dhuha': 107,
  };

  Future<void> initialize() async {
    if (_isInitialized) return;

    // 1. Initialize Timezone database
    tz.initializeTimeZones();
    try {
      tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));
    } catch (_) {
      try {
        final localName = DateTime.now().timeZoneName;
        tz.setLocalLocation(tz.getLocation(localName));
      } catch (_) {}
    }

    // 2. Android Initialization Settings
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    // 3. iOS Initialization Settings
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        debugPrint("Notification clicked: ${response.payload}");
      },
    );

    // 4. Create Notification Channels for Android with Raw Sound
    final androidPlugin = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidPlugin != null) {
      // Channel Adzan Umum
      const adzanChannel = AndroidNotificationChannel(
        'adzan_alarm_channel',
        'Alarm Adzan Waktu Shalat',
        description:
            'Memutar suara adzan ketika waktu shalat tiba meskipun aplikasi ditutup',
        importance: Importance.max,
        playSound: true,
        sound: RawResourceAndroidNotificationSound('adzan'),
        enableVibration: true,
      );

      // Channel Adzan Khusus Subuh
      const subuhChannel = AndroidNotificationChannel(
        'adzan_subuh_channel',
        'Alarm Adzan Khusus Subuh',
        description: 'Memutar suara adzan khusus subuh saat waktu Subuh tiba',
        importance: Importance.max,
        playSound: true,
        sound: RawResourceAndroidNotificationSound('adzan_subuh'),
        enableVibration: true,
      );

      await androidPlugin.createNotificationChannel(adzanChannel);
      await androidPlugin.createNotificationChannel(subuhChannel);

      // Request Permissions (Android 13+)
      await androidPlugin.requestNotificationsPermission();
      await androidPlugin.requestExactAlarmsPermission();
    }

    _isInitialized = true;
    debugPrint("AdzanNotificationService initialized successfully");
  }

  // Schedule exact alarms for daily prayers
  Future<void> scheduleDailyPrayerAlarms({
    required ModelJadwalSholat jadwal,
    required Map<String, bool> prayerAlarms,
    required bool isMasterEnabled,
  }) async {
    if (!_isInitialized) {
      await initialize();
    }

    // 1. Cancel previous scheduled prayer alarms
    await cancelAllPrayerAlarms();

    if (!isMasterEnabled) {
      debugPrint("Master Alarm is disabled. Skipping schedule.");
      return;
    }

    final prayerTimes = {
      'Subuh': jadwal.subuh,
      'Dzuhur': jadwal.dzuhur,
      'Ashar': jadwal.ashar,
      'Maghrib': jadwal.maghrib,
      'Isya': jadwal.isya,
    };

    final now = DateTime.now();

    for (var entry in prayerTimes.entries) {
      final prayerName = entry.key;
      final timeStr = entry.value;

      // Check if alarm is enabled for this prayer
      final isEnabled = prayerAlarms[prayerName] ?? false;
      if (!isEnabled) continue;

      final notificationId = _prayerIds[prayerName] ?? 100;

      // Parse time
      final parts = timeStr.split(':');
      if (parts.length < 2) continue;
      final hour = int.tryParse(parts[0]) ?? 0;
      final minute = int.tryParse(parts[1]) ?? 0;

      // Calculate scheduled DateTime
      var scheduledDate = DateTime(now.year, now.month, now.day, hour, minute);

      // If the time has already passed today, schedule for tomorrow
      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      final tzScheduled = tz.TZDateTime.from(scheduledDate, tz.local);

      // Choose notification sound channel
      final isSubuh = prayerName == 'Subuh';
      final channelId = isSubuh ? 'adzan_subuh_channel' : 'adzan_alarm_channel';
      final channelName = isSubuh
          ? 'Alarm Adzan Khusus Subuh'
          : 'Alarm Adzan Waktu Shalat';
      final soundName = isSubuh ? 'adzan_subuh' : 'adzan';

      final androidDetails = AndroidNotificationDetails(
        channelId,
        channelName,
        channelDescription:
            'Alarm adzan shalat $prayerName berbunyi tepat waktu',
        importance: Importance.max,
        priority: Priority.max,
        playSound: true,
        sound: RawResourceAndroidNotificationSound(soundName),
        enableVibration: true,
        vibrationPattern: Int64List.fromList([0, 1000, 500, 1000]),
        fullScreenIntent: true,
        category: AndroidNotificationCategory.alarm,
        visibility: NotificationVisibility.public,
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        sound: 'adzan.aiff',
        interruptionLevel: InterruptionLevel.timeSensitive,
      );

      final notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      try {
        await _notificationsPlugin.zonedSchedule(
          id: notificationId,
          title: "🕌 Waktu Shalat $prayerName Telah Tiba ($timeStr)",
          body: "Mari dirikan shalat $prayerName. Hayya 'alas shalaah.",
          scheduledDate: tzScheduled,
          notificationDetails: notificationDetails,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          payload: "prayer_$prayerName",
        );
        debugPrint(
          "Scheduled Adzan Alarm for $prayerName at ${tzScheduled.toString()} (ID: $notificationId)",
        );
      } catch (e) {
        debugPrint("Error scheduling alarm for $prayerName: $e");
      }
    }
  }

  // Cancel all prayer notification alarms
  Future<void> cancelAllPrayerAlarms() async {
    for (var id in _prayerIds.values) {
      await _notificationsPlugin.cancel(id: id);
    }
    debugPrint("All scheduled prayer alarms cancelled.");
  }
}
