import 'package:flutter/material.dart';
import './models/Data/dummy_data.dart';
import './models/Screens/meal_detail_screen.dart';
import './models/Screens/categories_screen.dart';
import './models/Screens/category_meals_screen.dart';
import './models/Screens/tabs_screen.dart';
import './models/Screens/filters_screen.dart';
import './models/Widgets/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    "gluten": false,
    'lactose': false,
    'vegan': false,
    'vegeterian': false,
  };
  bool _isMealFavourite(String mealId) {
    return _favouritedMeals.any((meal) => meal.id == mealId);
  }

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouritedMeals = [];
  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegeterian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavourite(String mealId) {
    final existing_index =
        _favouritedMeals.indexWhere((meal) => meal.id == mealId);
    if (existing_index >= 0) {
      setState(() {
        _favouritedMeals.removeAt(existing_index);
      });
    } else {
      setState(() {
        _favouritedMeals
            .add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: "Raleway",
        textTheme: ThemeData.light().textTheme.copyWith(
            body1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            body2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            title: TextStyle(
              fontFamily: "RobotoCondensed",
              fontSize: 22,
              fontWeight: FontWeight.bold,
            )),
      ),
      // home: CategoriesScreen(),
      routes: {
        "/": (ctx) => TabsScreen(
              favourites: _favouritedMeals,
            ),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(
              meals: _availableMeals,
            ),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(
            modifyingFavList: _toggleFavourite,
            favouritePressed: _isMealFavourite),
        FilterScreen.routeName: (ctx) =>
            FilterScreen(currentFilters: _filters, setFilters: _setFilters),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );
      }, // this is to handle going to any unexisted page , so it will go for the CategoriresScreen , video 17 check it if you want
      // and also chech onUnknownRoute method
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => CategoriesScreen(),
        );
      },
      // this home arguments will have the first widget which should be loaded at first (entry point) the root screen of our app
    );
  }
}
