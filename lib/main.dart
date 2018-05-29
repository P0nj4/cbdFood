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
        padding: EdgeInsets.only(top: 7.0, left: 10.0),
        color: Colors.white,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text('TRENDING',
              style: new TextStyle(
                fontSize: 20.0,
              ),
            ),
            _grid(),
          ],
        ),
      ),
    );
  }

  Widget _grid() {
    final mediaQueryData = MediaQuery.of(context);

    if (recipes == null) return new Text("Loading");
//    return GridView.count(
//      crossAxisCount: 2,
//      scrollDirection: Axis.vertical,
//      children: new List.generate(recipes.length, (index) {
//        return Text('asda');
//      })
//    );
    return new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
//                new Container(
//                  width: mediaQueryData.size.width / 3,
//                  height: 100.0,
//                  color: Colors.black,
//                  margin: EdgeInsets.only(bottom: 10.0),
//                )
                new Expanded(
                    child: new Container(
                      color: Colors.green,
                      child: new Text('asdasdasd'),
                    )
                ),
                new Expanded(
                    child: new Container(
                      color: Colors.yellow,
                      child: new Text('asdasdasd'),
                    )
                )
              ],
            ),
            new Row(
              children: <Widget>[
                new Container(
                  width: mediaQueryData.size.width / 3,
                  height: 100.0,
                  color: Colors.black,
                )
              ],
            )
          ],

        
    );
  }
}