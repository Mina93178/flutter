import 'package:flutter/material.dart';
import '../Screens/categories_screen.dart';
import '../Screens/favourite_screen.dart';
import '../Widgets/main_drawer.dart';
import '../Screens/filters_screen.dart';
import '../Widgets/meal.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favourites;
  TabsScreen({this.favourites});
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;
  @override
  void initState() {
    _pages = [
      {"page": CategoriesScreen(), "title": "Categories"},
      {
        "page": FavouriteScreen(favourites: widget.favourites),
        "title": "Favourites"
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
        //DefaultTabController(
        //   length: 2,
        //   // initialIndex: 1,
        //   child:
        Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]["title"]),
        // bottom: TabBar(
        //   controller: null,
        //   tabs: <Widget>[
        //     Tab(
        //       icon: Icon(Icons.category),
        //       text: "Categories",
        //     ),
        //     Tab(
        //       icon: Icon(Icons.star),
        //       text: "Favourites",
        //     )
        //   ],
        // ),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]["page"],

      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.yellow,
          currentIndex: _selectedPageIndex,
          //  type: BottomNavigationBarType.shifting,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(
                Icons.category,
              ),
              title: Text("Categories"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              //backgroundColor: Colors.black,
              title: Text("Favourites "),
            )
          ]),
      // TabBarView(
      //   children: <Widget>[
      //     CategoriesScreen(),
      //     FavouriteScreen(), // Very very verrrrrry important , video 20 in the 7th section
      //   ],
      // ),
    );
  }
}
