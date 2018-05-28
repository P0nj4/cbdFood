import 'dart:async';

import 'package:cbd_food/home_components/featured.dart';
import 'package:cbd_food/model/recipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<List<Recipe>> _createDummyData() async {

      final collection = Firestore.instance.collection('recepies');
      final data = await collection.getDocuments();
      final List<Recipe> rec = data.documents.map((document) {
          Map<String, dynamic> data = document.data;
          return Recipe(data['name'], data['image_url'], data["created"]);
        }).toList();
        return rec;
  }

  @override
  void initState() {
    super.initState();

    _createDummyData().then((recipesResult) {
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
      if (recipes == null) return Text('Loading...');
      return content;
    }

    return new SizedBox(
      height: 120.0,
      child: _gridContent(),
    );
  }
}

class NewestGrid2 extends StatelessWidget {
  Future<List<Recipe>> _createDummyData() async {
    // void createRecipe() {
    //   Recipe('as', null, null);
    //   final DocumentReference postRef = Firestore.instance.document('posts/123');
    // }
    // DateTime now = new DateTime.now();
    // Firestore.instance.collection('recipes').document().setData({ 'name': 'Seared Sirloin With Savory Bread Pudding', 'image_url': 'https://cdn.herb.co/wp-content/uploads/2016/04/recipe-sirlion-new-800x400.jpg', 'created': now });
    //Recipe.get();

    // final DocumentReference postRef = Firestore.instance.document('recepies/OBVfWZgUn9CQeZh6cIuI');
    // postRef.get().then((s) {
    //   print(s.data['name']);
    // });

    final test = Firestore.instance.collection('recepies');
    final data = await test.getDocuments().then((o) {
      List<Recipe> rec = o.documents.map((document) {
        Map<String, dynamic> data = document.data;
        return Recipe(data['name'], data['image_url'], null);
      }).toList();
      print(rec.first.name);
    });
  }

  @override
  Widget build(BuildContext context) {

    return new SizedBox(
        height: 120.0,
        child: new StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('recipes')
              .orderBy('created')
              .snapshots(),
          builder:
          ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return new Text('Loading...');
            return new Text(snapshot.data.documents.first['name']);
          }),
        )
    );
  }
}
