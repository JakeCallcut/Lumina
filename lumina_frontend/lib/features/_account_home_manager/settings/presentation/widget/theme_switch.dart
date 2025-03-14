import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';

class ThemeSwitch extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool>
      onChanged; //Function to provide code to run when state is changed

  const ThemeSwitch({
    Key? key,
    this.initialValue =
        false, //take in a value, if no value provided, default value is false
    required this.onChanged,
  }) : super(key: key);

  @override
  ThemeSwitchState createState() => ThemeSwitchState();
}

class ThemeSwitchState extends State<ThemeSwitch> {
  late bool isOn;

  @override
  void initState() {
    super.initState();
    isOn = widget.initialValue;
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
        height: 40.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: isOn ? MainTheme.luminaPurple : MainTheme.luminaYellow,
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
              curve: Curves.easeInOut,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              alignment: isOn ? Alignment.centerLeft : Alignment.centerRight,
              curve: Curves.easeInOut,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  isOn ? Icons.dark_mode : Icons.light_mode,
                  size: 24.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
