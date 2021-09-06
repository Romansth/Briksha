import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

Future<dynamic> sendToPredictor(imagePath) async {
  final imageBytes = File(imagePath).readAsBytesSync();
  String imageBase64 = base64Encode(imageBytes);

  var dio = Dio();

  final response = await dio.post("http://18.215.165.176:8081/predict", data: {
    'image': imageBase64,
  });

  return response.data;
}

sendAlerts({plant, disease}) async {
  var dio = Dio();

  final response = await dio.post("http://18.215.165.176:8081/predict",
      data: {'plant': plant, 'disease': disease});

  return response.data;
}
