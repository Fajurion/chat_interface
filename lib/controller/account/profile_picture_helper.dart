import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:chat_interface/connection/encryption/symmetric_sodium.dart';
import 'package:chat_interface/controller/account/friend_controller.dart';
import 'package:chat_interface/controller/conversation/attachment_controller.dart';
import 'package:chat_interface/controller/current/status_controller.dart';
import 'package:chat_interface/database/database.dart';
import 'package:chat_interface/pages/chat/components/message/message_feed.dart';
import 'package:chat_interface/pages/status/setup/encryption/key_setup.dart';
import 'package:chat_interface/util/logging_framework.dart';
import 'package:chat_interface/util/snackbar.dart';
import 'package:chat_interface/util/web.dart';
import 'package:drift/drift.dart';
import 'package:file_selector/file_selector.dart';
import 'package:get/get.dart';

class ProfilePictureHelper {
  /// Download the profile picture of a friend.
  /// Returns the file ID associated with the profile picture.
  static Future<String?> downloadProfilePicture(Friend friend) async {
    // Get old profile picture
    final oldProfile = await (db.profile.select()
          ..where((tbl) => tbl.id.equals(friend.id)))
        .getSingleOrNull();

    final json =
        await postAuthorizedJSON("/account/profile/get", <String, dynamic>{
      "id": friend.id,
    });

    if (!json["success"]) {
      return null;
    }

    // Check if there is a new name and tag (also handled by the profile endpoint)
    if (json["name"] != friend.name || json["tag"] != friend.tag) {
      friend.name = json["name"];
      friend.tag = json["tag"];
      await friend.update();
    }

    String? oldPictureId;
    String? oldPath;
    if (oldProfile != null) {
      oldPictureId = jsonDecode(oldProfile.pictureContainer)["id"];
      oldPath = await AttachmentController.getFilePathFor(oldPictureId!);
      if (json["profile"]["picture"] == oldPictureId && oldPath != null) {
        return null; // Nothing changed
      }
    }

    // Decrypt the profile picture data
    final profileData = ProfilePictureData.fromJson(jsonDecode(decryptSymmetric(
        json["profile"]["picture_data"], friend.keyStorage.profileKey)));
    final container = AttachmentContainer.fromJson(
        StorageType.permanent,
        jsonDecode(decryptSymmetric(
            json["profile"]["container"], friend.keyStorage.profileKey)));

    if (container.id != json["profile"]["picture"]) {
      return null;
    }

    if (oldProfile != null && oldPath != null) {
      // Check if there is an attachment in any message using the file from the old profile picture
      final messages = await (db.message.select()
            ..where((tbl) => tbl.attachments.contains(oldPictureId!)))
          .get();
      if (messages.isEmpty) {
        await File(oldPath).delete();
      }
    }

    // Download the file
    final success =
        await Get.find<AttachmentController>().downloadAttachment(container);
    if (!success) {
      return null;
    }

    // Delete old profile
    if (oldProfile != null) {
      await (db.profile.delete()..where((tbl) => tbl.id.equals(friend.id)))
          .go();
    }

    // Save the profile picture data
    friend.updateProfilePicture(container, profileData);

    return json["profile"]["id"];
  }

  /// Upload a profile picture to the server and set it as the current profile picture
  static Future<bool> uploadProfilePicture(
      XFile file, ProfilePictureData data) async {
    // Upload the file
    final response = await Get.find<AttachmentController>()
        .uploadFile(UploadData(file), StorageType.permanent);
    if (response.container == null) {
      showErrorPopup("error", "profile_picture.not_uploaded");
      return false;
    }

    // Update the profile picture
    final json = await postAuthorizedJSON("/account/profile/set_picture", {
      "file": response.container!.id,
      "data": encryptSymmetric(jsonEncode(data.toJson()), profileKey),
      "container": encryptSymmetric(
          jsonEncode(response.container!.toJson()), profileKey),
    });

    if (!json["success"]) {
      showErrorPopup("error", "profile_picture.not_set");
      return false;
    }
    Get.find<FriendController>()
        .friends[StatusController.ownAccountId]!
        .updateProfilePicture(response.container!, data);

    // TODO: Update for other devices
    return true;
  }

  /// Get the file id of the profile picture of a friend
  static Future<ProfileData?> getProfileDataLocal(String id) async {
    final profile = await (db.profile.select()
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    return profile;
  }

  static Future<ui.Image?> loadImage(String path) async {
    final file = File(path);
    final exists = await file.exists();
    if (!exists) {
      sendLog("DOESNT EXIST: $path");
      return null;
    }
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

  factory ProfilePictureData.fromJson(Map<String, dynamic> json) =>
      ProfilePictureData(
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
