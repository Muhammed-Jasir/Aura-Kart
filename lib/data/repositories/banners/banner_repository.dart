// ignore_for_file: unused_field

import 'package:aurakart/features/shop/models/banner_model.dart';
import 'package:aurakart/utils/exceptions/firebase_exceptions.dart';
import 'package:aurakart/utils/exceptions/format_exceptions.dart';
import 'package:aurakart/utils/exceptions/platform_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

  /// Get Active Banners from Firebase
  Future<List<BannerModel>> fetchBanners() async {
    try {
      final snapshot = await _db
          .collection('Banners')
          .where('Active', isEqualTo: true)
          .get();
      final result =
          snapshot.docs.map((doc) => BannerModel.fromSnapshot(doc)).toList();
      return result;
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
}
