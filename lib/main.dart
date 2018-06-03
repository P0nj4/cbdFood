
import 'package:cbd_food/model/recipe.dart';
import 'package:flutter/material.dart';
import 'package:cbd_food/screens/home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                        begin: const Alignment(0.0, -0.7),
                        end: const Alignment(0.0, -0.2),
                        colors: const <Color>[Color(0x90ffffff), Color(0x00ffffff)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          new SliverSafeArea(
            top: false,
            sliver: new SliverList(
               delegate: SliverChildListDelegate([
                 _description(),
                 _ingredients(),
               ]),
            ),
          )
        ],
//        controller: _scrollController,
      ),
    );
  }
}

class _description extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.grey[200],
      padding: EdgeInsets.only(bottom: 20.0),
      child: new Container(
        padding: EdgeInsets.all(10.0),
        color: Colors.white,
        child: new Text('Any affordable virgin olive oil works nicely for this recipe. If you plan on using your Canna Oil for salad dressings or pasta, we recommend you use a fruity extra-virgin olive oil.',
            style: new TextStyle(
              fontSize: 15.0,
              color: Color(0xFF9498A1),
            ),
        ),
      ),
    );
  }
}

class _ingredients extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.grey[200],
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: new Container(
        color: Colors.white,
        padding: EdgeInsets.all(10.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text('Ingredients',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Color(0xFF161616),
              fontSize: 22.0
            ),
            ),
            new Row(
              children: <Widget>[
                new Expanded(
                    child: new Text('2 Servings',
                    style: new TextStyle(
                      fontSize: 15.0,
                      color: Color(0xFF9498A1),
                    ),
                    )
                ),
                new IconButton(icon: new Icon(FontAwesomeIcons.plusSquare), color: Color(0xFF00ADB2), iconSize: 20.0, onPressed: () {
                  print('add');
                }),
                new IconButton(icon: new Icon(FontAwesomeIcons.minusSquare), color: Color(0xFF00ADB2), iconSize: 20.0, onPressed: () {
                  print('substract');
                }),
              ],
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: new Row(
                children: <Widget>[
                  new Icon(FontAwesomeIcons.solidCheckSquare, color: Color(0xFF00ADB2), size: 15.0,),
                  new Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: new Text('15 ounces of cannellini beans, drained and rinsed',
                      style: new TextStyle(
                        color: Color(0xFF161616),
                        fontSize: 11.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),


          ],
        ),
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