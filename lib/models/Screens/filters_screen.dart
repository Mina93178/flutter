import 'package:flutter/material.dart';
import '../Widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = "/filters";
  final Function setFilters;
  final Map<String, bool> currentFilters;
  FilterScreen({this.currentFilters, this.setFilters});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _gluteenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;
  @override
  initState() {
    _gluteenFree = widget.currentFilters['gluten'];
    _vegetarian = widget.currentFilters['vegeterian'];
    _vegan = widget.currentFilters['vegan'];
    _lactoseFree = widget.currentFilters['lactose'];

    super.initState();
  }

  Widget _buildSwitchListTile(String title, String descriction,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(descriction),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        drawer: MainDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "Adjust your meal selection ",
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _buildSwitchListTile(
                    "Gluteen-free",
                    "Only include gluteen-free meals.",
                    _gluteenFree,
                    (newValue) {
                      setState(() {
                        _gluteenFree = newValue;
                      });
                    },
                  ),
                  _buildSwitchListTile(
                    "Lactose-free",
                    "Only include Lactose-free meals.",
                    _lactoseFree,
                    (newValue) {
                      setState(() {
                        _lactoseFree = newValue;
                      });
                    },
                  ),
                  _buildSwitchListTile(
                    "Vegeterian",
                    "Only include Vegetrian meals.",
                    _vegetarian,
                    (newValue) {
                      setState(() {
                        _vegetarian = newValue;
                      });
                    },
                  ),
                  _buildSwitchListTile(
                    "Vegan",
                    "Only include Vegan meals.",
                    _vegan,
                    (newValue) {
                      setState(() {
                        _vegan = newValue;
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final _selectedFilters = {
                  "gluten": _gluteenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegeterian': _vegetarian,
                };
                widget.setFilters(_selectedFilters);
              },
            )
          ],
          title: Text(
            "Filters",
            style: Theme.of(context).textTheme.title,
          ),
        ),
      ),
    );
  }
}
