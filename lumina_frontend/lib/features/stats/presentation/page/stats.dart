import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/features/navbar/presentation/page/navbar.dart';

class StatsPage extends StatelessWidget {

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
                Text("Usage and stats", style: MainTheme.h1,),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Title", style: MainTheme.h2,),
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Energy Usage (kWh)", style: MainTheme.h2,),
              ],
            ),
            Row(
        
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Energy Generation (kWh)", style: MainTheme.h2,),
              ],
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