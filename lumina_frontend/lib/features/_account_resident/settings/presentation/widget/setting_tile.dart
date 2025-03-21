import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/core/utils/switch.dart';

class SettingTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Icon icon;
  final bool addSwitch;
  final VoidCallback? onTap; // Added an onTap callback for click functionality

  const SettingTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.addSwitch,
    this.onTap, // Optional tap action
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Triggers the action when tapped
      borderRadius: BorderRadius.circular(10), // Adds a smooth tap effect
      child: Container(
        decoration: BoxDecoration(
          color: MainTheme.luminaBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                icon,
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title, style: MainTheme.h3White),
                    if (subtitle.isNotEmpty) Text(subtitle, style: MainTheme.h4White),
                  ],
                ),
              ],
            ),
            if (addSwitch) LuminaSwitch(onChanged: (bool value) {}),
          ],
        ),
      ),
    );
  }
}
