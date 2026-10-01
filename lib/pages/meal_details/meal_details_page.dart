import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_explorer/models/meal_model/meal_model.dart';

import '../../api_service/meal_api/meal_api.dart';
import '../favourate/favourate_page.dart';

class MealDetailsPage extends StatefulWidget {
  final MealModel meal;

  const MealDetailsPage({super.key, required this.meal});

  @override
  State<MealDetailsPage> createState() => _MealDetailsPageState();
}

class _MealDetailsPageState extends State<MealDetailsPage> {
  late List<String> steps;

  MealModel? mealDetails;
  bool isLoading = true;

  final MealApi mealApi = MealApi();

  bool isFavorite = false;

  @override
  void initState() {
    super.initState();

    steps = widget.meal.instructions
        .split(RegExp(r'\r?\n|\.'))
        .map((step) => step.trim())
        .where((step) => step.isNotEmpty)
        .toList();

    getMealDetails();
  }

  Future<void> getMealDetails() async {
    try {
      final details = await mealApi.getMealDetails(widget.meal.id);

      if (!mounted) return;

      setState(() {
        mealDetails = details;
        isLoading = false;

        if (details != null) {
          steps = details.instructions
              .split(RegExp(r'\r?\n|\.'))
              .map((step) => step.trim())
              .where((step) => step.isNotEmpty)
              .toList();
        }
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });
    }
  }

  String getIngredientImage(String ingredient) {
    final name = ingredient.trim().replaceAll(' ', '%20');

    return 'https://www.themealdb.com/images/ingredients/$name-Small.png';
  }

  Widget buildIngredientCard(String ingredient, String measure) {
    return Expanded(
      child: Container(
        height: 120,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xff1f1f22),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                getIngredientImage(ingredient),
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 70,
                    height: 70,
                    color: Color(0xff2a2a2d),
                    child: Icon(
                      Icons.restaurant,
                      color: Color(0xfffab65d),
                      size: 30,
                    ),
                  );
                },
              ),
            ),

            SizedBox(width: 10),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Text(
                      ingredient,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  SizedBox(height: 5),

                  FittedBox(
                    child: Text(
                      measure,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xfffab65d),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // STEP CARD
  // =========================

  Widget buildStepCard(int index, String step) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Color(0xffff6e00),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  "${index + 1}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            if (index != steps.length - 1)
              Container(
                width: 3,
                height: 90,
                margin: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: Color(0xff4b2d1b),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
          ],
        ),

        SizedBox(width: 15),

        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: 15),
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Color(0xff1f1f22),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Color(0xff302f32), width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Step ${index + 1}",
                  style: TextStyle(
                    color: Color(0xffff6e00),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  step,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final MealModel currentMeal = mealDetails ?? widget.meal;

    return Scaffold(
      backgroundColor: Color(0xff131316),

      appBar: AppBar(
        backgroundColor: Color(0xff131316),

        title: Text(
          "Food Details",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),

        leading: IconButton(
          icon: Icon(CupertinoIcons.back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.profile_circled,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  currentMeal.image,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,

                ),
              ),
            ),

            SizedBox(height: 10),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Color(0xff2d1b12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        currentMeal.category,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffff6e00),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 30),
                  Spacer(),
                  Icon(Icons.grade, color: Colors.yellow),
                  SizedBox(width: 5),
                  Text(
                    "4.5",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            Row(
              children: [
                SizedBox(width: 20),
                Container(
                  width: 5,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Color(0xffff6e00),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  currentMeal.name,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 120,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xff1c1c21),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Icon(CupertinoIcons.time, color: Color(0xfffab65d)),

                          FittedBox(
                            child: Text(
                              "Prep",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff797270),
                              ),
                            ),
                          ),

                          FittedBox(
                            child: Text(
                              "15 min",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(width: 10),

                  Expanded(
                    child: Container(
                      height: 120,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xff1c1c21),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.local_fire_department,
                            color: Color(0xfffab65d),
                          ),

                          FittedBox(
                            child: Text(
                              "Energy",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff797270),
                              ),
                            ),
                          ),

                          FittedBox(
                            child: Text(
                              "250 kcal",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(width: 10),

                  Expanded(
                    child: Container(
                      height: 120,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xff1c1c21),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.grade, color: Color(0xfffab65d)),

                          FittedBox(
                            child: Text(
                              "Skill",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff797270),
                              ),
                            ),
                          ),

                          FittedBox(
                            child: Text(
                              "Easy",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(width: 10),

                  Expanded(
                    child: Container(
                      height: 120,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xff1c1c21),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.food_bank_outlined,
                            color: Color(0xfffab65d),
                          ),

                          FittedBox(
                            child: Text(
                              "Yield",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff797270),
                              ),
                            ),
                          ),

                          FittedBox(
                            child: Text(
                              "2 servings",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 15),

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(width: 20),
                    Container(
                      width: 5,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Color(0xffff6e00),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "About this dish",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xff1c1c21),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    currentMeal.instructions.isEmpty
                        ? "No description available."
                        : currentMeal.instructions,
                    style: TextStyle(fontSize: 20, color: Color(0xff797270)),
                  ),
                ),
              ],
            ),

            SizedBox(height: 15),

            Row(
              children: [
                SizedBox(width: 20),
                Container(
                  width: 5,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Color(0xffff6e00),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "Ingredients",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

            if (isLoading)
              Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(color: Color(0xffff6e00)),
              )
            else if (currentMeal.ingredients.isEmpty)
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "No ingredients available.",
                  style: TextStyle(fontSize: 18, color: Color(0xff797270)),
                ),
              )
            else
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    for (
                      int index = 0;
                      index < currentMeal.ingredients.length;
                      index += 2
                    )
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            buildIngredientCard(
                              currentMeal.ingredients[index],
                              index < currentMeal.measures.length
                                  ? currentMeal.measures[index]
                                  : "",
                            ),

                            SizedBox(width: 8),

                            if (index + 1 < currentMeal.ingredients.length)
                              buildIngredientCard(
                                currentMeal.ingredients[index + 1],
                                index + 1 < currentMeal.measures.length
                                    ? currentMeal.measures[index + 1]
                                    : "",
                              )
                            else
                              Expanded(child: SizedBox()),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

            SizedBox(height: 20),

            // ==================================================
            // STEP-BY-STEP GUIDE
            // ==================================================
            Row(
              children: [
                SizedBox(width: 20),
                Container(
                  width: 5,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Color(0xffff6e00),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "Step-by-step guide",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            SizedBox(height: 15),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.all(15),

              decoration: BoxDecoration(
                color: Color(0xff1c1c21),
                borderRadius: BorderRadius.circular(20),
              ),

              child: steps.isEmpty
                  ? Padding(
                      padding: EdgeInsets.all(15),
                      child: Center(
                        child: Text(
                          "No instructions available.",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff797270),
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: steps.length,
                      itemBuilder: (context, index) {
                        return buildStepCard(index, steps[index]);
                      },
                    ),
            ),

            SizedBox(height: 50),

            // ==================================================
            // FAVORITE
            // ==================================================
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavouritePage(),
                    ),
                  );
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.black,
                ),
                label: Text(
                  isFavorite ? "Remove from Favorites" : "Add to Favorites",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffff6e00),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
