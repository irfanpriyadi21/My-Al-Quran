import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_quran/Model/model_jadwal_sholat.dart';
import 'package:my_quran/Model/model_kota_sholat.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../url_api.dart';

class ShalatApi with ChangeNotifier {
  List<ModelKotaSholat> listKota = [];
  ModelKotaSholat? selectedKota;
  ModelJadwalSholat? jadwalToday;
  DateTime selectedDate = DateTime.now();

  bool isLoading = false;
  bool isLoadingKota = false;
  String errorMessage = '';

  // 1. Inisialisasi Lokasi & Jadwal Shalat
  Future<void> initLocationAndSchedule() async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final savedId = prefs.getString('sholat_city_id');
      final savedName = prefs.getString('sholat_city_name');

      // Ambil daftar semua kota jika belum ada
      if (listKota.isEmpty) {
        await getAllKota(silent: true);
      }

      if (savedId != null && savedName != null) {
        selectedKota = ModelKotaSholat(id: savedId, lokasi: savedName);
      } else {
        // Deteksi lokasi via IP Geolocation
        await _detectLocationFromIp();
      }

      // Default jika masih null (Jakarta)
      selectedKota ??= ModelKotaSholat(id: "1301", lokasi: "KOTA JAKARTA");

      // Ambil jadwal shalat
      await getJadwal(selectedKota!.id, selectedDate);
    } catch (e) {
      errorMessage = 'Gagal memuat jadwal shalat: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // 2. Deteksi Lokasi Otomatis via IP
  Future<void> _detectLocationFromIp() async {
    try {
      final res = await http
          .get(Uri.parse(UrlApi.ipGeolocation))
          .timeout(const Duration(seconds: 6));

      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        final cityName = (data['city'] ?? data['regionName'] ?? '').toString().toUpperCase();

        if (cityName.isNotEmpty && listKota.isNotEmpty) {
          // Cari kota yang cocok di listKota
          final match = listKota.firstWhere(
            (k) => k.lokasi.toUpperCase().contains(cityName) || cityName.contains(k.lokasi.toUpperCase().replaceAll('KOTA ', '').replaceAll('KAB. ', '')),
            orElse: () => listKota.firstWhere(
              (k) => k.lokasi.contains("JAKARTA"),
              orElse: () => ModelKotaSholat(id: "1301", lokasi: "KOTA JAKARTA"),
            ),
          );
          selectedKota = match;
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('sholat_city_id', match.id);
          await prefs.setString('sholat_city_name', match.lokasi);
        }
      }
    } catch (_) {}
  }

  // 3. Ambil Daftar Semua Kota / Kabupaten
  Future<void> getAllKota({bool silent = false}) async {
    if (!silent) {
      isLoadingKota = true;
      notifyListeners();
    }

    try {
      final res = await http
          .get(Uri.parse(UrlApi.sholatKotaSemua))
          .timeout(const Duration(seconds: 10));

      if (res.statusCode == 200) {
        final decoded = json.decode(res.body);
        if (decoded['status'] == true && decoded['data'] is List) {
          final List raw = decoded['data'];
          listKota = raw
              .map((e) => ModelKotaSholat.fromJson(e as Map<String, dynamic>))
              .toList();
        }
      }
    } catch (_) {} finally {
      if (!silent) {
        isLoadingKota = false;
        notifyListeners();
      }
    }
  }

  // 4. Pilih Kota Baru
  Future<void> selectCity(ModelKotaSholat kota) async {
    selectedKota = kota;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('sholat_city_id', kota.id);
    await prefs.setString('sholat_city_name', kota.lokasi);

    await getJadwal(kota.id, selectedDate);
  }

  // 5. Ubah Tanggal
  Future<void> selectDate(DateTime date) async {
    selectedDate = date;
    notifyListeners();

    if (selectedKota != null) {
      await getJadwal(selectedKota!.id, selectedDate);
    }
  }

  // 6. Ambil Jadwal Shalat Berdasarkan ID Kota & Tanggal
  Future<void> getJadwal(String cityId, DateTime date) async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    final year = date.year;
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

    final url = "${UrlApi.sholatJadwal}/$cityId/$year/$month/$day";
    try {
      final res = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));

      if (res.statusCode == 200) {
        final decoded = json.decode(res.body);
        if (decoded['status'] == true && decoded['data'] != null) {
          final jadwalData = decoded['data']['jadwal'];
          if (jadwalData != null) {
            jadwalToday = ModelJadwalSholat.fromJson(jadwalData);
          }
        } else {
          errorMessage = 'Jadwal shalat tidak ditemukan untuk tanggal ini.';
        }
      } else {
        errorMessage = 'Gagal memuat jadwal shalat (Status ${res.statusCode}).';
      }
    } catch (e) {
      errorMessage = 'Koneksi bermasalah saat memuat jadwal shalat.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}