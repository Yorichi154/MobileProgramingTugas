import 'package:flutter/material.dart';

/// Custom clipper untuk membuat shape wave/bentuk gelombang di bagian bawah widget
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.8);

    final firstControlPoint = Offset(size.width * 0.25, size.height);
    final firstEndPoint = Offset(size.width * 0.5, size.height * 0.8);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    final secondControlPoint = Offset(size.width * 0.75, size.height * 0.6);
    final secondEndPoint = Offset(size.width, size.height * 0.8);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/// Custom clipper untuk membuat shape rounded corner dengan radius berbeda di tiap sisi
class UnevenRoundedRectangleClipper extends CustomClipper<Path> {
  final double topLeft;
  final double topRight;
  final double bottomLeft;
  final double bottomRight;

  const UnevenRoundedRectangleClipper({
    this.topLeft = 0,
    this.topRight = 0,
    this.bottomLeft = 0,
    this.bottomRight = 0,
  });

  @override
  Path getClip(Size size) {
    final radius = Radius.elliptical(20, 20);
    final path = Path()
      ..moveTo(topLeft, 0)
      ..lineTo(size.width - topRight, 0)
      ..arcToPoint(
        Offset(size.width, topRight),
        radius: Radius.circular(topRight),
      )
      ..lineTo(size.width, size.height - bottomRight)
      ..arcToPoint(
        Offset(size.width - bottomRight, size.height),
        radius: Radius.circular(bottomRight),
      )
      ..lineTo(bottomLeft, size.height)
      ..arcToPoint(
        Offset(0, size.height - bottomLeft),
        radius: Radius.circular(bottomLeft),
      )
      ..lineTo(0, topLeft)
      ..arcToPoint(
        Offset(topLeft, 0),
        radius: Radius.circular(topLeft),
      )
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
