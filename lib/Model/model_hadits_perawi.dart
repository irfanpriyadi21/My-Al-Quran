class ModelHaditsPerawi {
  final String name;
  final String slug;
  final int total;

  ModelHaditsPerawi({
    required this.name,
    required this.slug,
    required this.total,
  });

  factory ModelHaditsPerawi.fromJson(Map<String, dynamic> json) {
    return ModelHaditsPerawi(
      name: json['name']?.toString() ?? '',
      slug: json['slug']?.toString() ?? '',
      total: (json['total'] is num) ? (json['total'] as num).toInt() : int.tryParse(json['total']?.toString() ?? '0') ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'slug': slug,
      'total': total,
    };
  }
}
