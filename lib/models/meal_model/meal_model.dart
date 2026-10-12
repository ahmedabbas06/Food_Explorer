class MealModel {
  late final String id;
  late final String name;
  late final String image;
  late final String category;
  late final String area;
  late final String instructions;
  late final List<String> ingredients;
  late final List<String> measures;

  MealModel({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.area,
    required this.instructions,
    required this.ingredients,
    required this.measures,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      image: json['strMealThumb'] ?? '',
      category: json['strCategory'] ?? '',
      area: json['strArea'] ?? '',
      instructions: json['strInstructions'] ?? '',
      ingredients: [
        for (int i = 1; i <= 20; i++)
          if ((json['strIngredient$i'] ?? '').toString().trim().isNotEmpty)
            json['strIngredient$i'].toString().trim(),
      ],
      measures: [
        for (int i = 1; i <= 20; i++)
          if ((json['strMeasure$i'] ?? '').toString().trim().isNotEmpty)
            json['strMeasure$i'].toString().trim(),
      ],
    );
  }
}