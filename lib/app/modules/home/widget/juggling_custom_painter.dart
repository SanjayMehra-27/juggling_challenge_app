import 'dart:math';

import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class JugglingCustomPainter extends CustomPainter {
  final ui.Image? image;
  final Color? color;
  JugglingCustomPainter({this.image, this.color = Colors.red});
  @override
  void paint(Canvas canvas, Size size) {
    // paint for top line
    final topPaint = Paint()
      ..color = color!
      ..strokeWidth = 15
      ..style = PaintingStyle.stroke;

    // bottom line paint : will draw bottom line with triangle shape in middle
    final bottomPaint = Paint()
      ..color = color!
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    // squarePaint : will draw left and right square box
    final squarePaint = Paint()
      ..color = color!
      ..style = PaintingStyle.fill;

    /**
     * Draw two lines on left and right side with 33.3% of width and in middle draw half Hexagon shape with 33.3% of width
     */

    // top score line points to draw
    final points = [
      Offset(0, 0),
      // x: 33.3% of width , y: 0
      Offset(size.width * 1 / 3, 0),
      // x: 33.3% + 20 of width , y: 30
      Offset(size.width * 1 / 3 + 20, 30),
      // x: 66.6% - 20 of width , y: 30
      Offset(size.width * 2 / 3 - 20, 30),
      // x: 66.6% of width , y: 0
      Offset(size.width * 2 / 3, 0),
      // Offset(size.width / 1.6, 30),
      Offset(size.width, 0),

      // For fill the area for image
      Offset(size.width, size.height),
      Offset(0, size.height),
      Offset(0, 0),
    ];

    // path for top line
    final path = Path()..addPolygon(points, false);
    canvas.drawPath(path, topPaint);

    /**
     *  Draw Bottom Score Tile with Triangle Shape in middle & Square Box on left and right side
     *  [with the base of y: size.height + 70]
     */

    // bottom score tile points to draw
    final bottomShapePoints = [
      Offset(0, size.height + 70),
      // x: 33.3% of width + 30 , y: 70
      Offset(size.width * 1 / 3 + 30, size.height + 70),
      // x: 50.0% of width , y: 70 + 30 [make point of triangle on center]
      Offset(size.width * 0.5, size.height + 100),
      // x: 66.6% of width - 30 , y: 70
      Offset(size.width * 2 / 3 - 30, size.height + 70),
      // x: 100% of width , y: 70
      Offset(size.width, size.height + 70),
    ];

    // path for left and right square box
    final squarePath = Path()
      ..addRect(Rect.fromPoints(
          Offset(0, 0), Offset(size.width * 0.25, size.height + 70)))
      ..addRect(Rect.fromPoints(
          Offset(size.width * 0.75, 0), Offset(size.width, size.height + 70)));

    // path for bottom line with triangle shape
    final bottomShapePath = Path()..addPolygon(bottomShapePoints, false);
    // draw all path
    canvas.drawPath(bottomShapePath, bottomPaint);
    canvas.drawPath(squarePath, squarePaint);

    /**
     *  Draw Score Text e.g. [13 Juggles 5]
     */
    final textSpan1 = TextSpan(
      text: '13',
      style: TextStyle(
          fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
    );
    final textSpan2 = TextSpan(
      text: 'Juggles',
      style: TextStyle(fontSize: 18, color: Colors.white),
    );
    final textSpan3 = TextSpan(
      text: '5',
      style: TextStyle(
          fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
    );

    final textPainter1 = TextPainter(
      text: textSpan1,
      textDirection: TextDirection.ltr,
    );
    final textPainter2 = TextPainter(
      text: textSpan2,
      textDirection: TextDirection.ltr,
    );
    final textPainter3 = TextPainter(
      text: textSpan3,
      textDirection: TextDirection.ltr,
    );
    textPainter1.layout(minWidth: 0, maxWidth: size.width);
    textPainter2.layout(minWidth: 0, maxWidth: size.width);
    textPainter3.layout(minWidth: 0, maxWidth: size.width);
    textPainter1.paint(canvas, Offset(size.width * 0.30, size.height + 20));
    textPainter2.paint(canvas, Offset(size.width / 2 - 30, size.height + 27));
    textPainter3.paint(canvas, Offset(size.width * 0.65, size.height + 20));

    /**
     *  Draw Image in our custom shape
     */

    // Create a new path to use as the clipping area
    Path clipPath = Path()..addPath(path, Offset(0, 0));

    // Clip the canvas to the clipping area
    canvas.clipPath(clipPath);

    // Calculate the scaling factor to fit the image inside the shape
    double scaleX = path.getBounds().width / image!.width;
    double scaleY = path.getBounds().height / image!.height;
    double scale = max(scaleX, scaleY);

    // Create a new Rect that is the size of the shape
    Rect rect = path.getBounds();

    // Translate the canvas so that the top-left corner of the Rect is at (0, 0)
    canvas.translate(rect.left, rect.top);

    // Scale the canvas so that the image fits inside the Rect
    canvas.scale(scale, scale);

    // Draw the image
    canvas.drawImage(image!, Offset.zero, Paint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
