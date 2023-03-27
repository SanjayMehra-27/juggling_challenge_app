import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

class HomeController extends GetxController {
  ui.Image? image;
  int shuffler = 0;
  var defaultPaintColor = Colors.red;

  @override
  Future<void> onInit() async {
    await loadImage('assets/images/juggling_image.jpg');
    super.onInit();
  }

  Future<void> loadImage(String path) async {
    final data = await rootBundle.load(path);
    final bytes = data.buffer.asUint8List();
    final image = await decodeImageFromList(bytes);
    this.image = image;
    log('image loaded: ${image.width}x${image.height}');
    update(['image'], true);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeImage() {
    if (shuffler == 0) {
      shuffler = 1;
    } else {
      shuffler = 0;
    }
    // change image according to shuffler
    switch (shuffler) {
      case 0:
        loadImage('assets/images/juggling_image.jpg');
        defaultPaintColor = Colors.red;
        break;
      case 1:
        loadImage('assets/images/2.jpg');
        defaultPaintColor = Colors.blue;
        break;
      default:
        loadImage('assets/images/juggling_image.jpg');
        defaultPaintColor = Colors.red;
    }

    // chnage custom painter color also
    update(['image'], true);
  }
}
