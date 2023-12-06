import 'dart:async';

import 'package:chat_interface/controller/conversation/spaces/audio_controller.dart';
import 'package:chat_interface/controller/conversation/spaces/spaces_controller.dart';
import 'package:chat_interface/theme/components/icon_button.dart';
import 'package:chat_interface/util/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CallControls extends StatefulWidget {
  const CallControls({super.key});

  @override
  State<CallControls> createState() => _CallControlsState();
}

class _CallControlsState extends State<CallControls> {

  StreamSubscription<dynamic>? subscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final controller = Get.find<SpacesController>();
    ThemeData theme = Theme.of(context);

    return Hero(
      tag: "call_controls",
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
    
          //* Microphone button
          CallButtonBorder(
            child: GetX<AudioController>(
              builder: (controller) {
                return LoadingIconButton(
                  padding: defaultSpacing + elementSpacing,
                  loading: controller.muteLoading,
                  onTap: () => controller.setMuted(!controller.muted.value),
                  icon: controller.muted.value ? Icons.mic_off : Icons.mic,
                  iconSize: 35,
                  color: theme.colorScheme.onSurface
                ); 
              },
            ),
          ),
    
          horizontalSpacing(defaultSpacing),
    
          //* Audio output
          CallButtonBorder(
            child: GetX<AudioController>(
              builder: (controller) {
                return LoadingIconButton(
                  padding: defaultSpacing + elementSpacing,
                  loading: controller.deafenLoading,
                  onTap: () => controller.setDeafened(!controller.deafened.value),
                  icon: controller.deafened.value ? Icons.volume_off : Icons.volume_up,
                  iconSize: 35,
                  color: theme.colorScheme.onSurface
                ); 
              },
            ),
          ),
    
          horizontalSpacing(defaultSpacing),
    
          //* Play mode
          Obx(() =>
            CallButtonBorder(
              gradient: true,
              child: LoadingIconButton(
                padding: defaultSpacing + elementSpacing,
                loading: false.obs,
                onTap: () => Get.find<SpacesController>().switchToPlayMode(),
                icon: controller.playMode.value ? Icons.graphic_eq : Icons.videogame_asset,
                color: theme.colorScheme.tertiary,
                iconSize: 35,
              ),
            )
          ),
          
          horizontalSpacing(defaultSpacing),
    
          //* End call button
          CallButtonBorder(
            child: LoadingIconButton(
              padding: defaultSpacing + elementSpacing,
              loading: false.obs,
              onTap: () => Get.find<SpacesController>().leaveCall(),
              icon: Icons.call_end,
              color: theme.colorScheme.error,
              iconSize: 35,
            ),
          )
        ],
      ),
    );
  }
}

class CallButtonBorder extends StatelessWidget {

  final bool gradient;
  final Widget child;

  const CallButtonBorder({super.key, required this.child, this.gradient = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Get.theme.colorScheme.primaryContainer,
        gradient: gradient ? LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Get.theme.colorScheme.primaryContainer,
            Get.theme.colorScheme.tertiaryContainer
          ]
        ) : null
      ),
      child: child,
    );
  }
}