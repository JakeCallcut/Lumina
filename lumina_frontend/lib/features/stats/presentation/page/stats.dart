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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("You've used", style: MainTheme.h2),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_used_money, style: MainTheme.h2),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("("+_used_power+")", style: MainTheme.h2),
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
                    height: 200,
                    width: 250,
                    decoration: BoxDecoration(
                      color: MainTheme.luminaLightGreen,
                      borderRadius: BorderRadius.circular(10), // Rounded edges
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("You've saved", style: MainTheme.h2),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_saved_money, style: MainTheme.h2),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("("+_saved_power+")", style: MainTheme.h2),
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