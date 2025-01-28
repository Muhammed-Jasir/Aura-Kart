import 'dart:convert';
import 'dart:io';

import 'package:aurakart/features/shop/models/category_model.dart';
import 'package:aurakart/utils/constants/api_constants.dart';
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

  // /// Upload Proucts to the Cloud Firestore
  // Future<void> uploadDummyData(List<ProductModel> products) async {
  //   try {
  //     // Upload all the categories along with thier images
  //     final storage = Get.put(ADummyDataHelperFunctions());

  //     // Loop through each category
  //     for (var product in products) {
  //       // Get ImageData link from the local assets
  //       final thumbnail =
  //           await storage.getImageDataFromAssets(product.thumbnail);

  //       // Upload Image and get its URL
  //       final url = await storage.uploadImageData(
  //           'Products/Images', thumbnail, product.thumbnail);

  //       // Assign URL to product.thumbnail attribute
  //       product.thumbnail = url;

  //       // Product list of images
  //       if (product.images != null && product.images!.isNotEmpty) {
  //         List<String> imagesUrl = [];
  //         for (var image in product.images!) {
  //           // Get image data link from local assets
  //           final assetImage = await storage.getImageDataFromAssets(image);

  //           // Upload image and get its URL
  //           final url = await storage.uploadImageData(
  //               'Products/Images', assetImage, image);

  //           // Assign URL to product.thumbnail attribute
  //           imagesUrl.add(url);
  //         }
  //         product.images!.clear();
  //         product.images!.addAll(imagesUrl);
  //       }

  //       // Upload Variation Images
  //       if (product.productType == ProductType.variable.toString()) {
  //         for (var variation in product.productVariations!) {
  //           // Get image data link from local assets
  //           final assetImage =
  //               await storage.getImageDataFromAssets(variation.image);

  //           // Upload image and get its URL
  //           final url = await storage.uploadImageData(
  //               'Products/Images', assetImage, variation.image);

  //           // Assign URL to variation.thumbnail attribute
  //           variation.image = url;
  //         }
  //       }

  //       // Store product in Firestore
  //       await _db.collection('Products').doc(product.id).set(product.toJson());
  //     }
  //   } on FirebaseException catch (e) {
  //     throw AFirebaseAuthException(e.code).message;
  //   } on PlatformException catch (e) {
  //     throw APlatformException(e.code).message;
  //   } catch (e) {
  //     throw 'Something went wrong, Plaease try again';
  //   }
  // }

  // /// Upload Categories to the Cloud Firebase
  // Future<void> uploadDummyData(List<CategoryModel> categories) async {
  //   try {
  //     // Upload all the categories along with thier images
  //     final storage = Get.put(ADummyDataHelperFunctions());

  //     // Loop through each category
  //     for (var category in categories) {
  //       // Get ImageData link from the local assets
  //       final file = await storage.getImageDataFromAssets(category.image);

  //       // Upload Image and get its URL
  //       final url =
  //           await storage.uploadImageData('Categories', file, category.name);

  //       // Assign URL to Category.Image attribute
  //       category.image = url;

  //       // Store Category in Firestore
  //       await _db
  //           .collection('Categories')
  //           .doc(category.id)
  //           .set(category.toJson());
  //     }
  //   } on FirebaseException catch (e) {
  //     throw AFirebaseAuthException(e.code).message;
  //   } on PlatformException catch (e) {
  //     throw APlatformException(e.code).message;
  //   } catch (e) {
  //     throw 'Something went wrong, Plaease try again';
  //   }
  // }
  
}
