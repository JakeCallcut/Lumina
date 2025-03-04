import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';

//Widget for adding device
class AddDevice extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      decoration:BoxDecoration(
        color: MainTheme.luminaLightGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: const Text("Add device"),
        onTap: (){

        },
      ),
    );
  }
}