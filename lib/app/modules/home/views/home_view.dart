import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../widget/juggling_custom_painter.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 41, 41),
      body: SafeArea(
        child: Stack(
          children: [
            //? Header Title
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

            //? Draw Juggling Custom Painter Image With Score Tile
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

            //? ICONS [Profile, Comment, Share]
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
