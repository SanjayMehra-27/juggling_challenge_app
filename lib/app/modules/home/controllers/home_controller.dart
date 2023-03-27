import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

class HomeController extends GetxController {
  ui.Image? image;

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
}
