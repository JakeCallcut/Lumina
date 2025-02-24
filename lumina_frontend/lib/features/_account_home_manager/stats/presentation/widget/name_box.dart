import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/features/_account_home_manager/account_home_manager.dart';
import 'package:lumina_frontend/features/_account_home_manager/stats/presentation/page/stats_page.dart';

class NameBox extends StatelessWidget {
  final String name;
  final VoidCallback onToggleDropDown;

  const NameBox({super.key, required this.name, required this.onToggleDropDown});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10), // Rounded edges
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          onToggleDropDown();
          Navigator.of(context).pushReplacement(
           PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => ManagerStatsPage(name: name),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Rounded edges
          ),
          elevation: 2, // Elevation
          shadowColor: Colors.transparent,
        ),
        child: Text(
          name,
          style: MainTheme.h1Black,
        ),
      ),
    );
  }
}
