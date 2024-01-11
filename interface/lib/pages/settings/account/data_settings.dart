import 'package:chat_interface/controller/current/status_controller.dart';
import 'package:chat_interface/pages/settings/account/change_name_window.dart';
import 'package:chat_interface/theme/components/fj_button.dart';
import 'package:chat_interface/theme/components/user_renderer.dart';
import 'package:chat_interface/theme/ui/dialogs/confirm_window.dart';
import 'package:chat_interface/theme/ui/dialogs/profile_picture_window.dart';
import 'package:chat_interface/util/snackbar.dart';
import 'package:chat_interface/util/vertical_spacing.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sodium_libs/sodium_libs.dart';

class DataSettingsPage extends StatelessWidget {
  const DataSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StatusController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //* Profile picture
        Text("settings.data.profile_picture".tr, style: Get.theme.textTheme.labelLarge),
        verticalSpacing(defaultSpacing),

        Container(
          decoration: BoxDecoration(
            color: Get.theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(sectionSpacing),
          ),
          padding: const EdgeInsets.all(sectionSpacing),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("settings.data.profile_picture.requirements".tr, style: Get.theme.textTheme.bodyMedium),
                    verticalSpacing(defaultSpacing),
                    Row(
                      children: [
                        FJElevatedButton(
                          smallCorners: true,
                          onTap: () async {
                            final result = await openFile();
                            if (result == null) {
                              return;
                            }
                            final size = await result.length();
                            if (size > 10 * 1000 * 1000) {
                              showErrorPopup("error".tr, "settings.data.profile_picture.requirements".tr);
                              return;
                            }

                            final fileType = result.path.split(".").last;
                            if (!["jpeg", "jpg", "png"].contains(fileType)) {
                              showErrorPopup("error".tr, "settings.data.profile_picture.requirements".tr);
                              return;
                            }

                            Get.dialog(ProfilePictureWindow(file: result));
                          },
                          child: Text("change".tr, style: Get.theme.textTheme.labelMedium),
                        ),
                        horizontalSpacing(defaultSpacing),
                        IconButton(
                          tooltip: "settings.data.profile_picture.remove".tr,
                          onPressed: () => showConfirmPopup(
                            ConfirmWindow(
                              title: "settings.data.profile_picture.remove".tr,
                              text: "settings.data.profile_picture.remove.confirm".tr,
                              onConfirm: () => {},
                              onDecline: () => {},
                            ),
                          ),
                          icon: Icon(Icons.delete, color: Get.theme.colorScheme.onPrimary),
                        )
                      ],
                    )
                  ],
                ),
              ),
              UserAvatar(
                id: StatusController.ownAccountId,
                size: 100,
              )
            ],
          ),
        ),
        verticalSpacing(sectionSpacing),

        //* Name settings
        Text("Account data".tr, style: Get.theme.textTheme.labelLarge),
        verticalSpacing(defaultSpacing),

        //* Username
        Container(
          decoration: BoxDecoration(
            color: Get.theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(sectionSpacing),
          ),
          padding: const EdgeInsets.all(sectionSpacing),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("username".tr, style: Get.theme.textTheme.labelMedium),
                  verticalSpacing(elementSpacing),
                  Text(
                    "${controller.name.value}#${controller.tag.value.toCharArray().map((e) => "*").toList().join("")}",
                    style: Get.theme.textTheme.bodyMedium,
                  ),
                ],
              ),
              horizontalSpacing(defaultSpacing),
              FJElevatedButton(
                smallCorners: true,
                onTap: () => Get.dialog(const ChangeNameWindow()),
                child: Text("change".tr, style: Get.theme.textTheme.labelMedium),
              ),
            ],
          ),
        ),
        verticalSpacing(defaultSpacing),

        //* Password
        Container(
          decoration: BoxDecoration(
            color: Get.theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(sectionSpacing),
          ),
          padding: const EdgeInsets.all(sectionSpacing),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("password".tr, style: Get.theme.textTheme.labelMedium),
                    verticalSpacing(elementSpacing),
                    Text("settings.data.password.description".tr, style: Get.theme.textTheme.bodyMedium),
                  ],
                ),
              ),
              horizontalSpacing(defaultSpacing),
              FJElevatedButton(
                smallCorners: true,
                onTap: () => {},
                child: Text("change".tr, style: Get.theme.textTheme.labelMedium),
              ),
            ],
          ),
        ),
        verticalSpacing(defaultSpacing),

        //* Email
        Container(
          decoration: BoxDecoration(
            color: Get.theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(sectionSpacing),
          ),
          padding: const EdgeInsets.all(sectionSpacing),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("email".tr, style: Get.theme.textTheme.labelMedium),
                    verticalSpacing(elementSpacing),
                    Text("settings.data.email.description".tr, style: Get.theme.textTheme.bodyMedium),
                  ],
                ),
              ),
              horizontalSpacing(defaultSpacing),
              FJElevatedButton(
                smallCorners: true,
                onTap: () => {},
                child: Text("change".tr, style: Get.theme.textTheme.labelMedium),
              ),
            ],
          ),
        ),
        verticalSpacing(sectionSpacing),

        //* Log out
        Text("settings.data.log_out".tr, style: Get.theme.textTheme.labelLarge),
        verticalSpacing(defaultSpacing),
        Text("settings.data.log_out.description".tr, style: Get.theme.textTheme.bodyMedium),
        /*
        verticalSpacing(defaultSpacing),
        FJElevatedButton(
          smallCorners: true,
          onTap: () => {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.logout, color: Get.theme.colorScheme.onPrimary),
              horizontalSpacing(defaultSpacing),
              Text("settings.data.log_out.button".tr, style: Get.theme.textTheme.labelMedium),
            ],
          ),
        ),*/
        verticalSpacing(sectionSpacing),

        //* Danger zone
        Text("settings.data.danger_zone".tr, style: Get.theme.textTheme.labelLarge),
        verticalSpacing(defaultSpacing),
        Text("settings.data.danger_zone.description".tr, style: Get.theme.textTheme.bodyMedium),
        verticalSpacing(defaultSpacing),

        //* Danger zone actions
        FJElevatedButton(
          smallCorners: true,
          onTap: () {
            showConfirmPopup(ConfirmWindow(
              title: "settings.data.danger_zone.delete_account".tr,
              text: "settings.data.danger_zone.delete_account.confirm".tr,
              onConfirm: () => {},
              onDecline: () => {},
            ));
          },
          color: Get.theme.colorScheme.errorContainer,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.delete, color: Get.theme.colorScheme.error),
              horizontalSpacing(defaultSpacing),
              Text("settings.data.danger_zone.delete_account".tr, style: Get.theme.textTheme.labelMedium),
            ],
          ),
        ),

        verticalSpacing(sectionSpacing),

        //* Permissions (debug)
        Text("settings.data.permissions".tr, style: Get.theme.textTheme.labelLarge),
        verticalSpacing(defaultSpacing),
        Text("settings.data.permissions.description".tr, style: Get.theme.textTheme.bodyMedium),
        Text(StatusController.permissions.join(", "), style: Get.theme.textTheme.labelMedium),
      ],
    );
  }
}
