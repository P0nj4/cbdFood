
import 'package:cbd_food/home_components/featured.dart';
import 'package:cbd_food/home_components/newest_grid.dart';
import 'package:cbd_food/managers/recipes_manager.dart';
import 'package:cbd_food/home_components/Trending.dart';
import 'package:async_loader/async_loader.dart';
import 'package:flutter/material.dart';

final GlobalKey<AsyncLoaderState> _asyncLoaderState =
new GlobalKey<AsyncLoaderState>();


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
            new NewestGrid(onRecipePressed: ((recipe) {
              print(recipe.name);
            }),
            ),
            new Trending(onRecipePressed: ((recipe) {
              print(recipe.name);
            })),

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
    return new Scaffold(
      floatingActionButton: new Text('asdasd'),
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