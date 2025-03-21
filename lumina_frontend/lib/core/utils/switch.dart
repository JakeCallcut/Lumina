import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';

class LuminaSwitch extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool>
      onChanged; //Function to provide code to run when state is changed

  const LuminaSwitch({
    Key? key,
    this.initialValue =
        false, //take in a value, if no value provided, default value is false
    required this.onChanged,
  }) : super(key: key);

  @override
  LuminaSwitchState createState() => LuminaSwitchState();
}

class LuminaSwitchState extends State<LuminaSwitch> {
  late bool isOn;

  @override
  void initState() {
    super.initState();
    isOn = widget.initialValue;
  }

  @override
  void didUpdateWidget (LuminaSwitch oldWidget) { //will run when the switch is rebuilt
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) { //if the rebuilt widget isnt the same as the old one
      setState(() {
        isOn = widget.initialValue; //update the value of the switch (i.e what its flipped to)
      });
    }
  }

  void _toggleSwitch() {
    //toggling state of switch
    setState(() {
      isOn = !isOn;
    });

    //passing the state to parent widget
    widget.onChanged(isOn);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSwitch,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 80.0,
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: isOn ? MainTheme.luminaLightGreen : Colors.grey,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 300),
          alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
          curve: Curves.easeInOut,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
                width: 40.0,
                height: 40.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    isOn ? "ON" : "OFF",
                    style: MainTheme.h3Black,
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
