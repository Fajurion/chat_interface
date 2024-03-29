import 'package:chat_interface/connection/messaging.dart';
import 'package:chat_interface/connection/spaces/space_connection.dart';
import 'package:chat_interface/controller/conversation/spaces/game_hub_controller.dart';
import 'package:chat_interface/util/logging_framework.dart';
import 'package:get/get.dart';

void setupGameListeners() {
  // Listen for session changes
  spaceConnector.listen(
      "session_update", (event) => handleSessionUpdate(event));
  spaceConnector.listen("session_close", (event) => handleSessionClose(event));
}

void handleSessionUpdate(Event event) {
  final session = event.data["session"] as String;
  final controller = Get.find<GameHubController>();

  if (controller.sessions.containsKey(session)) {
    // Update member list
    controller.sessions[session]!.members.clear();
    for (var member in event.data["members"]) {
      controller.sessions[session]!.members.add(member);
    }
    controller.sessions[session]!.gameState.value = event.data["state"];
  } else {
    // Add new session
    controller.sessions[session] = GameSession(
        session, event.data["game"], event.data["min"], event.data["max"]);
    controller.sessions[session]!.gameState.value = event.data["state"];
    sendLog("New session: ${event.data["members"]}");
    for (var member in event.data["members"]) {
      controller.sessions[session]!.members.add(member);
    }
  }
}

void handleSessionClose(Event event) {
  final session = event.data["session"] as String;
  final controller = Get.find<GameHubController>();

  if (controller.sessions.containsKey(session)) {
    controller.sessions.remove(session);
    if (controller.engine.value?.sessionId == session) {
      controller.engine.value = null;
    }
  }
}
