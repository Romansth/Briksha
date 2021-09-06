import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:briksha/output/output_page.dart';
import 'package:briksha/requests/request.dart';
import 'package:briksha/buttons/send.dart';

class ImageScreen extends StatefulWidget {
  final String imagePath;

  const ImageScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(
                  flex: 2,
                ),
                Container(
                  height:MediaQuery.of(context).size.height*0.45,
                  width:MediaQuery.of(context).size.width*0.65,
                  
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(15)
                  ),
                  child:  Image.file(File(widget.imagePath),
                     fit: BoxFit.cover),
                     ),
               
                Spacer(
                  flex: 1,
                ),
                SendButton(
                  title: "Detect Disease",
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    var result = await sendToPredictor(widget.imagePath);
                    final String plant = result['plant'];
                    final String disease = result['disease'];
                    final String remedy = result['remedy'];
                    print(result);
                    setState(() {
                      isLoading = false;
                    });
                    Get.to(() => OutputPage(
                          disease: disease,
                          plant: plant,
                          remedy: remedy,
                        ));
                  },
                ),
                isLoading
                    ? Expanded(
                        flex: 2,
                        child: Center(child: CircularProgressIndicator()))
                    : Spacer(flex: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
