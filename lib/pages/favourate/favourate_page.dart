import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_explorer/models/meal_model/meal_model.dart';
import '../meal_details/meal_details_page.dart';
import 'favourate_store.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xff131316),
      appBar: AppBar(
        backgroundColor:  Color(0xff131316),
        title:  Text(
          "Favourite",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
        leading: IconButton(
          icon:  Icon(CupertinoIcons.back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon:  Icon(
              CupertinoIcons.profile_circled,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder<List<MealModel>>(
        valueListenable: FavouritesStore.instance.meals,
        builder: (context, meals, _) {
          return Column(
            children: [
               SizedBox(height: 20),
              Row(
                children: [
                   SizedBox(width: 20),
                  Container(
                    width: 5,
                    height: 30,
                    decoration: BoxDecoration(
                      color:  Color(0xffff6e00),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                   SizedBox(width: 10),
                   Text(
                    "Saved Meals",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: meals.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                  padding:  EdgeInsets.only(top: 12, bottom: 30),
                  itemCount: meals.length,
                  itemBuilder: (context, index) =>
                      _buildFavouriteCard(context, meals[index]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.favorite_border, size: 80, color: Color(0xff797270)),
          SizedBox(height: 20),
          Text(
            "No favourite meals yet",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Add meals to your favourites",
            style: TextStyle(color: Color(0xff797270), fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildFavouriteCard(BuildContext context, MealModel meal) {
    final imageWidth = MediaQuery.of(context).size.width * 0.42;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MealDetailsPage(meal: meal)),
        );
      },
      child: Container(
        height: 200,
        width: double.infinity,
        margin:  EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color:  Color(0xff1c1c21),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                meal.image,
                width: imageWidth,
                height: 170,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: imageWidth,
                    height: 170,
                    color:  Color(0xff2a2a2d),
                    child:  Icon(
                      Icons.restaurant,
                      color: Color(0xfffab65d),
                      size: 40,
                    ),
                  );
                },
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:  TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                   SizedBox(height: 10),
                   Row(
                    children: [
                      Text(
                        "4.5",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.grade, color: Color(0xfffab65d)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    meal.category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => FavouritesStore.instance.remove(meal),
              icon: Icon(Icons.favorite, color: Colors.red, size: 25),
            ),
          ],
        ),
      ),
    );
  }
}