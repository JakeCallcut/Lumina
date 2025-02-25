import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import 'package:lumina_frontend/features/devicelist/presentation/widget/adddevice.dart';
import 'package:lumina_frontend/features/devicelist/presentation/widget/devicedroplist.dart';
import 'package:lumina_frontend/features/devicelist/presentation/widget/devicelist.dart';
import 'package:lumina_frontend/features/navbar/presentation/page/navbar.dart';

class deviceList extends StatelessWidget {
  const deviceList({Key? key}) : super(key: key);

    @override
    Widget build (BuildContext context){
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
              children: [ child: asset("assets/images/logo64.png"),]
              ),
              SizedBox(width: 8),
              Text("Manage Your Devices",
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              ),
              ],
              ),
              
              const SizedBox(height: 16),

              const Devicedroplist(),

              const SizedBox(height: 16),

              Expanded(child: Devicelist(),
              ),

              const SizedBox(height: 16),

              AddDevice(),
            ],
          ),
        ),
      );
    }
}

