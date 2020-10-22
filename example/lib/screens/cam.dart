import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class Cam extends StatefulWidget {
  @override
  _CamState createState() => _CamState();
}

class _CamState extends State<Cam> {

  static const platform = const MethodChannel('samples.flutter.dev/cam');

  ArCoreController arCoreController;

  /*@override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cam Pos'),
        ),
        body: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
        ),
      ),
    );
  }*/


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: Text('Get Battery Level'),
              onPressed: _getBatteryLevel,
            ),
            Text(_batteryLevel),
          ],
        ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;

    controller.camPos();
    print('Response ${arCoreController.response}');

  }


  // Get battery level.
  String _batteryLevel = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('cameWorldPos');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }


  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
