import 'package:chat_interface/controller/current/status_controller.dart';
import 'package:chat_interface/pages/status/error/server_offline_page.dart';
import 'package:chat_interface/pages/status/setup/setup_manager.dart';
import 'package:chat_interface/util/web.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountSetup extends Setup {
  AccountSetup() : super('loading.account', false);
  
  @override
  Future<Widget?> load() async {

    // Get account from database
    final body = await postAuthorizedJSON("/account/me", <String, dynamic>{});
    final account = body["account"];

    if(!body["success"]) {
      return const ServerOfflinePage();
    }

    // Set all account data
    StatusController controller = Get.find();
    controller.name.value = account["username"];
    controller.tag.value = account["tag"];
    controller.id.value = account["id"];
    StatusController.ownAccountId = account["id"];

    // Set all permissions
    StatusController.permissions = List<String>.from(body["permissions"]);

    return null;
  }
}