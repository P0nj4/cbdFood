import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe {
  String name;
  String imageUrl;
  DateTime created;
  bool featured;

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

  static Future<List<Recipe>> getAll(String sortBy, int limit) async {

    final collection = Firestore.instance.collection('recipes');
    Query query = null;
    //final data = await collection.orderBy('created').limit(limit).getDocuments();
    if (sortBy != null) {
      query = collection.orderBy(sortBy);
    }
    if (limit != null) {
      query = query.limit(limit);
    }
    final data = await (query != null ? query : collection).getDocuments();
    final List<Recipe> rec = data.documents.map((document) {
      Map<String, dynamic> data = document.data;
      return Recipe(data['name'], data['image_url'], data["created"]);
    }).toList();
    return rec;
  }

  static void get() {

    final DocumentReference postRef = Firestore.instance.document('recipes');
    postRef.snapshots().map((a) {
      print(a.data['name']);
    });
  }

  static void createDummy() {
    SharedPreferences.getInstance().then((prefs) {
      final dummyAdded = prefs.getBool('dummyAdded') != null ? prefs.getBool('dummyAdded') : false;
      if (!dummyAdded) {
        prefs.setBool('dummyAdded', true);
        _internalCreateDummy();
      }
    });
  }

  static void _internalCreateDummy() {
    DateTime now = new DateTime.now();
    Firestore.instance.collection('recipes').document().setData({ 'name': 'Strawberry Sauce',
      'image_url': 'https://cdn.herb.co/wp-content/uploads/2016/04/recipe-strawberry-sauce-800x400.jpg',
      'featured': true,
      'created': now
    });
    Firestore.instance.collection('recipes').document().setData({ 'name': 'Tomato Soup',
      'image_url': 'https://cdn.herb.co/wp-content/uploads/2016/05/recipe-tomoato-soup-800x400.jpg',
      'featured': true,
      'created': now.subtract(new Duration(hours: 1))
    });
    Firestore.instance.collection('recipes').document().setData({ 'name': 'Black Pepper Drop Biscuits',
      'image_url': 'https://cdn.herb.co/wp-content/uploads/2016/04/recipe-biscuit-800x400.jpg',
      'featured': false,
      'created': now.subtract(new Duration(hours: 1, minutes: 10))
    });
    Firestore.instance.collection('recipes').document().setData({ 'name': 'Cannabis-infused berry hand pie',
      'image_url': 'https://cdn.herb.co/wp-content/uploads/2018/04/Hand-Pies-800x400.jpg',
      'featured': false,
      'created': now.subtract(new Duration(hours: 1, minutes: 9))
    });
    Firestore.instance.collection('recipes').document().setData({ 'name': 'Dark Chocolate Blender Pudding',
      'image_url': 'https://cdn.herb.co/wp-content/uploads/2016/05/recipe-chocolate-pudding-800x400.jpg',
      'featured': true,
      'created': now.subtract(new Duration(hours: 1, minutes: 11))
    });
    Firestore.instance.collection('recipes').document().setData({ 'name': 'Power Paleo Morning Shake From Warm & Crispy',
      'image_url': 'https://cdn.herb.co/wp-content/uploads/2016/05/smothie-800x400.jpg',
      'featured': false,
      'created': now.subtract(new Duration(hours: 1, minutes: 18))
    });
    Firestore.instance.collection('recipes').document().setData({ 'name': 'Easy Macaroni And Cheese',
      'image_url': 'https://cdn.herb.co/wp-content/uploads/2016/06/recipe-easy-macaroni-800x400.jpg',
      'featured': false,
      'created': now.subtract(new Duration(hours: 1, minutes: 19))
    });
    Firestore.instance.collection('recipes').document().setData({ 'name': 'Avocado Toast',
      'image_url': 'https://cdn.herb.co/wp-content/uploads/2016/05/recipe-avocado-toast-800x400.jpg',
      'featured': false,
      'created': now.subtract(new Duration(hours: 1, minutes: 20))
    });
  }
}
