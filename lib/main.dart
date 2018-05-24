import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel/carousel.dart';
import 'dart:ui' as ui;

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

    Widget _testCarousel(AsyncSnapshot<QuerySnapshot> snapshot) {
      return new SizedBox(
        height: 220.0,
        child: new Carousel(
          children: snapshot.data.documents
              .map((DocumentSnapshot doc) {
                return new Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    new Image.network(doc['image_url'], height: 220.0, fit: BoxFit.cover),
                    new ShadowText(doc['name'],
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 32.0,
                      )
                    )
                  ],
                );
              })
              .toList(),
          displayDuration: const Duration(seconds: 3),
        ),
      );
    }

    Widget asyncCarousel() {
      return new StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('featured').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return new Text('Loading...');
            return _testCarousel(snapshot);
          });
    }

    Widget test = new Container(
        decoration: new BoxDecoration(
          color: Colors.white,
        ),
        child: new Column(
          children: <Widget>[
            new Stack(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: asyncCarousel(),
                ),
                new Positioned(
                  bottom: 0.0,
                  right: -10.0,
                  child: new Image(
                    image: new AssetImage('assets/images/featured.png'),
                    width: 106.0,
                    height: 35.0,
                  )
                ),
              ],
            ),
            new Text('41'),
          ],
        ));

    return new Scaffold(
        appBar: new AppBar(
          title: new Text("CBD Food"),
        ),
        body: test);
  }
}

class ShadowText extends StatelessWidget {
  ShadowText(this.data, { this.style }) : assert(data != null);

  final String data;
  final TextStyle style;

  Widget build(BuildContext context) {
    return new ClipRect(
      child: new Stack(
        children: [
          new Positioned(
            top: 2.0,
            left: 2.0,
            child: new Text(
              data,
              style: style.copyWith(color: Colors.black.withOpacity(0.5)),
            ),
          ),
          new BackdropFilter(
            filter: new ui.ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: new Text(data, style: style),
          ),
        ],
      ),
    );
  }
}