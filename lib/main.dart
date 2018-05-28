import 'package:cbd_food/home_components/featured.dart';
import 'package:cbd_food/model/recipe.dart';
import 'package:flutter/material.dart';

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
          ],
        ),
      ),
    );
  }
}

class NewestGrid extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new NewestGridState();
  }
}

class NewestGridState extends State<NewestGrid> {
  List<Recipe> recipes;


  @override
  void initState() {
    super.initState();
    Recipe.getAll().then((recipesResult) {
      setState(() {
        this.recipes = recipesResult;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget content = new GridView.count(
      crossAxisCount: 1,
      scrollDirection: Axis.horizontal,
      children: new List.generate(this.recipes.length, (index) {
        return new Center(
          child: new Text(
            this.recipes[index].name,
            style: Theme.of(context).textTheme.headline,
          ),
        );
      }),
    );

    Widget _gridContent() {
      if (recipes == null) return new CircularProgressIndicator();
      return content;
    }

    return new SizedBox(
      height: 120.0,
      child: _gridContent(),
    );
  }
}
