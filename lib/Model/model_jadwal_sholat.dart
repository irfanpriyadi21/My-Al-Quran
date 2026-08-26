class ModelJadwalSholat {
  final String tanggal;
  final String imsak;
  final String subuh;
  final String terbit;
  final String dhuha;
  final String dzuhur;
  final String ashar;
  final String maghrib;
  final String isya;
  final String date;

  ModelJadwalSholat({
    required this.tanggal,
    required this.imsak,
    required this.subuh,
    required this.terbit,
    required this.dhuha,
    required this.dzuhur,
    required this.ashar,
    required this.maghrib,
    required this.isya,
    required this.date,
  });

  factory ModelJadwalSholat.fromJson(Map<String, dynamic> json) {
    return ModelJadwalSholat(
      tanggal: json['tanggal']?.toString() ?? '',
      imsak: json['imsak']?.toString() ?? '--:--',
      subuh: json['subuh']?.toString() ?? '--:--',
      terbit: json['terbit']?.toString() ?? '--:--',
      dhuha: json['dhuha']?.toString() ?? '--:--',
      dzuhur: json['dzuhur']?.toString() ?? '--:--',
      ashar: json['ashar']?.toString() ?? '--:--',
      maghrib: json['maghrib']?.toString() ?? '--:--',
      isya: json['isya']?.toString() ?? '--:--',
      date: json['date']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tanggal': tanggal,
      'imsak': imsak,
      'subuh': subuh,
      'terbit': terbit,
      'dhuha': dhuha,
      'dzuhur': dzuhur,
      'ashar': ashar,
      'maghrib': maghrib,
      'isya': isya,
      'date': date,
    };
  }
}
