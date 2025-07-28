// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> with WidgetsBindingObserver {
  List<CameraDescription> cameras = [];
  CameraController? cameraController;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (cameraController == null ||
        cameraController?.value.isInitialized == false) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      cameraController?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      setupCameraController();
    }
  }

  @override
  void initState() {
    super.initState();
    setupCameraController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildUi());
  }

  Widget _buildUi() {
    if (cameraController == null ||
        cameraController?.value.isInitialized == false) {
      return Center(child: CircularProgressIndicator());
    }
    return SafeArea(
      child: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.8,
              child: CameraPreview(cameraController!),
            ),

            IconButton(
              onPressed: () async {
                XFile picture = await cameraController!.takePicture();
                Gal.putImage(picture.path);
              },
              icon: Icon(Icons.camera),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> setupCameraController() async {
    List<CameraDescription> _cameras = await availableCameras();
    if (_cameras.isNotEmpty) {
      setState(() {
        cameras = _cameras;
        cameraController = CameraController(
          cameras.first,
          ResolutionPreset.high,
        );
      });
      cameraController
          ?.initialize()
          .then((_) {
            if (!mounted) return;
            setState(() {});
          })
          .catchError((Object e) {
            // ignore: avoid_print
            print(e);
          });
    }
  }
}
