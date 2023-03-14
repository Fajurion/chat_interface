import 'package:chat_interface/controller/chat/conversation_controller.dart';
import 'package:chat_interface/database/database.dart';
import 'package:chat_interface/pages/status/setup/setup_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConversationSetup extends Setup {
  ConversationSetup() : super("loading.conversation", false);

  @override
  Future<Widget?> load() async {

    ConversationController controller = Get.find();
    controller.conversations.clear();

    // Get conversations from database
    final list = await (db.select(db.conversation)).get();
    controller.conversations.addAll(list.map((e) => Conversation.fromData(e)));

    return null;
  } 
  
}