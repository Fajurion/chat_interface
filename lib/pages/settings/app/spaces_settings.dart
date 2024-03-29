import 'package:chat_interface/pages/settings/components/bool_selection_small.dart';
import 'package:chat_interface/pages/settings/data/entities.dart';
import 'package:chat_interface/pages/settings/data/settings_manager.dart';
import 'package:flutter/material.dart';

class SpacesSettings {
  static const String gameMusic = "game.music";

  static void addSpacesSettings(SettingController controller) {
    controller.settings[SpacesSettings.gameMusic] =
        Setting<bool>(SpacesSettings.gameMusic, true);
  }
}

class SpacesSettingsPage extends StatelessWidget {
  const SpacesSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [BoolSettingSmall(settingName: SpacesSettings.gameMusic)],
    );
  }
}
