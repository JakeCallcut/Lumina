import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/features/navbar/presentation/page/navbar.dart';

class StatsPage extends StatelessWidget {

  final String _title = "Usage and Stats";
  final String _Today = "Today";
  final String _used = "You've used";
  final String _saved = "You've saved";

  const StatsPage({super.key}); 

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset("/images/logo64.png"),
                ),
                Text(_title, style: MainTheme.h1,),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(_Today, style: MainTheme.h2,),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               Column(
                 children: [
                   Container(
                    height: 200,
                    width: 250,
                    decoration: BoxDecoration(
                    color: MainTheme.luminaLightGreen,
                    borderRadius: BorderRadius.circular(10), // Rounded edges
                    ),
                   )
                 ],
               ),
               Column(
                 children: [
                   Container(
                    height: 200,
                    width: 250,
                    decoration: BoxDecoration(
                    color: MainTheme.luminaLightGreen,
                    borderRadius: BorderRadius.circular(10), // Rounded edges
                    ),
                  )
                 ],
               ),
              ],
            ),
            Row(
        
            ),
            Row(
        
            ),
            Row(
        
            ),
            Row(
        
            ),
          ],
        ),
        Navbar(),
      ],
    );
  }
}