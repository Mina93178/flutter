import 'package:flutter/material.dart';
import '../Widgets/meal.dart';
import '../Widgets/meal_item.dart';

class FavouriteScreen extends StatelessWidget {
  List<Meal> favourites;
  FavouriteScreen({this.favourites});
  @override
  Widget build(BuildContext context) {
    if (favourites.isEmpty) {
      return Center(
        child: Text(
          "You have no favourites yet\nStart adding some!",
          style: Theme.of(context).textTheme.title,
        ),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            title: favourites[index].title,
            imageURL: favourites[index].imageUrl,
            complexity: favourites[index].complexity,
            affordability: favourites[index].affordability,
            duration: favourites[index].duration,
            id: favourites[index].id,
          );
        },
        itemCount: favourites.length,
      );
    }
  }
}
