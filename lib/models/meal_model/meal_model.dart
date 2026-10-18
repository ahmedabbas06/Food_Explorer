class MealModel {
  late final String id;
  late final String name;
  late final String image;
  late final String category;
  late final String area;
  late final String instructions;
  late final List<String> ingredients;
  late final List<String> measures;
  late final List<String> tags;
  late final String youtube;
  late final String source;

  MealModel({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.area,
    required this.instructions,
    required this.ingredients,
    required this.measures,
    required this.tags,
    required this.youtube,
    required this.source,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    final rawTags = (json['strTags'] ?? '').toString().trim();
    final parsedTags = rawTags.isNotEmpty
        ? rawTags
              .split(',')
              .map((t) => t.trim())
              .where((t) => t.isNotEmpty)
              .toList()
        : <String>[];

    final List<String> parsedIngredients = [];
    final List<String> parsedMeasures = [];

    for (int i = 1; i <= 20; i++) {
      final ingredient = (json['strIngredient$i'] ?? '').toString().trim();
      if (ingredient.isNotEmpty) {
        final measure = (json['strMeasure$i'] ?? '').toString().trim();
        parsedIngredients.add(ingredient);
        parsedMeasures.add(measure);
      }
    }

    return MealModel(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      image: json['strMealThumb'] ?? '',
      category: json['strCategory'] ?? '',
      area: json['strArea'] ?? '',
      instructions: json['strInstructions'] ?? '',
      tags: parsedTags,
      youtube: json['strYoutube'] ?? '',
      source: json['strSource'] ?? '',
      ingredients: parsedIngredients,
      measures: parsedMeasures,
    );
  }
}
