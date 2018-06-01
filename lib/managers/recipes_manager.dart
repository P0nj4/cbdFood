import 'dart:async';
import 'package:cbd_food/model/recipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecipesManager {

  static final RecipesManager _instance = RecipesManager._internal();
  factory RecipesManager() => _instance;
  RecipesManager._internal();

  List<Recipe> _recipes;

  Future getAll() async {
    final collection = Firestore.instance.collection('recipes');
    final data = await collection.getDocuments();
    _recipes = data.documents.map((document) {
      Map<String, dynamic> data = document.data;
      return Recipe(data['name'], data['image_url'], data["created"]);
    }).toList();
    return;
    //TODO: find the way to return an error when the recipes list is empty
  }

  Future<List<Recipe>> newest() async {
    if (_recipes == null || _recipes.length == 0) await getAll();
    var sorted = new List<Recipe>.from(_recipes);
    sorted.sort((r1, r2) {
      return r1.created.compareTo(r2.created);
    });
    final limit = 10;
    return sorted.sublist(0, sorted.length > limit ? limit : sorted.length - 1);
  }

  List<Recipe> trending() {
    var shuffled = new List<Recipe>.from(_recipes);
    shuffled.shuffle();

    var limit = 10;
    return shuffled.sublist(0, shuffled.length > limit ? limit : shuffled.length - 1);
  }
}