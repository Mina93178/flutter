import 'package:flutter/material.dart';
import '../Screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget _buildListTile(String title, IconData icon, Function action) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: "RobotoCondensed",
          fontWeight: FontWeight.bold, // bold == W700
          fontSize: 24,
        ),
      ),
      onTap: () {
        action();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).viewInsets.top) *
                0.15,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: Text(
              "Hungry?",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Theme.of(context).primaryColor),
            ),
            color: Theme.of(context).accentColor,
          ),
          SizedBox(
            height: 20,
          ),
          _buildListTile(
            "Meal",
            Icons.restaurant,
            () {
              Navigator.of(context).pushReplacementNamed("/");
            },
          ),
          _buildListTile("Settings", Icons.settings, () {
            Navigator.of(context).pushReplacementNamed(FilterScreen.routeName);
            // using pushReplacementNamed to avoid filling up the stack with pages , but instead
          }),
        ],
      ),
    );
  }
}
