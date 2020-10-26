import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';

class ToggleObject extends StatefulWidget {
  @override
  _ToggleObject createState() => _ToggleObject();
}

class _ToggleObject extends State<ToggleObject> {
  ArCoreController arCoreController;

  Timer _timer;
  ArCoreRotatingNode node;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Toggle Object'),
        ),
        body: ArCoreView(
                onArCoreViewCreated: _onArCoreViewCreated,
        ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    _addSphere(arCoreController);
    _timer = Timer.periodic(Duration(seconds: 2), (Timer t) => arCoreController.toggleArCoreNode(nodeName: 'toggle'));
  }

  void _addSphere(ArCoreController controller) {
    final material = ArCoreMaterial(
        color: Color.fromARGB(120, 66, 134, 244));
    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.1,
    );
    final node = ArCoreNode(
      name: 'toggle',
      shape: sphere,
      position: Vector3(0, 0, -1.5),
      isEnabled: true
    );
    controller.addArCoreNode(node);
  }




  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }
}

