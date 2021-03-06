
import 'package:cbd_food/model/recipe.dart';
import 'package:cbd_food/utils/rounded_corners_clipper_path.dart';
import 'package:flutter/material.dart';
import 'package:cbd_food/managers/recipes_manager.dart';
import 'package:cbd_food/utils/network_image.dart';

typedef void TrendingRecipeCallback (Recipe recipe);

class Trending extends StatelessWidget {

  final TrendingRecipeCallback onRecipePressed;

  Trending({
    Key key,
    @required this.onRecipePressed
  }) : assert(onRecipePressed != null);


  List<Recipe> recipes = RecipesManager().trending();

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.grey[200],
      child: new Container(
        margin: EdgeInsets.only(top: 10.0),
        padding: EdgeInsets.only(top: 7.0, left: 10.0, right: 10.0),
        color: Colors.white,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text('TRENDING',
              style: new TextStyle(
                fontSize: 20.0,
              ),
            ),
            new Container(
              height: 10.0,
            ),
            _grid(),
          ],
        ),
      ),
    );
  }

  Widget _grid() {
    if (recipes == null) return new Text("Loading");
    return new Column(
      children: _test(),
    );
  }

  List<Widget> _test() {
    var rows = List<Widget>();

    for (var i = 0; i < recipes.length; i+=2) {
      if (i + 1 >= recipes.length) return rows;
      Row row = new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: new GestureDetector(
              onTap: () { onRecipePressed(recipes[i]); },
              child: new Column(
                children: <Widget>[
                  new ClipPath(
                    clipper: new RoundedCornersClipperPath(cornerRadius: 8.0),
                    child: new NetImage(url: recipes[i].imageUrl, height: 150.0),
                  ),
                  new Text(recipes[i].name),
                ],
              ),
            ),
          ),
          new Container(
            width: 10.0,
          ),
          new Expanded(
            child: new GestureDetector(
              onTap: () {
                onRecipePressed(recipes[i+1]);
              },
              child: new Column(
                children: <Widget>[
                  new ClipPath(
                    clipper: new RoundedCornersClipperPath(cornerRadius: 8.0),
                    child: new NetImage(url: recipes[i+1].imageUrl, height: 150.0),
                  ),
                  new Text(recipes[i+1].name),
                ],
              ),
            ),
          ),
        ],
      );
      rows.add(new Container(
        child: row,
        padding: EdgeInsets.only(bottom: 15.0),
      ));
    }
    return rows;
  }
}