import 'dart:convert';
import 'dart:io';

import 'package:aurakart/features/shop/models/category_model.dart';
import 'package:aurakart/utils/constants/api_constants.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ADummyDataHelperFunctions extends GetxController {
  static ADummyDataHelperFunctions get instance => Get.find();

  /// Upload Local Assets from IDE
  /// Return a Uint8List containing image data
  Future<Uint8List> getImageDataFromAssets(String path) async {
    try {
      final byteData = await rootBundle.load(path);
      final imageData = byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      return imageData;
    } catch (e) {
      // Handle excepetion gracefully
      throw 'Error loading image data: $e';
    }
  }

  /// Upload Image using ImageData on Cloudinary
  /// Returns the download URL of uploaded Image
  Future<String> uploadImageData(
      String path, Uint8List image, String name) async {
    try {
      // Cloudinary API uri
      final uri = Uri.parse(
          'https://api.cloudinary.com/v1_1/${APIConstants.cloudinaryCloudName}/image/upload');

      // Multipart Request
      var request = http.MultipartRequest('POST', uri);
      request.fields['upload_preset'] = APIConstants.cloudinaryUploadPreset;
      request.fields['resource_type'] = 'image';
      request.fields['folder'] = path;
      request.files
          .add(http.MultipartFile.fromBytes('file', image, filename: name));

      // Send Request
      var response = await request.send();

      if (response.statusCode == 200) {
        // Get Response
        final responseString = await response.stream.bytesToString();
        // Decode the response
        final data = jsonDecode(responseString);
        // Get the image URL
        final String imageUrl = data['secure_url'];
        return imageUrl;
      } else {
        throw 'Failed to upload image';
      }
    } catch (e) {
      if (e is SocketException) {
        throw 'Network Error: ${e.message}';
      } else if (e is PlatformException) {
        throw 'Platform Exception: ${e.message}';
      } else {
        throw 'Something went wrong! Please try again.';
      }
    }
  }

  /// Upload Image using ImageData on Cloudinary
  /// Returns the download URL of uploaded Image
  Future<String> uploadImageFile(String path, XFile image) async {
    try {
      // Cloudinary API uri
      final uri = Uri.parse(
          'https://api.cloudinary.com/v1_1/${APIConstants.cloudinaryCloudName}/image/upload');

      // Multipart Request
      var request = http.MultipartRequest('POST', uri);
      request.fields['upload_preset'] = APIConstants.cloudinaryUploadPreset;
      request.fields['resource_type'] = 'image';
      request.fields['folder'] = path;
      request.files.add(await http.MultipartFile.fromPath('file', image.path));

      // Send Request
      var response = await request.send();

      if (response.statusCode == 200) {
        // Get Response
        final responseString = await response.stream.bytesToString();
        // Decode the response
        final data = jsonDecode(responseString);
        // Get the image URL
        final String imageUrl = data['secure_url'];
        return imageUrl;
      } else {
        throw 'Failed to upload image';
      }
    } catch (e) {
      if (e is SocketException) {
        throw 'Network Error: ${e.message}';
      } else if (e is PlatformException) {
        throw 'Platform Exception: ${e.message}';
      } else {
        throw 'Something went wrong! Please try again.';
      }
    }
  }
}
