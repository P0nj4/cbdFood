
import 'package:cbd_food/model/recipe.dart';
import 'package:flutter/material.dart';
import 'package:cbd_food/screens/home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cbd_food/utils/network_image.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Recipe.createDummy();

    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Color(0xFFFAFAFA),
          fontFamily: 'BreeSerif'),
      home: new MyHomePage(),
    );
  }
}

class RecipeDetail extends StatefulWidget {
  RecipeDetail({Key key, this.recipe}) : super(key: key);

  final Recipe recipe;

  @override
  _RecipeDetailState createState() => new _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _scrollController.addListener((){
      print(_scrollController.offset);
      if (_scrollController.position.maxScrollExtent - _scrollController.offset < 10.0) {

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        color: Colors.grey[200],
        child: new CustomScrollView(
//        physics: const AlwaysScrollableScrollPhysics(), // new
          slivers: <Widget>[
            new SliverAppBar(
              title: Text(widget.recipe.name),
              floating: false,
              pinned: true,
              expandedHeight: 200.0,
              flexibleSpace: new FlexibleSpaceBar(
                background:
                new Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    NetImage(url: widget.recipe.imageUrl),
                    const DecoratedBox(
                      decoration: const BoxDecoration(
                        gradient: const LinearGradient(
                          begin: const Alignment(0.0, -0.5),
                          end: const Alignment(0.0, -0.1),
                          colors: const <Color>[Color(0x90ffffff), Color(0x00ffffff)],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            new SliverSafeArea(
              top: false,
              sliver: new SliverList(
                delegate: SliverChildListDelegate([
                  _Description(),
                  _Ingredients(),
                  new Container(
                    color: Colors.grey[200],
                    height: 20.0,
                  ),
                  _Method(),
                  new Container(
                    color: Colors.grey[200],
                    height: 20.0,
                  ),
                ]),
              ),
            ),
          ],
//        controller: _scrollController,
        ),
      ),
    );
  }
}

class _Description extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.grey[200],
      padding: EdgeInsets.only(bottom: 20.0),
      child: new Container(
        padding: EdgeInsets.all(10.0),
        color: Colors.white,
        child: new Text('Any affordable virgin olive oil works nicely for this recipe. If you plan on using your Canna Oil for salad dressings or pasta, we recommend you use a fruity extra-virgin olive oil.',
          style: new TextStyle(
            fontSize: 15.0,
            color: Color(0xFF9498A1),
          ),
        ),
      ),
    );
  }
}

class _GrayContainer extends StatelessWidget {

  final Widget child;

  _GrayContainer({Key key, @required this.child});

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.grey[200],
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: new Container(
        color: Colors.white,
        padding: EdgeInsets.all(10.0),
        child: this.child,
      ),
    );
  }
}

class _Ingredients extends StatelessWidget {

  List<String> ingredientsList = ['15 ounces of cannellini beans, drained and rinsed', '1 1⁄4 teaspoons curry powder', '1⁄2 teaspoon kosher salt', '15 ounces of cannellini beans, drained and rinsed'];

  @override
  Widget build(BuildContext context) {
    return _GrayContainer(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text('Ingredients',
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Color(0xFF161616),
                fontSize: 22.0
            ),
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                  child: new Text('2 Servings',
                    style: new TextStyle(
                      fontSize: 15.0,
                      color: Color(0xFF9498A1),
                    ),
                  )
              ),
              new IconButton(icon: new Icon(FontAwesomeIcons.plusSquare), color: Color(0xFF00ADB2), highlightColor: Colors.red, splashColor: Colors.yellow, iconSize: 20.0, onPressed: () {
                print('add');
              }),
              new IconButton(icon: new Icon(FontAwesomeIcons.minusSquare), color: Color(0xFF00ADB2), iconSize: 20.0, onPressed: () {
                print('substract');
              }),
            ],
          ),
          new Column(
            children: ingredientsList.map((ing) {
              //Widget _IngredientItem(ingredient: (String)ing);
              return new _IngredientItem(ingredient: ing);
            }).toList(),
          )
        ],
      ),
    );
  }
}

class _Method extends StatelessWidget {

  List<String> methodSteps = ['In the bowl of a food processor fitted with a metal blade, pulse the beans, garlic, curry powder, salt, cumin, paprika, and white pepper until smooth and thoroughly combined, scraping the sides of the bowl as needed.',
  'In a measuring cup with a spout, combine the cannaoil, grape-seed oil, and lemon juice.',
  'With the machine running, add the cannaoil mixture in a steady stream through the feed tube, scraping the cup to ensure no oil is left. Blend for 1 minute to incorporate the oil.',
  'Transfer the dip to a serving bowl and top with the parsley and a drizzle of olive oil.'];

  @override
  Widget build(BuildContext context) {
    return new _GrayContainer(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: new Text('Method',
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Color(0xFF161616),
                  fontSize: 22.0
              ),
            ),
          ),
          new Column(
            children: methodInputWidgets()
          ),
        ],
      ),
    );
  }

  List<Widget> methodInputWidgets() {
    List<Widget> widgets = [];
    for (var i = 0; i < methodSteps.length; i++) {
      widgets.add(_MethodItem(index: i+1, text: methodSteps[i]));
    }
    return widgets;
  }
}

class _IngredientItem extends StatelessWidget {
  final String ingredient;

  _IngredientItem({
    Key key,
    this.ingredient
  });

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(top: 7.0),
      child: new Row(
        children: <Widget>[
          new Icon(FontAwesomeIcons.solidCheckSquare, color: Color(0xFF00ADB2), size: 15.0,),
          new Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: new Text(ingredient,
              style: new TextStyle(
                color: Color(0xFF161616),
                fontSize: 12.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MethodItem extends StatelessWidget {

  final int index;
  final String text;

  _MethodItem({Key key, this.index, this.text});

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: new Row(
        verticalDirection: VerticalDirection.down,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text('$index.',
            textAlign: TextAlign.start,
            style: new TextStyle(fontSize: 16.0, color: Color(0xFF161616)),
          ),
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(top: 2.0, left: 5.0),
              child: new Text(text,
                maxLines: 10,
                style: new TextStyle(fontSize: 12.0, color: Color(0xFF161616)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
