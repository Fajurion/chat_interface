import 'dart:async';
import 'dart:convert';

import 'package:chat_interface/controller/conversation/attachment_controller.dart';
import 'package:chat_interface/controller/conversation/spaces/tabletop/tabletop_controller.dart';
import 'package:chat_interface/util/logging_framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class CardObject extends TableObject {
  bool error = false;

  CardObject(super.id, super.location, super.size, super.type);

  @override
  void render(Canvas canvas, Offset location, TabletopController controller) {
    if (error) {
      final paint = Paint()..color = Colors.red;
      canvas.drawRect(Rect.fromLTWH(location.dx, location.dy, 100, 100), paint);
      return;
    }

    // Draw a stack
    final paint = Paint()..color = Colors.blue;
    canvas.drawRect(Rect.fromLTWH(location.dx, location.dy, size.width, size.height), paint);
  }

  @override
  void importData(String data) async {
    // Download attached container
    final json = jsonDecode(data);
    final type = await AttachmentController.checkLocations(json["id"], StorageType.cache);
    final container = AttachmentContainer.fromJson(type, jsonDecode(data));
    final download = await Get.find<AttachmentController>().downloadAttachment(container);
    if (!download) {
      error = true;
      sendLog("failed to download card");
      return;
    }

    Timer.periodic(500.ms, (timer) {
      error = false;
      size = const Size(1000, 900);
      timer.cancel();
    });
  }

  @override
  void runAction(TabletopController controller) {
    sendLog("action executed on a card");
  }
}
