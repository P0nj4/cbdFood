import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel/carousel.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xFFFAFAFA)
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
                  children: <Widget>[
                    new Image.network(doc['image_url'], height: 220.0, fit: BoxFit.cover),
                    new Text(doc['name'],
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 41.0
                      )
                    )
                  ],
                );
              })
              .toList(),
              // .map((netImage) =>
              //     //new Image(image: netImage, height: 220.0, fit: BoxFit.cover))
              //     new Stack(
              //       children: <Widget>[
              //         new Image(image: netImage, height: 220.0, fit: BoxFit.cover),
              //         new Text(doc['name'])
              //       ],
              //     )
              // ).toList(),
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
                  padding: EdgeInsets.only(bottom: 10.0),
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
