
import 'package:cbd_food/model/recipe.dart';
import 'package:flutter/material.dart';
import 'package:cbd_food/screens/home.dart';

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

class RecipeDetail extends StatefulWidget {
  RecipeDetail({Key key, this.recipe}) : super(key: key);

  final Recipe recipe;

  @override
  _RecipeDetailState createState() => new _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _scrollController.addListener((){
      print(_scrollController.offset);
      if (_scrollController.position.maxScrollExtent - _scrollController.offset < 10.0) {

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new CustomScrollView(
//        physics: const AlwaysScrollableScrollPhysics(), // new
        slivers: <Widget>[
          new SliverAppBar(
            title: Text(widget.recipe.name),
            floating: false,
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: new FlexibleSpaceBar(
              background:
              new Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  new ClipPath(
                    clipper: new ArcClipper(),
                    child: new Image.network(widget.recipe.imageUrl, fit: BoxFit.cover,),
                  ),
                  const DecoratedBox(
                    decoration: const BoxDecoration(
                      gradient: const LinearGradient(
                        begin: const Alignment(0.0, -0.5),
                        end: const Alignment(0.0, 0.9),
                        colors: const <Color>[Color(0x80ffffff), Color(0x10ffffff), Color(0x00ffffff)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
//        controller: _scrollController,
      ),
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 30);

    var firstControlPoint = new Offset(size.width / 4, size.height);
    var firstPoint = new Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint =
    new Offset(size.width - (size.width / 4), size.height);
    var secondPoint = new Offset(size.width, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}