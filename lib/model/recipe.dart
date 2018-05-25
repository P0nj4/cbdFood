import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe {
  String name;
  String imageUrl;
  DateTime created;

  Recipe(String name, String imageUrl, DateTime created) {
    this.name = name;
    this.imageUrl = imageUrl;
    this.created = created;
  }

  void save() {
    Firestore.instance.collection('recipes').document().setData({
      'name': name,
      'image_url': imageUrl,
      'created': created == null ? new DateTime.now() : created
    });
  }

  static void get() {
    //final test = Firestore.instance.collection('recipes');
    final DocumentReference postRef = Firestore.instance.document('recepies');
    postRef.snapshots().map((a) {
      print(a.data['name']);
    });

    

    //  Widget _carouselContent(AsyncSnapshot<QuerySnapshot> snapshot) {
    // return new SizedBox(
    //   height: 220.0,
    //   child: new Carousel(
    //     children: snapshot.data.documents.m
  }
}
