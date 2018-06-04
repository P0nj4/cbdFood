import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NetImage extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final double height;
  final double width;

  NetImage({Key key, @required this.url, this.fit, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return new CachedNetworkImage(imageUrl: url,
      fit: fit == null ? BoxFit.cover : fit,
      height: height,
      width: width,
      placeholder: new Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

}