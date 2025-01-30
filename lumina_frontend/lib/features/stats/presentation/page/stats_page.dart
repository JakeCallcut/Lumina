import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/features/stats/presentation/widget/graph_box.dart';
import 'package:lumina_frontend/features/stats/presentation/widget/info_box.dart';
import 'package:lumina_frontend/features/navbar/presentation/page/navbar.dart';

class StatsPage extends StatelessWidget {

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
                Text("Usage and stats", style: MainTheme.h1Black,),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("Title", style: MainTheme.h1Black,),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               Column(
                 children: [
                  InfoBox(
                    title: "You've used",
                    valueMoney: 2.67,
                    valueUnit: 4.7,
                    boxColor: MainTheme.luminaBlue,
                    textStyle: [MainTheme.h1White, MainTheme.h2White],
                  ),
                ]
              ),
               Column(
                 children: [
                  InfoBox(
                    title: "You've saved",
                    valueMoney: 0.89,
                    valueUnit: 2.14,
                    boxColor: MainTheme.luminaLightGreen,
                    textStyle: [MainTheme.h1Black, MainTheme.h2Black],
                  ),
                 ],
               ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                 padding: const EdgeInsets.all(16.0),
                  child: Text("Energy Usage (kWh)", style: MainTheme.h2Black,),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 300,
                  width: 500,
                  decoration: BoxDecoration(
                    color: MainTheme.luminaBlue,
                    borderRadius: BorderRadius.circular(10), // Rounded edges
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                        ),
                      ],
                    ),
                  child: const GraphBox(
                  
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("Energy Generation (kWh)", style: MainTheme.h2Black,),
                ),
              ],
            ),
            const Row(
        
            ),
          ],
        ),
        Navbar(),
      ],
    );
  }
}