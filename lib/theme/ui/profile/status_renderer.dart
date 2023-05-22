import 'package:chat_interface/util/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusRenderer extends StatelessWidget {
  
  final int status;
  
  const StatusRenderer({super.key, required this.status});

  @override
  Widget build(BuildContext context) {

    ThemeData theme = Theme.of(context);
    final Color color = getStatusColor(theme, status);
    final IconData icon = getStatusIcon(status);

    return Container(
      decoration: BoxDecoration(
        color: color.withAlpha(100),
        borderRadius: BorderRadius.circular(50),
      ),
      padding: const EdgeInsets.symmetric(horizontal: defaultSpacing * 0.75, vertical: defaultSpacing * 0.5),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 13,
          ),
          const SizedBox(width: 5),
          Text(
            "status.${status.toString().toLowerCase()}".tr,
            style: theme.textTheme.bodySmall!.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      )
    );
  }
}

// Get the status icon
IconData getStatusIcon(int status) {
  switch(status) {
    case statusOffline:
      return Icons.circle;
    case statusOnline:
      return Icons.circle;
    case statusDoNotDisturb:
      return Icons.do_not_disturb_on;
    case statusAway:
      return Icons.dark_mode;
    default:
      return Icons.circle;
  }
}

// Get the status color
Color getStatusColor(ThemeData theme, int status) {
  switch(status) {
    case statusOffline:
      return theme.colorScheme.surface;
    case statusOnline:
      return theme.colorScheme.secondary;
    case statusDoNotDisturb:
      return theme.colorScheme.error;
    case statusAway:
      return theme.colorScheme.secondaryContainer;
    default:
      return theme.colorScheme.onBackground;
  }
}

const statusOffline = 0;
const statusOnline = 1;
const statusAway = 2;
const statusDoNotDisturb = 3;