import 'package:cbd_food/home_components/featured.dart';
import 'package:cbd_food/home_components/newest_grid.dart';
import 'package:cbd_food/model/recipe.dart';
import 'package:flutter/material.dart';
import 'package:cbd_food/utils/rounded_corners_clipper_path.dart';

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

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    Widget titleSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Row(
        children: [
          new Icon(
            Icons.star,
            color: Colors.blue[500],
          ),
          new Text('41'),
        ],
      ),
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("CBD Food"),
      ),
      body: new Container(
        child: new ListView(
          children: <Widget>[
            new Featured(),
            new NewestGrid(),
            new Trending(),
          ],
        ),
      ),
    );
  }
}

class Trending extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TrendingState();
  }
}

class TrendingState extends State<Trending> {

  List<Recipe> recipes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Recipe.getAll('created', 20).then((recipes) {
      setState(() {
        this.recipes = recipes;
      });
    });
  }

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
        children: <Widget>[
          new Expanded(
            child: new Column(
              children: <Widget>[
                new ClipPath(
                  clipper: new RoundedCornersClipperPath(cornerRadius: 8.0),
                  child: new Image.network(recipes[i].imageUrl, height:150.0, fit: BoxFit.cover,),
                ),
                new Text(recipes[i].name),
              ],
            ),
          ),
          new Container(
            width: 10.0,
          ),
          new Expanded(
            child: new Column(
              children: <Widget>[
                new ClipPath(
                  clipper: new RoundedCornersClipperPath(cornerRadius: 8.0),
                  child: new Image.network(recipes[i+1].imageUrl, height:150.0, fit: BoxFit.cover,),
                ),
                new Text(recipes[i+1].name),
              ],
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