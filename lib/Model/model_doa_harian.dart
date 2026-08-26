class ModelDoaHarian {
  final String id;
  final String title;
  final String arabic;
  final String latin;
  final String translation;

  ModelDoaHarian({
    required this.id,
    required this.title,
    required this.arabic,
    required this.latin,
    required this.translation,
  });

  factory ModelDoaHarian.fromJson(Map<String, dynamic> json, int index) {
    return ModelDoaHarian(
      id: json['id']?.toString() ?? (index + 1).toString(),
      title: (json['title'] ?? json['doa'] ?? json['judul'] ?? 'Doa Harian').toString().trim(),
      arabic: (json['arabic'] ?? json['ayat'] ?? json['doa_arab'] ?? '').toString().trim(),
      latin: (json['latin'] ?? json['latin_text'] ?? '').toString().trim(),
      translation: (json['translation'] ?? json['artinya'] ?? json['terjemahan'] ?? '').toString().trim(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'arabic': arabic,
      'latin': latin,
      'translation': translation,
    };
  }
}
