import 'dart:convert';
import 'package:aurakart/utils/constants/api_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

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
  static Widget? checkMultiRecordState<T>(
      {required AsyncSnapshot<List<T>> snapshot,
      Widget? loader,
      Widget? error,
      Widget? nothingFound}) {
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

  /// Create a reference with an initial file path and name and retrieve the download URL.

  // static Future<String> getURLFromFilePathAndName(String path) async {
  //   try {
  //     if (path.isEmpty) return '';
  //     final ref = FirebaseStorage.instance.ref().child(path);
  //     final url = await ref.getDownloadURL();
  //     return url;
  //   } on FirebaseException catch (e) {
  //     throw e.message!;
  //   } on PlatformException catch (e) {
  //     throw e.message!;
  //   } catch (e) {
  //     throw 'Something went wrong.';
  //   }
  // }

  /// Upload an image to Cloudinary and get the download URL
  static Future<String> uploadImageToCloudinary(
      String path, String? folder) async {
    try {
      if (path.isEmpty) return '';
      final uri = Uri.parse(APIConstants.cloudinaryBaseUrl);

      var request = http.MultipartRequest('POST', uri);
      request.fields['upload_preset'] = APIConstants.cloudinaryUploadPreset;
      request.fields['resource_type'] = 'image';

      if (folder != null && folder.isNotEmpty) {
        request.fields['folder'] = folder;
      }

      request.files.add(await http.MultipartFile.fromPath('file', path));

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
      throw 'Something went wrong.';
    }
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
