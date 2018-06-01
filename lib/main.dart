import 'package:cbd_food/home_components/featured.dart';
import 'package:cbd_food/home_components/newest_grid.dart';
import 'package:cbd_food/managers/recipes_manager.dart';
import 'package:cbd_food/model/recipe.dart';
import 'package:flutter/material.dart';
import 'package:cbd_food/home_components/Trending.dart';
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
            new Trending(RecipesManager().trending()),
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

