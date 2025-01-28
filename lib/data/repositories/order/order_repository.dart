import 'package:aurakart/data/repositories/authentication/authentication_repository.dart';
import 'package:aurakart/features/shop/models/brand_model.dart';
import 'package:aurakart/features/shop/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

  /* ------------------------FUNCTIONS---------------------------------*/
  /// Get all order related to current User
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userId = AuthenticationRepository.instance.authUser.uid;
      if (userId.isEmpty) {
        throw 'Unable to find user informaton.Try again in few minutes.';
      }
      final result =
          await _db.collection('Users').doc(userId).collection('Orders').get();
      return result.docs
          .map((documentSnapshot) => OrderModel.fromSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw 'Something Went wrong while fetching order information,try agin later';
    }
  }

  ///Store new user order
  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Orders')
          .add(order.toJson());
    } catch (e) {
      'Something went wrong while saving Order Information.Try again Later';
    }
  }
}
