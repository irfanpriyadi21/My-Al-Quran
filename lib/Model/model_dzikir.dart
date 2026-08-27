class ModelDzikir {
  final String id;
  final String title;
  final String arabic;
  final String latin;
  final String translation;
  final int repeatCount;
  final String fadhilah;
  final String? riwayat;

  const ModelDzikir({
    required this.id,
    required this.title,
    required this.arabic,
    required this.latin,
    required this.translation,
    this.repeatCount = 1,
    this.fadhilah = '',
    this.riwayat,
  });
}

class ModelTasbihPreset {
  final String id;
  final String title;
  final String arabic;
  final String latin;
  final String translation;
  final int defaultTarget;

  const ModelTasbihPreset({
    required this.id,
    required this.title,
    required this.arabic,
    required this.latin,
    required this.translation,
    this.defaultTarget = 33,
  });
}
