import 'package:cbd_food/utils/shadow_text.dart';
import "package:flutter/material.dart";
import "package:carousel/carousel.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class Featured extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new Stack(
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
            )),
      ],
    ));
  }

  Widget _carouselContent(AsyncSnapshot<QuerySnapshot> snapshot) {
    return new SizedBox(
      height: 220.0,
      child: new Carousel(
        children: snapshot.data.documents.map((DocumentSnapshot doc) {
          return new Stack(
            alignment: Alignment.center,
            children: <Widget>[
              new Image.network(doc['image_url'],
                  height: 220.0, fit: BoxFit.cover),
              new ShadowText(doc['name'],
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 32.0,
                  ))
            ],
          );
        }).toList(),
        displayDuration: const Duration(seconds: 3),
      ),
    );
  }

  Widget asyncCarousel() {
    return new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('recipes').where('featured', isEqualTo: true).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        return _carouselContent(snapshot);
      },
    );
  }
}
