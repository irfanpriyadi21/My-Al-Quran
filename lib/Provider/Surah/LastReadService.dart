import 'package:nb_utils/nb_utils.dart';

class LastReadService {

  /// SAVE LAST READ
  static Future<void> saveLastRead({
    required int id,
    required String name,
    required String jumlahAyat,
    required String tempatTurun,
    required String arti,
    required int ayat,
  }) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt("id", id);
    await prefs.setString("name", name);
    await prefs.setString("jumlahAyat", jumlahAyat);
    await prefs.setString("tempatTurun", tempatTurun);
    await prefs.setString("arti", arti);
    await prefs.setInt("last_ayat", ayat);
  }

  /// GET LAST READ
  static Future<Map<String, dynamic>?> getLastRead() async {

    final prefs = await SharedPreferences.getInstance();

    final id = prefs.getInt("id");
    final name = prefs.getString("name");
    final jumlahAyat = prefs.getString("jumlahAyat");
    final tempatTurun = prefs.getString("tempatTurun");
    final arti = prefs.getString("arti");
    final ayat = prefs.getInt("last_ayat");

    if (id == null) return null;

    return {
      "id": id,
      "name": name,
      "jumlahAyat": jumlahAyat ?? "",
      "tempatTurun": tempatTurun ?? "",
      "arti": arti ?? "",
      "ayat": ayat ?? 1,
    };
  }
}
