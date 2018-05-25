import 'package:cbd_food/home_components/featured.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xFFFAFAFA),
        fontFamily: 'BreeSerif'
      ),
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
            color: Colors.red[500],
          ),
          new Text('41'),
        ],
      ),
    );

    return new Scaffold(
        appBar: new AppBar(
          title: new Text("CBD Food"),
        ),
        body: new Featured());
  }
}

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Grid List';

    return new MaterialApp(
      title: title,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(title),
        ),
        body: new GridView.count(
          crossAxisCount: 1,
          scrollDirection: Axis.horizontal,
          children: new List.generate(100, (index) {
            return new Center(
              child: new Text(
                'Item $index',
                style: Theme.of(context).textTheme.headline,
              ),
            );
          }),
        ),
      ),
    );
  }
}