class ModelQuotesIslami {
  final String id;
  final String quote;
  final String? arabic;
  final String source;
  final String category;
  final String categoryName;
  final List<int> gradientColors;

  const ModelQuotesIslami({
    required this.id,
    required this.quote,
    this.arabic,
    required this.source,
    required this.category,
    required this.categoryName,
    this.gradientColors = const [0xFF8E2DE2, 0xFF4A00E0],
  });
}
