import 'package:cbd_food/managers/recipes_manager.dart';
import 'package:cbd_food/model/recipe.dart';
import 'package:flutter/material.dart';
import 'package:cbd_food/utils/rounded_corners_clipper_path.dart';

typedef void NewestRecipeTapCallback (Recipe recipe);

class NewestGrid extends StatelessWidget {

  final NewestRecipeTapCallback onRecipePressed;

  NewestGrid({
    Key key,
    @required this.onRecipePressed
  }) : assert(onRecipePressed != null);


  List<Recipe> recipes = RecipesManager().newest();

  @override
  Widget build(BuildContext context) {

    Widget content = new GridView.count(
      crossAxisCount: 1,
      scrollDirection: Axis.horizontal,
      childAspectRatio: 180.0 / 130.0,
      children: new List.generate(recipes != null ? recipes.length : 0, (index) {
        return
        new GestureDetector(
          onTap: () {
            onRecipePressed(recipes[index]);
          },
          child:
          new Container(
            padding: EdgeInsets.all(5.0),
            child: new Center(
              child: new Column(
                children: <Widget>[
                  new Container(
                    child: new SizedBox(
                      height: 100.0,
                      child: new ClipPath(
                        clipper: new RoundedCornersClipperPath(cornerRadius: 8.0),
                        child: new Image.network(recipes[index].imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  new Text(
                    this.recipes[index].name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: new TextStyle(
                      fontSize: 12.0,
                    ),
                  )
                ],
              ),
            ),
          ),

        );
      }),
    );

    Widget _gridContent() {
      //TODO: the circular is taking all the space.
      if (recipes == null) return new CircularProgressIndicator();
      return content;
    }

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
          padding: EdgeInsets.only(left: 10.0),
          child: Text('NEWEST',
            style: new TextStyle(
                fontSize: 20.0
            ),
          ),
        ),
        new SizedBox(
          height: 145.0,
          child: _gridContent(),
        )
      ],
    );
  }
}
