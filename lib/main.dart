import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;

Future<Null> main() async {
  cameras = await availableCameras();
  runApp(new CameraApp());
}

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => new _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  CameraController cameraController;

  double scale = 1.0;

  @override
  void initState() {
    super.initState();


    cameraController = new CameraController(cameras[1], ResolutionPreset.high);

    cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }


  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!cameraController.value.isInitialized) {
      return new Container();
    }

    var cameraPreview = new CameraPreview(cameraController);

    return new GestureDetector(
      onScaleUpdate:(one){
        print(one.scale);

        scale = one.scale;
        setState(() {});
      },

      child: new Transform.scale(
        scale: scale,
        child: new AspectRatio(
            aspectRatio: cameraController.value.aspectRatio,
            child: cameraPreview
        )
      )


    );
  }
}
