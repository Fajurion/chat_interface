import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:chat_interface/connection/encryption/symmetric_sodium.dart';
import 'package:chat_interface/controller/account/friend_controller.dart';
import 'package:chat_interface/controller/conversation/attachment_controller.dart';
import 'package:chat_interface/controller/current/status_controller.dart';
import 'package:chat_interface/pages/chat/components/message/message_feed.dart';
import 'package:chat_interface/pages/status/setup/encryption/key_setup.dart';
import 'package:chat_interface/util/snackbar.dart';
import 'package:chat_interface/util/web.dart';
import 'package:drift/drift.dart';
import 'package:file_selector/file_selector.dart';
import 'package:get/get.dart';

class ProfilePictureHelper {

  /// Download the profile picture of a friend.
  /// Returns the file ID associated with the profile picture.
  static Future<String?> downloadProfilePicture(Friend friend) async {
    return null;
  }

  /// Upload a profile picture to the server and set it as the current profile picture
  static Future<bool> uploadProfilePicture(XFile file, ProfilePictureData data) async {

    // Upload the file
    final response = await Get.find<AttachmentController>().uploadFile(UploadData(file));
    if(!response.success) {
      showErrorPopup("error", "profile_picture.not_uploaded");
      return false;
    }

    // Update the profile picture
    final json = await postAuthorizedJSON("/account/profile/set_picture", {
      "file": response.container.id,
      "data": encryptSymmetric(jsonEncode(data.toJson()), profileKey),
      "container": encryptSymmetric(jsonEncode(response.container.toJson()), profileKey)
    });

    if(!json["success"]) {
      showErrorPopup("error", "profile_picture.not_set");
      return false;
    }
    Get.find<StatusController>().newProfilePicture(response.container.id, data);

    // TODO: Update for other devices
    return true;
  }

  static Future<ui.Image> loadImage(String path) async {
    final Uint8List data = await File(path).readAsBytes();
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(data, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

}

/// Class for storing the data of a profile picture (scale factor, x/y position)
class ProfilePictureData {
  final double scaleFactor, moveX, moveY;
  ProfilePictureData(this.scaleFactor, this.moveX, this.moveY);

  factory ProfilePictureData.fromJson(Map<String, dynamic> json) => ProfilePictureData(
    json["s"],
    json["x"],
    json["y"],
  );

  Map<String, dynamic> toJson() => {
    "s": scaleFactor,
    "x": moveX,
    "y": moveY,
  };
}