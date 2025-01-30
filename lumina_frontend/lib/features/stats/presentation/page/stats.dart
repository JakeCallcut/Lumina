import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/features/stats/presentation/widget/info_box.dart';
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               Column(
                 children: [
                  InfoBox(title: "You've used", valueMoney: 2.67, valueUnit: 4.7,),
                 ],
               ),
               Column(
                 children: [
                  InfoBox(title: "You've saved", valueMoney: 0.89, valueUnit: 2.14,),
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