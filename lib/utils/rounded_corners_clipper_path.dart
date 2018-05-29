import 'package:flutter/material.dart';

class RoundedCornersClipperPath extends CustomClipper<Path> {

  final cornerRadius;

  RoundedCornersClipperPath({this.cornerRadius = 15.0});

  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0.0, size.height - cornerRadius);
    path.quadraticBezierTo(0.0, size.height, cornerRadius, size.height);
    path.lineTo(size.width - cornerRadius, size.height);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height - cornerRadius);
    path.lineTo(size.width, cornerRadius);
    path.quadraticBezierTo(size.width, 0.0, size.width - cornerRadius, 0.0);
    path.lineTo(cornerRadius, 0.0);
    path.quadraticBezierTo(0.0, 0.0, 0.0, cornerRadius);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return cornerRadius != cornerRadius;
  }
}