import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../../Model/ModelListAyat.dart';

class QuranAudioProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();

  PlayerState _playerState = PlayerState.stopped;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool _isLoading = false;
  bool _isPlayerVisible = false;

  int? _currentSurahId;
  String _currentSurahName = '';
  int _currentIndex = 0;
  List<Ayat> _ayatList = [];

  String _selectedQori = '01';
  double _playbackSpeed = 1.0;
  bool _autoPlayNext = true;

  StreamSubscription? _playerStateSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _playerCompleteSubscription;

  // Reciters list
  final Map<String, String> qoriList = {
    '01': 'Abdullah Al-Juhany',
    '02': 'Abdul Muhsin Al-Qasim',
    '03': 'Abdurrahman as-Sudais',
    '04': 'Ibrahim Al-Dossari',
    '05': 'Misyari Rasyid Al-\'Afasy',
  };

  QuranAudioProvider() {
    _initAudioPlayer();
  }

  void _initAudioPlayer() {
    _playerStateSubscription = _audioPlayer.onPlayerStateChanged.listen((state) {
      _playerState = state;
      notifyListeners();
    });

    _positionSubscription = _audioPlayer.onPositionChanged.listen((pos) {
      _position = pos;
      notifyListeners();
    });

    _durationSubscription = _audioPlayer.onDurationChanged.listen((dur) {
      _duration = dur;
      notifyListeners();
    });

    _playerCompleteSubscription = _audioPlayer.onPlayerComplete.listen((_) {
      _onAudioCompleted();
    });
  }

  // Getters
  bool get isPlaying => _playerState == PlayerState.playing;
  bool get isPaused => _playerState == PlayerState.paused;
  bool get isStopped =>
      _playerState == PlayerState.stopped || _playerState == PlayerState.completed;
  bool get isLoading => _isLoading;
  bool get isPlayerVisible => _isPlayerVisible;
  PlayerState get playerState => _playerState;

  Duration get position => _position;
  Duration get duration => _duration;

  int? get currentSurahId => _currentSurahId;
  String get currentSurahName => _currentSurahName;
  int get currentIndex => _currentIndex;
  List<Ayat> get ayatList => _ayatList;

  String get selectedQori => _selectedQori;
  String get selectedQoriName => qoriList[_selectedQori] ?? 'Abdullah Al-Juhany';
  double get playbackSpeed => _playbackSpeed;
  bool get autoPlayNext => _autoPlayNext;

  Ayat? get currentAyat =>
      (_ayatList.isNotEmpty && _currentIndex >= 0 && _currentIndex < _ayatList.length)
          ? _ayatList[_currentIndex]
          : null;

  int get currentAyatNumber => currentAyat?.nomorAyat ?? 0;
  bool get hasNext => _currentIndex + 1 < _ayatList.length;
  bool get hasPrevious => _currentIndex > 0;

  bool isAyatPlaying(int surahId, int nomorAyat) {
    return isPlaying && _currentSurahId == surahId && currentAyatNumber == nomorAyat;
  }

  bool isAyatActive(int surahId, int nomorAyat) {
    return _isPlayerVisible && _currentSurahId == surahId && currentAyatNumber == nomorAyat;
  }

  String? getAudioUrlForAyat(Ayat ayat, String qoriKey) {
    if (ayat.audio == null) return null;
    switch (qoriKey) {
      case '01':
        return ayat.audio?.s01 ??
            ayat.audio?.s02 ??
            ayat.audio?.s03 ??
            ayat.audio?.s04 ??
            ayat.audio?.s05 ??
            ayat.audio?.s06;
      case '02':
        return ayat.audio?.s02 ??
            ayat.audio?.s01 ??
            ayat.audio?.s03 ??
            ayat.audio?.s04 ??
            ayat.audio?.s05 ??
            ayat.audio?.s06;
      case '03':
        return ayat.audio?.s03 ??
            ayat.audio?.s01 ??
            ayat.audio?.s02 ??
            ayat.audio?.s04 ??
            ayat.audio?.s05 ??
            ayat.audio?.s06;
      case '04':
        return ayat.audio?.s04 ??
            ayat.audio?.s01 ??
            ayat.audio?.s02 ??
            ayat.audio?.s03 ??
            ayat.audio?.s05 ??
            ayat.audio?.s06;
      case '05':
        return ayat.audio?.s05 ??
            ayat.audio?.s01 ??
            ayat.audio?.s02 ??
            ayat.audio?.s03 ??
            ayat.audio?.s04 ??
            ayat.audio?.s06;
      default:
        return ayat.audio?.s01 ??
            ayat.audio?.s02 ??
            ayat.audio?.s03 ??
            ayat.audio?.s04 ??
            ayat.audio?.s05 ??
            ayat.audio?.s06;
    }
  }

  Future<void> playAyat({
    required int surahId,
    required String surahName,
    required List<Ayat> ayatList,
    required int index,
    String? qoriKey,
  }) async {
    if (ayatList.isEmpty || index < 0 || index >= ayatList.length) return;

    _currentSurahId = surahId;
    _currentSurahName = surahName;
    _ayatList = ayatList;
    _currentIndex = index;
    if (qoriKey != null) {
      _selectedQori = qoriKey;
    }

    final ayat = _ayatList[_currentIndex];
    final audioUrl = getAudioUrlForAyat(ayat, _selectedQori);

    if (audioUrl == null || audioUrl.isEmpty) {
      debugPrint("Audio URL not found for Ayat ${ayat.nomorAyat}");
      return;
    }

    _isPlayerVisible = true;
    _isLoading = true;
    _position = Duration.zero;
    notifyListeners();

    try {
      await _audioPlayer.stop();
      await _audioPlayer.setPlaybackRate(_playbackSpeed);
      await _audioPlayer.play(UrlSource(audioUrl));
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      debugPrint("Error playing audio: $e");
      notifyListeners();
    }
  }

  Future<void> togglePlayPause() async {
    if (isPlaying) {
      await pause();
    } else if (isPaused) {
      await resume();
    } else if (currentAyat != null && _currentSurahId != null) {
      await playAyat(
        surahId: _currentSurahId!,
        surahName: _currentSurahName,
        ayatList: _ayatList,
        index: _currentIndex,
      );
    }
  }

  Future<void> pause() async {
    try {
      await _audioPlayer.pause();
    } catch (e) {
      debugPrint("Error pausing audio: $e");
    }
  }

  Future<void> resume() async {
    try {
      await _audioPlayer.resume();
    } catch (e) {
      debugPrint("Error resuming audio: $e");
    }
  }

  Future<void> stop() async {
    try {
      await _audioPlayer.stop();
      _position = Duration.zero;
      _playerState = PlayerState.stopped;
      notifyListeners();
    } catch (e) {
      debugPrint("Error stopping audio: $e");
    }
  }

  Future<void> closePlayer() async {
    await stop();
    _isPlayerVisible = false;
    notifyListeners();
  }

  Future<void> seek(Duration newPosition) async {
    try {
      await _audioPlayer.seek(newPosition);
    } catch (e) {
      debugPrint("Error seeking audio: $e");
    }
  }

  Future<void> nextAyat() async {
    if (hasNext && _currentSurahId != null) {
      await playAyat(
        surahId: _currentSurahId!,
        surahName: _currentSurahName,
        ayatList: _ayatList,
        index: _currentIndex + 1,
      );
    }
  }

  Future<void> previousAyat() async {
    if (_position.inSeconds > 3) {
      await seek(Duration.zero);
      return;
    }

    if (hasPrevious && _currentSurahId != null) {
      await playAyat(
        surahId: _currentSurahId!,
        surahName: _currentSurahName,
        ayatList: _ayatList,
        index: _currentIndex - 1,
      );
    } else {
      await seek(Duration.zero);
    }
  }

  Future<void> setPlaybackSpeed(double speed) async {
    _playbackSpeed = speed;
    try {
      await _audioPlayer.setPlaybackRate(speed);
      notifyListeners();
    } catch (e) {
      debugPrint("Error setting playback rate: $e");
    }
  }

  Future<void> setQori(String qoriKey) async {
    if (_selectedQori == qoriKey) return;
    _selectedQori = qoriKey;
    notifyListeners();

    if (_isPlayerVisible && currentAyat != null && _currentSurahId != null) {
      final wasPlaying = isPlaying;
      await playAyat(
        surahId: _currentSurahId!,
        surahName: _currentSurahName,
        ayatList: _ayatList,
        index: _currentIndex,
        qoriKey: qoriKey,
      );
      if (!wasPlaying) {
        await pause();
      }
    }
  }

  void toggleAutoPlay() {
    _autoPlayNext = !_autoPlayNext;
    notifyListeners();
  }

  void _onAudioCompleted() {
    _position = Duration.zero;
    if (_autoPlayNext && hasNext) {
      nextAyat();
    } else {
      _playerState = PlayerState.completed;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _playerStateSubscription?.cancel();
    _positionSubscription?.cancel();
    _durationSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }
}
