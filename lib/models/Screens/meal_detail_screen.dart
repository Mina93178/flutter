import 'package:flutter/material.dart';
import '../Data/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = "/MealDetailScreen";
  final Function modifyingFavList;
  final Function favouritePressed;

  MealDetailScreen({this.modifyingFavList, this.favouritePressed});
  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget buildContainer(BuildContext context, Widget child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.25,
      width: double.infinity,
      //height: 200,
      //width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final mealid = args["id"] as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealid);
    return Scaffold(
      appBar: AppBar(
        title: Text("${selectedMeal.title}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 280,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, "Ingredients"), //SizedBox(
            //height: 5,
            //),
            Row(
              children: <Widget>[
                Flexible(
                  fit: FlexFit.tight,
                  flex: 6,
                  child: buildContainer(
                    context,
                    ListView.builder(
                      itemBuilder: (ctx, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Color.fromARGB(25, 70, 68, 1),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 7, horizontal: 7),
                            child: Text(
                              selectedMeal.ingredients[index],
                              style:
                                  TextStyle(fontSize: 25, color: Colors.yellow),
                            ),
                          ),
                        );
                      },
                      itemCount: selectedMeal.ingredients.length,
                    ),
                  ),
                ),
                Flexible(
                    child: Container(
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.arrow_upward),
                      Icon(Icons.arrow_downward),
                    ],
                  ),
                ))
              ],
            ),
            buildSectionTitle(context, "Steps"),
            buildContainer(
              context,
              ListView.builder(
                itemCount: selectedMeal.steps.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          child: Text("${index + 1}"),
                        ),
                        title: Text(
                          selectedMeal.steps[index],
                          style: Theme.of(context).textTheme.title,
                        ),
                      ),
                      Divider(
                        color: Colors.red,
                        thickness: 5,
                      )
                    ],
                  );
                  // return Text(
                  //   selectedMeal.steps[index],
                  //   style: Theme.of(context).textTheme.title,
                  // );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          favouritePressed(mealid) ? Icons.star : Icons.star_border,
        ),
        onPressed: () {
          modifyingFavList(mealid);
        },
        // () {
        //   Navigator.of(context).pop(mealid);
        //   // Navigator.of(context).pop();
        //   // this line of code will help you to go back or to remove some overlay sheet or dialog like modalbottomsheet
        // },
      ),
    );
  }
}
