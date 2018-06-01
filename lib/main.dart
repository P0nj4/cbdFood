import 'package:cbd_food/home_components/featured.dart';
import 'package:cbd_food/home_components/newest_grid.dart';
import 'package:cbd_food/managers/recipes_manager.dart';
import 'package:cbd_food/model/recipe.dart';
import 'package:flutter/material.dart';
import 'package:cbd_food/utils/rounded_corners_clipper_path.dart';
import 'package:async_loader/async_loader.dart';

void main() => runApp(new MyApp());

//TODO: implement globalKey<AsyncLoaderState>

final GlobalKey<AsyncLoaderState> _asyncLoaderState =
new GlobalKey<AsyncLoaderState>();

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

  var _asyncLoader = new AsyncLoader(
    key: _asyncLoaderState,
    initState: () async => await RecipesManager().getAll(),
    renderLoad: () => new Center( child: CircularProgressIndicator(),),
    renderError: ([error]) => _errorBody(),
    renderSuccess: ({data}) => _homeBody(),
  );

  static Widget _homeBody() {
    return new Container(
      child: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new Featured(),
            new NewestGrid(),
            new Trending(),
          ],
        ),
      ),
    );
  }

  static Widget _errorBody() {
    return new Container(
      color: Colors.grey[100],
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text('Something went wrong, please try again'),
          new Container(
            height: 20.0,
          ),
          new RaisedButton(child: new Text('Reload'), color: Colors.red[400],
            onPressed: () {
              _asyncLoaderState.currentState.reloadState();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("CBD Food"),
        actions: <Widget>[
          new SizedBox(
            width: 100.0,
          )
        ],
      ),
      body: _asyncLoader,
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
    RecipesManager().trending().then((recipes) {
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