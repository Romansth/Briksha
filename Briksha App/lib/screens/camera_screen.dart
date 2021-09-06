import 'package:get/get.dart';
import 'package:briksha/screens/image_screen.dart';

import '../buttons/capture.dart';
import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

enum Camera { backCamera, frontCamera }

class CameraScreen extends StatefulWidget {
  static const String route = '/CameraScreen';

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late List<CameraDescription> cameras;
  Camera chosenCamera = Camera.backCamera;
  var _controller;

  Future<void> _initCameraController(
      CameraDescription cameraDescription) async {
    print("started");
    _controller = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    _controller.addListener(() {
      if (mounted) {
        setState(() {});
      }

      if (_controller.value.hasError) {
        print('Camera error ${_controller.value.errorDescription}');
      }
    });

    try {
      await _controller.initialize();
    } on CameraException catch (e) {
      print(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _initializeCamera() async {
    try {
      cameras = await availableCameras();
      CameraDescription firstCamera = cameras.first;
      await _initCameraController(firstCamera);
    } catch (e) {
      print('******** CAMERA ERROR $e*********');
    }
  }

  Future<void> _chooseImageFromGallery() async {
    PickedFile? image =
        await ImagePicker().getImage(source: ImageSource.gallery);

    if (image != null) {
      final String imagePath = image.path;
      print("Hurraayyy " + imagePath);
      Get.to(() => ImageScreen(imagePath: imagePath));
    }
  }

  Future<void> _takePhoto() async {
    try {
      final String imagePath =
          '${(await getTemporaryDirectory()).path}/${DateTime.now()}.png';
      setState(() {});

      var picture = await _controller.takePicture(); 
      picture.saveTo(imagePath);

      print("hurraahhh  : " + imagePath);
      Get.to(() => ImageScreen(imagePath: imagePath));
    } catch (e) {
      print('************ ERROR : $e *******************');
    }
  }

  Future<void> _switchCamera() async {
    switch (chosenCamera) {
      case Camera.backCamera:
        chosenCamera = Camera.frontCamera;
        setState(() {});
        break;
      case Camera.frontCamera:
        chosenCamera = Camera.backCamera;
        setState(() {});
        break;
    }
    await _initCameraController(cameras[chosenCamera.index]);
  }

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed ||
        state == AppLifecycleState.inactive) {
      _controller?.initialize();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller.value.isInitialized) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
final size = MediaQuery.of(context).size;
final deviceRatio = size.width / size.height;
    final containerSize = size.width * 0.16;
    final containerMarginTop = MediaQuery.of(context).padding.top +
        size.height * 0.01; // size.height * 0.07;
    final containerMarginLeft = size.width * 0.03;
    final iconSize = size.width * 0.1;

    
    return  Scaffold(
        body: Stack(
            children: <Widget>[
              Center(
                child:Transform.scale(
                      scale: _controller.value.aspectRatio/deviceRatio,
                      child: new AspectRatio(
                       aspectRatio: _controller.value.aspectRatio,
                       child: new CameraPreview(_controller),
                       ),
                   ),),
             Align(
          alignment: Alignment.bottomLeft,
          child: Padding(padding: const EdgeInsets.only(
                           bottom: 10),
                child:Container(
              width: containerSize,
              height: containerSize,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black54,
                        blurRadius: 6,
                        offset: Offset(2, 2),
                        spreadRadius: 1),
                  ],
                  border: Border.all(
                                        width: 0,
                  ),
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey[100]),
              margin: EdgeInsets.only(
                  top: containerMarginTop, left: containerMarginLeft),
              child: IconButton(
               
            onPressed: _chooseImageFromGallery,
                icon: Icon(
                  Icons.image,
                  size: iconSize,
                  color: Colors.black87,
                ),
              )))),
      Align(
          alignment: Alignment.bottomRight,
          child: Padding(padding: const EdgeInsets.only(
                           bottom: 10),
          child:Container(
              width: containerSize,
              height: containerSize,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black54,
                        blurRadius: 6,
                        offset: Offset(2, 2),
                        spreadRadius: 1),
                  ],
                  border: Border.all(
                   
                    width: 0,
                  ),
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey[100]),
              margin: EdgeInsets.only(
                  top: containerMarginTop, right: containerMarginLeft),
              child: IconButton(
               
               onPressed: _switchCamera,
                icon: Icon(
                  Icons.sync_rounded,
                  size: iconSize,
                  color: Colors.black87,
                ),
              )))),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    
                    Padding(
                      padding: const EdgeInsets.only(
                           bottom: 10),
                      child: Capture(
                        onTap: _takePhoto,
                      ),
                    ),
                    
                  ],
                ),
          )
            ],
          ),
        
      
    );
  }
}
