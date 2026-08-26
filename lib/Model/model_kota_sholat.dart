class ModelKotaSholat {
  final String id;
  final String lokasi;

  ModelKotaSholat({
    required this.id,
    required this.lokasi,
  });

  factory ModelKotaSholat.fromJson(Map<String, dynamic> json) {
    return ModelKotaSholat(
      id: json['id']?.toString() ?? '',
      lokasi: json['lokasi']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lokasi': lokasi,
    };
  }
}
