import 'dart:async';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:my_quran/Model/model_jadwal_sholat.dart';
import 'package:my_quran/Provider/Shalat/adzan_notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdzanAudioOption {
  final String id;
  final String name;
  final String description;
  final String audioUrl;

  const AdzanAudioOption({
    required this.id,
    required this.name,
    required this.description,
    required this.audioUrl,
  });
}

class AdzanAlarmService extends ChangeNotifier {
  static AdzanAlarmService _instance = AdzanAlarmService._internal();

  factory AdzanAlarmService() {
    if (_instance._disposed) {
      _instance = AdzanAlarmService._internal();
    }
    return _instance;
  }

  AdzanAlarmService._internal() {
    _disposed = false;
    _initAudioPlayer();
    _loadPreferences();
  }

  bool _disposed = false;
  late final AudioPlayer _audioPlayer;
  StreamSubscription<PlayerState>? _playerSubscription;
  ModelJadwalSholat? _lastKnownJadwal;

  bool _isMasterAlarmEnabled = true;
  bool get isMasterAlarmEnabled => _isMasterAlarmEnabled;

  // Map status alarm per waktu shalat
  final Map<String, bool> _prayerAlarms = {
    'Imsak': false,
    'Subuh': true,
    'Terbit': false,
    'Dhuha': false,
    'Dzuhur': true,
    'Ashar': true,
    'Maghrib': true,
    'Isya': true,
  };
  Map<String, bool> get prayerAlarms => _prayerAlarms;

  // Daftar Pilihan Suara Adzan (Menggunakan High-Quality Direct CDN Streams)
  static const List<AdzanAudioOption> adzanOptions = [
    AdzanAudioOption(
      id: 'makkah',
      name: 'Adzan Makkah (Masjidil Haram)',
      description: 'Lantunan adzan merdu khas Masjidil Haram Makkah',
      audioUrl: 'https://raw.githubusercontent.com/abodehq/Athan-MP3/master/Sounds/Athan%20Makkah.mp3',
    ),
    AdzanAudioOption(
      id: 'mishary',
      name: 'Adzan Syaikh Mishary Rashid Alafasy',
      description: 'Lantunan adzan syahdu & populer Syaikh Mishary Alafasy',
      audioUrl: 'https://raw.githubusercontent.com/abodehq/Athan-MP3/master/Sounds/Athan%20Mishary%20Alafasi.mp3',
    ),
    AdzanAudioOption(
      id: 'subuh',
      name: 'Adzan Khusus Subuh',
      description: 'Lafadz adzan dengan Ash-shalatu khairum minan naum',
      audioUrl: 'https://raw.githubusercontent.com/abodehq/Athan-MP3/master/Sounds/Athan%20Al-fajer%20-%20Malek%20chebae.mp3',
    ),
    AdzanAudioOption(
      id: 'qatami',
      name: 'Adzan Syaikh Nasser Al-Qatami',
      description: 'Lantunan adzan indah khas Syaikh Nasser Al-Qatami',
      audioUrl: 'https://raw.githubusercontent.com/abodehq/Athan-MP3/master/Sounds/Athan%20Nasser%20Alqatami.mp3',
    ),
  ];

  String _selectedAdzanId = 'makkah';
  String get selectedAdzanId => _selectedAdzanId;

  AdzanAudioOption get selectedAdzanOption =>
      adzanOptions.firstWhere((o) => o.id == _selectedAdzanId, orElse: () => adzanOptions.first);

  // Audio Player State
  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _currentlyPlayingPrayer;
  String? get currentlyPlayingPrayer => _currentlyPlayingPrayer;

  String? _lastTriggeredKey; // e.g. "2026-08-27_Maghrib" to prevent retriggering in the same minute

  void _initAudioPlayer() {
    _audioPlayer = AudioPlayer();

    // Set Audio context for proper speaker playback on Android/iOS
    AudioPlayer.global.setAudioContext(
      const AudioContext(
        android: AudioContextAndroid(
          isSpeakerphoneOn: true,
          stayAwake: true,
          contentType: AndroidContentType.music,
          usageType: AndroidUsageType.media,
          audioFocus: AndroidAudioFocus.gainTransientMayDuck,
        ),
        iOS: AudioContextIOS(
          category: AVAudioSessionCategory.playback,
          options: [
            AVAudioSessionOptions.duckOthers,
            AVAudioSessionOptions.defaultToSpeaker,
          ],
        ),
      ),
    );

    _playerSubscription = _audioPlayer.onPlayerStateChanged.listen((state) {
      if (_disposed) return;
      _isPlaying = state == PlayerState.playing;
      if (state == PlayerState.playing) {
        _isLoading = false;
      }
      if (state == PlayerState.completed || state == PlayerState.stopped) {
        _currentlyPlayingPrayer = null;
        _isLoading = false;
      }
      notifyListeners();
    });
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _playerSubscription?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _isMasterAlarmEnabled = prefs.getBool('adzan_master_enabled') ?? true;
    _selectedAdzanId = prefs.getString('adzan_selected_audio') ?? 'makkah';

    for (var key in _prayerAlarms.keys) {
      final val = prefs.getBool('adzan_alarm_$key');
      if (val != null) {
        _prayerAlarms[key] = val;
      }
    }

    final cachedSchedule = prefs.getString('sholat_last_jadwal_cache');
    if (cachedSchedule != null && _lastKnownJadwal == null) {
      try {
        final map = json.decode(cachedSchedule);
        _lastKnownJadwal = ModelJadwalSholat.fromJson(map);
      } catch (_) {}
    }

    notifyListeners();
    _rescheduleBackgroundAlarms();
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('adzan_master_enabled', _isMasterAlarmEnabled);
    await prefs.setString('adzan_selected_audio', _selectedAdzanId);

    for (var entry in _prayerAlarms.entries) {
      await prefs.setBool('adzan_alarm_${entry.key}', entry.value);
    }
    _rescheduleBackgroundAlarms();
  }

  // Update jadwal shalat terbaru dan jadwalkan alarm background OS
  void updatePrayerSchedule(ModelJadwalSholat jadwal) {
    _lastKnownJadwal = jadwal;
    _rescheduleBackgroundAlarms();
  }

  // Menjadwalkan ulang alarm sistem operasi untuk background saat aplikasi ditutup
  void _rescheduleBackgroundAlarms() {
    if (_lastKnownJadwal != null) {
      AdzanNotificationService().scheduleDailyPrayerAlarms(
        jadwal: _lastKnownJadwal!,
        prayerAlarms: _prayerAlarms,
        isMasterEnabled: _isMasterAlarmEnabled,
      );
    }
  }

  // Toggle alarm untuk waktu shalat tertentu
  void togglePrayerAlarm(String prayerName) {
    if (_prayerAlarms.containsKey(prayerName)) {
      _prayerAlarms[prayerName] = !(_prayerAlarms[prayerName] ?? false);
      _savePreferences();
      notifyListeners();
    }
  }

  bool isAlarmActiveFor(String prayerName) {
    if (!_isMasterAlarmEnabled) return false;
    return _prayerAlarms[prayerName] ?? false;
  }

  // Toggle Master Switch
  void toggleMasterAlarm(bool value) {
    _isMasterAlarmEnabled = value;
    _savePreferences();
    notifyListeners();
  }

  // Ubah pilihan jenis suara adzan
  void selectAdzanAudio(String audioId) {
    _selectedAdzanId = audioId;
    _savePreferences();
    notifyListeners();
  }

  // Putar Adzan
  Future<void> playAdzan({String? prayerName, String? customUrl}) async {
    try {
      _isLoading = true;
      _currentlyPlayingPrayer = prayerName ?? "Uji Coba Suara";
      notifyListeners();

      await _audioPlayer.stop();
      await _audioPlayer.setVolume(1.0);

      // Pilih audio: jika waktu Subuh dan tidak ada customUrl, pakai adzan subuh
      String url = customUrl ?? selectedAdzanOption.audioUrl;
      if (prayerName == 'Subuh' && customUrl == null) {
        final subuhOption = adzanOptions.firstWhere((o) => o.id == 'subuh', orElse: () => selectedAdzanOption);
        url = subuhOption.audioUrl;
      }

      await _audioPlayer.play(UrlSource(url));
      _isPlaying = true;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint("Error playAdzan: $e");
      _isPlaying = false;
      _isLoading = false;
      _currentlyPlayingPrayer = null;
      notifyListeners();
    }
  }

  // Hentikan Adzan
  Future<void> stopAdzan() async {
    try {
      await _audioPlayer.stop();
      _isPlaying = false;
      _isLoading = false;
      _currentlyPlayingPrayer = null;
      notifyListeners();
    } catch (e) {
      debugPrint("Error stopAdzan: $e");
    }
  }

  // Cek waktu shalat saat ini untuk memicu alarm adzan otomatis (saat aplikasi foreground)
  String? checkPrayerTimeMatch(DateTime now, ModelJadwalSholat jadwal) {
    if (!_isMasterAlarmEnabled) return null;

    final currentHourMin =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
    final todayStr = "${now.year}-${now.month}-${now.day}";

    final prayerTimes = {
      'Imsak': jadwal.imsak,
      'Subuh': jadwal.subuh,
      'Terbit': jadwal.terbit,
      'Dhuha': jadwal.dhuha,
      'Dzuhur': jadwal.dzuhur,
      'Ashar': jadwal.ashar,
      'Maghrib': jadwal.maghrib,
      'Isya': jadwal.isya,
    };

    for (var entry in prayerTimes.entries) {
      final prayerName = entry.key;
      final prayerTime = entry.value;

      if (prayerTime == currentHourMin) {
        final triggerKey = "${todayStr}_${prayerName}_$prayerTime";
        if (_lastTriggeredKey != triggerKey) {
          _lastTriggeredKey = triggerKey;
          if (isAlarmActiveFor(prayerName)) {
            return prayerName;
          }
        }
      }
    }
    return null;
  }
}
