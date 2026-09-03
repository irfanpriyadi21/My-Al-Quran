import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:my_quran/Componen/navigatorKey.dart';
import 'package:my_quran/Model/model_jadwal_sholat.dart';
import 'package:my_quran/Page/Shalat/adzan_player_dialog.dart';
import 'package:my_quran/Provider/Shalat/AdzanAlarmService.dart';
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

  // Test Notification ID
  static const int _testNotificationId = 999;

  // Channel IDs (v3 to force refresh stale OS cached channel configurations)
  static const String _channelAdzanId = 'adzan_alarm_channel_v3';
  static const String _channelSubuhId = 'adzan_subuh_channel_v3';

  // Explicit Vibration Pattern for strong vibration feedback
  static final Int64List adzanVibrationPattern = Int64List.fromList([
    0,
    1000,
    500,
    1000,
    500,
    1000,
    500,
    1000,
    500,
    1000,
  ]);

  Future<void> initialize() async {
    if (kIsWeb) return;
    if (_isInitialized) return;

    // 1. Initialize Timezone database with device local detection
    tz.initializeTimeZones();
    try {
      final offset = DateTime.now().timeZoneOffset;
      if (offset.inHours == 7) {
        tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));
      } else if (offset.inHours == 8) {
        tz.setLocalLocation(tz.getLocation('Asia/Makassar'));
      } else if (offset.inHours == 9) {
        tz.setLocalLocation(tz.getLocation('Asia/Jayapura'));
      } else {
        final localName = DateTime.now().timeZoneName;
        tz.setLocalLocation(tz.getLocation(localName));
      }
    } catch (_) {
      try {
        tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));
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
        debugPrint("Notification clicked with payload: ${response.payload}");
        _handleNotificationTap(response.payload);
      },
    );

    // 4. Create & Clean Up Notification Channels on Android
    final androidPlugin = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidPlugin != null) {
      // Clean up previous obsolete channels so OS resets stale cache
      try {
        await androidPlugin.deleteNotificationChannel(channelId: 'adzan_alarm_channel');
        await androidPlugin.deleteNotificationChannel(channelId: 'adzan_alarm_channel_v2');
        await androidPlugin.deleteNotificationChannel(channelId: 'adzan_subuh_channel');
        await androidPlugin.deleteNotificationChannel(channelId: 'adzan_subuh_channel_v2');
      } catch (_) {}

      // Channel Adzan Umum
      final adzanChannel = AndroidNotificationChannel(
        _channelAdzanId,
        'Alarm Adzan Waktu Shalat',
        description:
            'Memutar suara adzan ketika waktu shalat tiba meskipun aplikasi ditutup',
        importance: Importance.max,
        playSound: true,
        sound: const RawResourceAndroidNotificationSound('adzan'),
        enableVibration: true,
        vibrationPattern: adzanVibrationPattern,
        audioAttributesUsage: AudioAttributesUsage.alarm,
        enableLights: true,
        ledColor: const Color(0xFF9543FF),
        showBadge: true,
      );

      // Channel Adzan Khusus Subuh
      final subuhChannel = AndroidNotificationChannel(
        _channelSubuhId,
        'Alarm Adzan Khusus Subuh',
        description: 'Memutar suara adzan khusus subuh saat waktu Subuh tiba',
        importance: Importance.max,
        playSound: true,
        sound: const RawResourceAndroidNotificationSound('adzan_subuh'),
        enableVibration: true,
        vibrationPattern: adzanVibrationPattern,
        audioAttributesUsage: AudioAttributesUsage.alarm,
        enableLights: true,
        ledColor: const Color(0xFF9543FF),
        showBadge: true,
      );

      await androidPlugin.createNotificationChannel(adzanChannel);
      await androidPlugin.createNotificationChannel(subuhChannel);

      // Request Permissions (Android 13+)
      try {
        await androidPlugin.requestNotificationsPermission();
        await androidPlugin.requestExactAlarmsPermission();
      } catch (_) {}
    }

    // 5. Handle App Launch from Notification Tap
    try {
      final launchDetails =
          await _notificationsPlugin.getNotificationAppLaunchDetails();
      if (launchDetails?.didNotificationLaunchApp ?? false) {
        final payload = launchDetails?.notificationResponse?.payload;
        if (payload != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(const Duration(milliseconds: 600), () {
              _handleNotificationTap(payload);
            });
          });
        }
      }
    } catch (_) {}

    _isInitialized = true;
    debugPrint("AdzanNotificationService v3 initialized successfully");
  }

  // Handle tap on notification
  void _handleNotificationTap(String? payload) {
    if (payload == null) return;

    if (payload.startsWith('prayer_')) {
      final prayerName = payload.replaceFirst('prayer_', '');
      final context = NavigationService.navigatorKey.currentContext;
      if (context != null) {
        AdzanAlarmService().playAdzan(prayerName: prayerName);
        final nowStr = DateFormat('HH:mm').format(DateTime.now());
        AdzanPlayerDialog.show(
          context,
          prayerName: prayerName,
          prayerTime: nowStr,
        );
      }
    }
  }

  Future<void> scheduleDailyPrayerAlarms({
    required ModelJadwalSholat jadwal,
    required Map<String, bool> prayerAlarms,
    required bool isMasterEnabled,
    bool isVibrationEnabled = true,
  }) async {
    if (kIsWeb) return;
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

    final nowLocal = tz.TZDateTime.now(tz.local);

    final androidPlugin = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    bool canExact = true;
    try {
      final exactStatus = await androidPlugin?.canScheduleExactNotifications();
      if (exactStatus != null) {
        canExact = exactStatus;
      }
    } catch (_) {}

    final scheduleMode = canExact
        ? AndroidScheduleMode.exactAllowWhileIdle
        : AndroidScheduleMode.inexactAllowWhileIdle;

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

      // Calculate scheduled TZDateTime directly in local timezone
      var scheduledDate = tz.TZDateTime(
        tz.local,
        nowLocal.year,
        nowLocal.month,
        nowLocal.day,
        hour,
        minute,
      );

      // If the time has already passed today, schedule for tomorrow at the exact time
      if (scheduledDate.isBefore(nowLocal)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      // Choose notification sound channel
      final isSubuh = prayerName == 'Subuh';
      final channelId = isSubuh ? _channelSubuhId : _channelAdzanId;
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
        enableVibration: isVibrationEnabled,
        vibrationPattern: isVibrationEnabled ? adzanVibrationPattern : null,
        fullScreenIntent: true,
        category: AndroidNotificationCategory.alarm,
        audioAttributesUsage: AudioAttributesUsage.alarm,
        visibility: NotificationVisibility.public,
        color: const Color(0xFF9543FF),
        ledColor: const Color(0xFF9543FF),
        ledOnMs: 1000,
        ledOffMs: 500,
        ticker: "Waktu shalat $prayerName telah tiba",
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
          scheduledDate: scheduledDate,
          notificationDetails: notificationDetails,
          androidScheduleMode: scheduleMode,
          payload: "prayer_$prayerName",
        );
        debugPrint(
          "Scheduled Exact Background Adzan for $prayerName at ${scheduledDate.toString()} (ID: $notificationId, Mode: $scheduleMode)",
        );
      } catch (e) {
        debugPrint("Error scheduling alarm for $prayerName: $e");
      }
    }
  }

  Future<void> testNotificationNow({
    bool isSubuh = false,
    bool isVibrationEnabled = true,
  }) async {
    if (kIsWeb) return;
    if (!_isInitialized) {
      await initialize();
    }

    final channelId = isSubuh ? _channelSubuhId : _channelAdzanId;
    final channelName = isSubuh
        ? 'Alarm Adzan Khusus Subuh'
        : 'Alarm Adzan Waktu Shalat';
    final soundName = isSubuh ? 'adzan_subuh' : 'adzan';
    final prayerName = isSubuh ? 'Subuh' : 'Dzuhur';

    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: 'Uji coba alarm adzan shalat dan getaran sistem',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      sound: RawResourceAndroidNotificationSound(soundName),
      enableVibration: isVibrationEnabled,
      vibrationPattern: isVibrationEnabled ? adzanVibrationPattern : null,
      fullScreenIntent: true,
      category: AndroidNotificationCategory.alarm,
      audioAttributesUsage: AudioAttributesUsage.alarm,
      visibility: NotificationVisibility.public,
      color: const Color(0xFF9543FF),
      ledColor: const Color(0xFF9543FF),
      ledOnMs: 1000,
      ledOffMs: 500,
      ticker: "Uji Coba Alarm Adzan",
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

    await _notificationsPlugin.show(
      id: _testNotificationId,
      title: "🕌 [Uji Coba] Alarm Adzan & Getaran Berhasil",
      body:
          "Notifikasi alarm adzan aktif! Suara alarm dan getaran perangkat berfungsi normal.",
      notificationDetails: notificationDetails,
      payload: "prayer_$prayerName",
    );
  }

  // Cancel all prayer notification alarms
  Future<void> cancelAllPrayerAlarms() async {
    if (kIsWeb) return;
    for (var id in _prayerIds.values) {
      await _notificationsPlugin.cancel(id: id);
    }
    await _notificationsPlugin.cancel(id: _testNotificationId);
    debugPrint("All scheduled prayer alarms cancelled.");
  }
}
