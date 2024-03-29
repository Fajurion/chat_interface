import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:chat_interface/controller/conversation/attachment_controller.dart';
import 'package:chat_interface/controller/conversation/spaces/tabletop/tabletop_controller.dart';
import 'package:chat_interface/controller/conversation/spaces/tabletop/tabletop_deck.dart';
import 'package:chat_interface/pages/spaces/tabletop/tabletop_page.dart';
import 'package:chat_interface/theme/ui/dialogs/attachment_window.dart';
import 'package:chat_interface/util/logging_framework.dart';
import 'package:chat_interface/util/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardObject extends TableObject {
  late AttachmentContainer container;
  bool error = false;
  bool downloaded = false;
  bool inventory = false;
  ui.Image? image;
  Size? imageSize;

  CardObject(String id, Offset location, Size size) : super(id, location, size, TableObjectType.card);

  static Future<CardObject?> downloadCard(AttachmentContainer container, Offset location, {String id = ""}) async {
    // Download the file
    final download = await Get.find<AttachmentController>().downloadAttachment(container);
    if (!download) {
      return null;
    }

    // Grab resolution from it
    final buffer = await ui.ImmutableBuffer.fromUint8List(await File(container.filePath).readAsBytes());
    final descriptor = await ui.ImageDescriptor.encoded(buffer);
    final size = Size(descriptor.width.toDouble(), descriptor.height.toDouble());

    // Make size fit with canvas standards (700x700 in this case)
    final normalized = normalizeSize(size, 900);
    final obj = CardObject(
      id,
      location,
      normalized,
    );
    obj.container = container;

    // Set image
    final codec = await descriptor.instantiateCodec();
    obj.downloaded = true;
    obj.image = (await codec.getNextFrame()).image;
    obj.imageSize = size;

    return obj;
  }

  /// Function to make sure images don't get too big
  static Size normalizeSize(Size size, double targetSize) {
    if (size.width > size.height) {
      final decreasingFactor = targetSize / size.width;
      size = Size((size.width * decreasingFactor).roundToDouble(), (size.height * decreasingFactor).roundToDouble());
    } else {
      final decreasingFactor = targetSize / size.height;
      size = Size((size.width * decreasingFactor).roundToDouble(), (size.height * decreasingFactor).roundToDouble());
    }

    return size;
  }

  @override
  void render(Canvas canvas, Offset location, TabletopController controller) {
    if (error) {
      final paint = Paint()..color = Colors.red;
      canvas.drawRect(Rect.fromLTWH(location.dx, location.dy, size.width, size.height), paint);
      return;
    }

    // Draw the card
    if (downloaded) {
      final paint = Paint()..color = Colors.white;

      // Show that the card is about to be dropped
      if (controller.heldObject == this && controller.hoveringObjects.any((element) => element is DeckObject) && !controller.dropMode) {
        paint.color = Colors.white.withOpacity(0.5);
      }

      final imageRect = Rect.fromLTWH(location.dx, location.dy, size.width, size.height);
      canvas.clipRRect(RRect.fromRectAndRadius(imageRect, const Radius.circular(sectionSpacing * 4)));
      canvas.drawImageRect(
        image!,
        Rect.fromLTWH(0, 0, size.width * (imageSize!.width / size.width), size.height * (imageSize!.height / size.height)),
        imageRect,
        paint,
      );
      return;
    }

    final paint = Paint()..color = Colors.blue;
    canvas.drawRect(Rect.fromLTWH(location.dx, location.dy, size.width, size.height), paint);
  }

  @override
  void handleData(String data) async {
    sendLog("handling data");
    // Download attached container
    final json = jsonDecode(data);
    final type = await AttachmentController.checkLocations(json["id"], StorageType.cache);
    container = AttachmentContainer.fromJson(type, jsonDecode(data));
    final download = await Get.find<AttachmentController>().downloadAttachment(container);
    if (!download) {
      error = true;
      sendLog("failed to download card");
      return;
    }

    // Get image from file
    final buffer = await ui.ImmutableBuffer.fromUint8List(await File(container.filePath).readAsBytes());
    final descriptor = await ui.ImageDescriptor.encoded(buffer);
    final codec = await descriptor.instantiateCodec();
    image = (await codec.getNextFrame()).image;
    imageSize = Size(descriptor.width.toDouble(), descriptor.height.toDouble());
    downloaded = true;
  }

  @override
  String getData() {
    return jsonEncode(container.toJson());
  }

  @override
  void runAction(TabletopController controller) {
    if (inventory) {
      Get.dialog(ImagePreviewWindow(file: File(container.filePath)));
    }
  }

  @override
  List<ContextMenuAction> getContextMenuAdditions() {
    return [
      ContextMenuAction(
        icon: Icons.login,
        label: 'Put into inventory',
        onTap: (controller) {
          intoInventory(controller);
        },
      ),
    ];
  }

  void intoInventory(TabletopController controller, {int? index}) {
    final localPos = TabletopView.worldToLocalPos(location, controller.canvasZoom, controller.canvasOffset, controller);
    positionX.setRealValue(localPos.dx);
    positionY.setRealValue(localPos.dy);
    sendRemove();
    if (index != null) {
      controller.inventory.insert(index, this);
    } else {
      controller.inventory.add(this);
    }
  }
}
