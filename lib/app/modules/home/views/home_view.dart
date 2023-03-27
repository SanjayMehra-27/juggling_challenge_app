import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'dart:ui' as ui;
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 41, 41),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: Get.height * 0.10, // 10% of height
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Text(
                        "Juggle Challenge",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "12:34",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )),
            ),

            // draw : top header line
            GetBuilder(
                assignId: true,
                init: controller,
                id: "image",
                global: false,
                builder: (HomeController controller) {
                  return Positioned(
                    top: Get.height * 0.16, // 16% of height
                    child: Container(
                      height: Get.height * 0.60, // 60.0% of height
                      width: MediaQuery.of(context).size.width,
                      child: controller.image == null
                          ? Center(
                              child: Container(
                                child: Text("Loading..."),
                              ),
                            )
                          : GestureDetector(
                              onTap: controller.changeImage,
                              child: CustomPaint(
                                size: Size.infinite,
                                painter: JugglingCustomPainter(
                                  image: controller.image!,
                                  color: controller.defaultPaintColor,
                                ),
                              ),
                            ),
                    ),
                  );
                }),
            Positioned(
              top: Get.height * 0.5, // 50% of height
              right: Get.width * 0.05, // 5% of width
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Profile Icon
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      //Comment Icon
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.comment,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      // share Icon
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.share,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

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

    // path for left and right square box
    final squarePath = Path()
      ..addRect(Rect.fromPoints(
          Offset(0, 0), Offset(size.width * 0.25, size.height + 70)))
      ..addRect(Rect.fromPoints(
          Offset(size.width * 0.75, 0), Offset(size.width, size.height + 70)));

    // points for bottom line with triangle shape [with the base of y: 70]
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

    // path for bottom line with triangle shape
    final bottomShapePath = Path()..addPolygon(bottomShapePoints, false);
    // draw all path
    canvas.drawPath(bottomShapePath, bottomPaint);
    canvas.drawPath(squarePath, squarePaint);

    // Draw Score Text
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

    // points [draw two lines on left and right side with 33.3% of width and in middle draw half Hexagon shape with 33.3% of width]
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
