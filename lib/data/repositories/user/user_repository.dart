import 'dart:convert';

import 'package:aurakart/data/repositories/authentication/authentication_repository.dart';
import 'package:aurakart/features/personalization/models/user_model.dart';
import 'package:aurakart/utils/constants/api_constants.dart';
import 'package:aurakart/utils/exceptions/firebase_exceptions.dart';
import 'package:aurakart/utils/exceptions/format_exceptions.dart';
import 'package:aurakart/utils/exceptions/platform_exceptions.dart';
import 'package:aurakart/utils/helpers/cloud_helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/exceptions/cloudinary_exceptions.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Function to save user data to Firestore.
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AFormatException();
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong!. Please try again';
    }
  }

  /// Function to fetch user details based on user Id
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser!.uid)
          .get();

      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong!. Please try again';
    }
  }

  /// Functions to update user data in Firestore
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db
          .collection("Users")
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AFormatException();
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong!. Please try again';
    }
  }

  /// Update any field in specific users Collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser!.uid)
          .update(json);
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AFormatException();
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong!. Please try again';
    }
  }

  /// Function to remove user from firestore
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection("Users").doc(userId).delete();
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AFormatException();
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong!. Please try again';
    }
  }

  /// Upload any Image using Cloudinary
  Future<String> uploadImageToCloudinary(String folderPath, XFile image) async {
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
  Future<void> deleteImageFromCloudinary(String imageUrl) async {
    try {
      final cloudinaryCloudName = APIConstants.cloudinaryCloudName;

      final deleteUrl =
          APIConstants.getCloudinaryDeleteUrl(cloudinaryCloudName, 'image');

      final uri = Uri.parse(deleteUrl);

      final publicId = ACloudHelperFunctions.getPublicId(imageUrl);

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
}
