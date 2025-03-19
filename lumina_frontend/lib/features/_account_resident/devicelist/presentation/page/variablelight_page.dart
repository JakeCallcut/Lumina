import 'package:flutter/material.dart';
import 'package:lumina_frontend/core/themes/main_theme.dart';
import '../../domain/entities/devicelist_entiti.dart';
import 'dart:math' as math;
//
import 'package:lumina_frontend/features/navbar/presentation/page/navbar.dart';
import 'package:lumina_frontend/providers/homeProvider.dart';
import 'package:provider/provider.dart';
import 'package:lumina_frontend/model/models.dart';
import 'package:lumina_frontend/services/integration_Funcs.dart';
import 'package:lumina_frontend/routes.dart';
//import '../../presentation/widget/colourwheel.dart';
//import '../../presentation/widget/brightnessdial.dart';
//import '../../presentation/widget/circlepainter.dart';


class VariableLightPage extends StatefulWidget {
  final Device device;
  
  const VariableLightPage({Key? key, required this.device}) : super(key: key);

  @override
  // path to get here
  State<VariableLightPage> createState() => _VariableLightPageState();
}

//initial instatiantion of light settings
class _VariableLightPageState extends State<VariableLightPage> {
  double _brightness = 50.0;
  Color _selectedColor = MainTheme.luminaYellow;
  bool _isOn = false;

  @override
  void initState() {
    super.initState();
    // Initialize state based on device activity
    _isOn = widget.device.mainAction;
  }

  void _showDeleteDeviceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Device'),
          content: Text('Are you sure you want to delete ${widget.device.deviceName}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Handle delete operation
                Navigator.of(context).pop(); // Close the dialog
                
                // Return to the previous screen with a result indicating deletion
                Navigator.of(context).pop({'action': 'delete', 'deviceId': widget.device.deviceName});
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainTheme.luminaShadedWhite,
      appBar: AppBar(
        backgroundColor: MainTheme.luminaShadedWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.device.deviceName,
          style: TextStyle(color: MainTheme.luminaBlack, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black),
            onPressed: () {
              _showDeleteDeviceDialog(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Colour wheel with selected light
            ColourPickerWheel(
              selectedColor: _selectedColor,
              isOn: _isOn,
              onColorChanged: (color, hue) {
                setState(() {
                  _selectedColor = color;
                });
              },
            ),
            
            // Brightness dial
            BrightnessDial(
              brightness: _brightness,
              isOn: _isOn,
              onBrightnessChanged: (value) {
                setState(() {
                  _brightness = value;
                });
              },
              onPowerToggle: () {
                setState(() {
                  _isOn = !_isOn;
                });
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Navbar(
      selectedPage: NavPage.devices,
      ),
    );
  }
}

class ColourPickerWheel extends StatefulWidget {
  final Color selectedColor;
  final bool isOn;
  final Function(Color, double) onColorChanged;

  const ColourPickerWheel({
    Key? key,
    required this.selectedColor,
    required this.isOn,
    required this.onColorChanged,
  }) : super(key: key);

  @override
  State<ColourPickerWheel> createState() => _ColorPickerWheelState();
}

class _ColorPickerWheelState extends State<ColourPickerWheel> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      width: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Colour wheel
          GestureDetector(
            onPanDown: (details) => _updateColorFromPosition(details.localPosition),
            onPanUpdate: (details) => _updateColorFromPosition(details.localPosition),
            child: CustomPaint(
              size: const Size(140, 140),
              painter: ColorWheelPainter(),
            ),
          ),
          
          // Light bulb in center
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: MainTheme.luminaDarkGrey.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: Icon(
                Icons.lightbulb,
                color: widget.isOn ? widget.selectedColor : Colors.white,
                size: 50,
              ),
            ),
          ),
          
          // Colour marker on the wheel (positioned based on hue)
          Builder(
            builder: (context) {
              final hue = HSVColor.fromColor(widget.selectedColor).hue;
              final angle = hue * math.pi / 180;
              final radius = 62.5; // Circle radius
              
              return Positioned(
                left: 70 + radius * math.cos(angle),
                top:  70 + radius * math.sin(angle),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: widget.selectedColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: MainTheme.luminaLightGrey, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: MainTheme.luminaDarkGrey.withOpacity(0.2),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              );
            }
          ),
        ],
      ),
    );
  }
  
  void _updateColorFromPosition(Offset position) {
    final center = Offset(70, 70);
    final offset = position - center;
    
    // Only update if the touch is outside the central bulb area
    if (offset.distance > 20 && offset.distance < 150) { // Avoid center and outside ring
      // Calculate direct angle from touch position
      final angle = math.atan2(offset.dy, offset.dx);
      
      // Convert to hue (0-360)
      // atan2 returns angle in radians (-π to π), we need to convert to degrees and adjust
      final hue = ((angle * 180 / math.pi) + 360) % 360;
      
      // Create colour from HSV
      final color = HSVColor.fromAHSV(1.0, hue, 1.0, 1.0).toColor();
      
      widget.onColorChanged(color, hue);
    }
  }
}

class BrightnessDial extends StatefulWidget {
  final double brightness;
  final bool isOn;
  final Function(double) onBrightnessChanged;
  final VoidCallback onPowerToggle;

  const BrightnessDial({
    Key? key,
    required this.brightness,
    required this.isOn,
    required this.onBrightnessChanged,
    required this.onPowerToggle,
  }) : super(key: key);

  @override
  State<BrightnessDial> createState() => _BrightnessDialState();
}

class _BrightnessDialState extends State<BrightnessDial> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      width: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Brightness indicator
          CustomPaint(
            size: const Size(280, 280),
            painter: BrightnessDialPainter(
              brightness: widget.brightness,
              isOn: widget.isOn,
            ),
          ),
          
          // Brightness level indicator
          Positioned(
            top: 100,
            child: Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          
          // Draggable area for brightness
          GestureDetector(
            onPanDown: widget.isOn ? (details) => _updateBrightnessFromPosition(details.localPosition) : null,
            onPanUpdate: widget.isOn ? (details) => _updateBrightnessFromPosition(details.localPosition) : null,
            child: Container(
              width: 280,
              height: 280,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
            ),
          ),
          
          // Power button
          GestureDetector(
            onTap: widget.onPowerToggle,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey.shade700,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.power_settings_new,
                      color: Colors.white,
                      size: 28,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.isOn ? "${widget.brightness.toInt()}%" : "0%",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateBrightnessFromPosition(Offset position) {
    if (!widget.isOn) return;
    
    final center = Offset(140, 140);
    final offset = position - center;
    
    // Only handle if not too close to center
    if (offset.distance > 30) {
      // Calculate angle (in radians, 0 is right, going clockwise)
      final angle = math.atan2(offset.dy, offset.dx);
      
      // Convert to degrees (0-360)
      final degrees = ((angle * 180 / math.pi) + 360) % 360;
      
      // The brightness dial is oriented with 0% at top (270°) and goes clockwise
      // We need to map from degrees to 0-100% brightness
      double brightness;
      
      // Limit interaction to the active part of the dial (180° to 360°/0°)
      // This is the right half of the circle, matching the UI in the screenshot
      //Not accepting 0% brightness
      if (degrees >= 180 && degrees <= 182) {
        // 0 -> 1%
        brightness = ((degrees+2) - 180) / 180 * 100;
      }
      //Allowing 100% brightness
      if (degrees >= 359) {
        // 360 -> 100%
        brightness = 100;
      }
      else if (degrees > 182 && degrees < 359) {
        // Map 180° -> 1%, 359°/0° -> 99%
        brightness = (degrees - 180) / 180 * 100;
      } else {
        return; // Outside the interactive range
      }
      
      widget.onBrightnessChanged(brightness.clamp(0, 100));
    }
  }
}

class ColorWheelPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 10;
    
    // Draw colour wheel
    final rect = Rect.fromCenter(
      center: center,
      width: radius * 2,
      height: radius * 2,
    );
    
    const sweepAngle = 2 * math.pi;
    
    for (double angle = 0; angle < sweepAngle; angle += 0.05) {
      final hsv = HSVColor.fromAHSV(
        1.0,
        (angle * 180 / math.pi) % 360,
        1.0,
        1.0,
      );
      
      final paint = Paint()
        ..color = hsv.toColor()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 15;
      
      canvas.drawArc(rect, angle, 0.05, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class BrightnessDialPainter extends CustomPainter {
  final double brightness;
  final bool isOn;

  BrightnessDialPainter({
    required this.brightness,
    required this.isOn,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 40;
    
    // Draw segments around the right half of the circle
    const segmentCount = 20;
    const segmentWidth = 4.0;
    
    // Start at 180° (9 o'clock) and go clockwise to 360°/0° (3 o'clock)
    // This orients the dial with 0% on top and 100% at bottom
    const startAngle = math.pi; // 180°
    const endAngle = 2 * math.pi; // 360°
    final segmentAngle = math.pi / (segmentCount - 1);
    
    for (int i = 0; i < segmentCount; i++) {
      final angle = startAngle + segmentAngle * i;
      
      // Calculate inner and outer points
      final innerRadius = radius * 0.7;
      final outerRadius = radius * 0.9;
      
      final innerPoint = Offset(
        center.dx + innerRadius * math.cos(angle),
        center.dy + innerRadius * math.sin(angle),
      );
      
      final outerPoint = Offset(
        center.dx + outerRadius * math.cos(angle),
        center.dy + outerRadius * math.sin(angle),
      );
      
      // Determine if this segment should be highlighted based on brightness
      // Map brightness 0-100% to segment index
      //ceil() to have 1-9 visable on dial
      //brightness-1 to not display 0% with value
      final activeSegments = (brightness / 100 * segmentCount).ceil();
      final isHighlighted = isOn && i < activeSegments;
      
      // Draw segment
      final paint = Paint()
        ..color = isHighlighted ? MainTheme.luminaDarkGrey : MainTheme.luminaLightGrey
        ..strokeWidth = segmentWidth
        ..strokeCap = StrokeCap.round;
      
      canvas.drawLine(innerPoint, outerPoint, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is BrightnessDialPainter &&
      (oldDelegate.brightness != brightness || oldDelegate.isOn != isOn);
}