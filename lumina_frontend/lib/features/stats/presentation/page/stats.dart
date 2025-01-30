import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/features/navbar/presentation/page/navbar.dart';

class StatsPage extends StatelessWidget {

  final String _used_money = "£2.67";
  final String _used_power = "4.7 kWh";
  final String _saved_money = "£0.89";
  final String _saved_power = "2.14 kWh";

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
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text("Title", style: MainTheme.h1Black,),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               Column(
                 children: [
                   Container(
                    height: 175,
                    width: 250,
                    decoration: BoxDecoration(
                    color: MainTheme.luminaBlue,
                    borderRadius: BorderRadius.circular(10), // Rounded edges
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(), // Shadow color
                        spreadRadius: 2, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset: const Offset(0, 3), // Offset in x and y direction
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("You've used", style: MainTheme.h2White),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_used_money, style: MainTheme.h1White),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("($_used_power)", style: MainTheme.h2White),
                          ],
                        ),
                      ],
                    ),
                   )
                 ],
               ),
               Column(
                 children: [
                   Container(
                    height: 175,
                    width: 250,
                    decoration: BoxDecoration(
                      color: MainTheme.luminaLightGreen,
                      borderRadius: BorderRadius.circular(10), // Rounded edges
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(), // Shadow color
                          spreadRadius: 2, // Spread radius
                          blurRadius: 5, // Blur radius
                          offset: const Offset(0, 3), // Offset in x and y direction
                        ),
                      ], // Rounded edges
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("You've saved", style: MainTheme.h2Black),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_saved_money, style: MainTheme.h2Black),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("($_saved_power)", style: MainTheme.h2Black),
                          ],
                        ),
                      ],
                    ),
                  )
                 ],
               ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text("Energy Usage (kWh)", style: MainTheme.h2Black,),
                ),
              ],
            ),
            Row(
        
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text("Energy Generation (kWh)", style: MainTheme.h2Black,),
                ),
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