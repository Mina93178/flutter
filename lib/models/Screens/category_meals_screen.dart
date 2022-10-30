import 'package:flutter/material.dart';
import '../Data/dummy_data.dart';
import '../Widgets/meal_item.dart';
import '../Widgets/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = "/category-meals";
  List<Meal> meals;
  CategoryMealsScreen({this.meals});
  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String category_title;
  String category_id;
  List<Meal> categoryMeals;

  var _initLoaded = false;
  @override
  void didChangeDependencies() {
    if (!_initLoaded) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;

      category_title = routeArgs["title"];
      category_id = routeArgs["id"];

      categoryMeals = widget.meals.where((meal) {
        return meal.categories.contains(category_id);
      }).toList();
      _initLoaded = true;
    }
    super.didChangeDependencies();
  }

  // void _deleteMeal(String mealId) {
  //   setState(() {
  //    // categoryMeals.removeWhere((meal) => meal.id == mealId);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category_title),
        //textTheme: Theme.of(context).textTheme,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            title: categoryMeals[index].title,
            imageURL: categoryMeals[index].imageUrl,
            complexity: categoryMeals[index].complexity,
            affordability: categoryMeals[index].affordability,
            duration: categoryMeals[index].duration,
            id: categoryMeals[index].id,
          );
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
