import 'dart:convert';
import 'package:aurakart/utils/constants/api_constants.dart';
import 'package:aurakart/utils/exceptions/cloudinary_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

/// Helper functions for cloud-related operations.
class ACloudHelperFunctions {
  /// Helper function to check the state of a single database record.
  ///
  /// Returns a Widget based on the state of the snapshot.
  /// If data is still loading, it returns a CircularProgressIndicator.
  /// If no data is found, it returns a generic "No Data Found" message.
  /// If an error occurs, it returns a generic error message.
  /// Otherwise, it returns null.
  static Widget? checkSingleRecordState<T>(AsyncSnapshot<T> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || snapshot.data == null) {
      return const Center(child: Text('No Data Found!'));
    }

    if (snapshot.hasError) {
      return const Center(child: Text('Something went wrong.'));
    }

    return null;
  }

  /// Helper function to check the state of multiple (list) database records.
  ///
  /// Returns a Widget based on the state of the snapshot.
  /// If data is still loading, it returns a CircularProgressIndicator.
  /// If no data is found, it returns a generic "No Data Found" message or a custom nothingFoundWidget if provided.
  /// If an error occurs, it returns a generic error message.
  /// Otherwise, it returns null.
  static Widget? checkMultiRecordState<T>({
    required AsyncSnapshot<List<T>> snapshot,
    Widget? loader,
    Widget? error,
    Widget? nothingFound,
  }) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      if (loader != null) return loader;
      return const Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
      if (nothingFound != null) return nothingFound;
      return const Center(child: Text('No Data Found!'));
    }

    if (snapshot.hasError) {
      if (error != null) return error;
      return const Center(child: Text('Something went wrong.'));
    }

    return null;
  }

  /// Upload any Image using Cloudinary
  static Future<String> uploadImageToCloudinary(String folderPath, XFile image) async {
    try {
      final cloudName = APIConstants.cloudinaryCloudName;

      // Cloudinary API URL
      final uri =
          Uri.parse(APIConstants.getCloudinaryUploadUrl(cloudName, 'image'));

      // Multipart Request
      var request = http.MultipartRequest('POST', uri);

      request.fields['upload_preset'] = APIConstants.cloudinaryUploadPreset;

      request.fields['resource_type'] = 'image';

      request.fields['folder'] = folderPath;

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
        final error = await response.stream.bytesToString();
        debugPrint('Failed to upload image: $error');
        throw Exception('Failed to upload image');
      }
    } on ACloudinaryException catch (e) {
      throw ACloudinaryException(e.code).message;
    } catch (e) {
      throw 'Something went wrong!. Please try again';
    }
  }

  // Delete Image from Cloudinary
  static Future<void> deleteImageFromCloudinary(String imageUrl) async {
    try {
      final cloudinaryCloudName = APIConstants.cloudinaryCloudName;

      final deleteUrl =
          APIConstants.getCloudinaryDeleteUrl(cloudinaryCloudName, 'image');

      final uri = Uri.parse(deleteUrl);

      final publicId = getPublicId(imageUrl);

      final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      final signatureString =
          'public_id=$publicId&timestamp=$timestamp${APIConstants.cloudinaryApiSecret}';

      final bytes = utf8.encode(signatureString);
      final signature = sha1.convert(bytes).toString();

      final response = await http.post(
        uri,
        body: {
          'public_id': publicId,
          'timestamp': timestamp.toString(),
          'api_key': APIConstants.cloudinaryApiKey,
          'signature': signature,
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (kDebugMode) {
          print('Image deleted successfully from Cloudinary: $jsonResponse');
        }
      } else {
        throw Exception(
            'Failed to delete image from Cloudinary: ${response.body}');
      }
    } on ACloudinaryException catch (e) {
      throw ACloudinaryException(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

  static String getPublicId(String imageUrl) {
    final uri = Uri.parse(imageUrl);
    final segments = uri.pathSegments;

    // Find the index of 'upload' and get the public_id from the next segments
    final uploadIndex = segments.indexOf('upload');
    if (uploadIndex == -1 || uploadIndex + 1 >= segments.length) {
      throw Exception('Invalid Cloudinary URL format');
    }

    int startIndex = uploadIndex + 1;
    // If the next segment is a version (starts with "v" followed by digits), skip it.
    if (segments[startIndex].startsWith('v') &&
        int.tryParse(segments[startIndex].substring(1)) != null) {
      startIndex++;
    }

    // Join the remaining segments and remove the file extension
    final publicIdWithExtension = segments.sublist(startIndex).join('/');
    return publicIdWithExtension.split('.').first;
  }

  /// Retrieve the download URL from a given Cloudinary URL (use this when you already have the image's Cloudinary URL)
  static Future<String> getURLFromCloudinaryURI(String url) async {
    try {
      if (url.isEmpty) return '';
      return url;
    } catch (e) {
      throw 'Something went wrong.';
    }
  }
}
