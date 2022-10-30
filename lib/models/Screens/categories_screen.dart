import 'package:flutter/material.dart';
import '../Data/dummy_data.dart';
import '../Widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text("Meals"),
    //   ),
    return GridView(
      padding: const EdgeInsets.all(15),
      children: DUMMY_CATEGORIES.map((catData) {
        return Container(
          child: CategoryItem(
            id: catData.id,
            title: catData.title,
            color: catData.color,
          ),
        );
      }).toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    ); // slivers are scrollable areas on the screen
  }
}
