class ModelHaditsItem {
  final int number;
  final String arab;
  final String translation;

  ModelHaditsItem({
    required this.number,
    required this.arab,
    required this.translation,
  });

  factory ModelHaditsItem.fromJson(Map<String, dynamic> json) {
    return ModelHaditsItem(
      number: (json['number'] is num)
          ? (json['number'] as num).toInt()
          : int.tryParse(json['number']?.toString() ?? '0') ?? 0,
      arab: (json['arab'] ?? json['arabic'] ?? json['text_arab'] ?? '').toString().trim(),
      translation: (json['id'] ?? json['translation'] ?? json['terjemahan'] ?? json['text_id'] ?? '').toString().trim(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'arab': arab,
      'id': translation,
    };
  }
}
