import 'package:aurakart/features/shop/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../authentication/authentication_repository.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

  /// Get all order related to current User
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final authUser = AuthenticationRepository.instance.authUser;

      if (authUser == null || authUser.uid.isEmpty) {
        throw 'Unable to find user information. Try again in a few minutes.';
      }

      final userId = authUser.uid;

      final result = await _db
          .collection('Orders')
          .where('userId', isEqualTo: userId)
          .get();

      return result.docs
          .map((documentSnapshot) => OrderModel.fromSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw e.toString();
      // throw 'Something Went wrong while fetching Order Information. Try agin later';
    }
  }

  /// Store new user order
  Future<void> saveOrder(OrderModel order) async {
    try {
      await _db.collection('Orders').add(order.toJson());
    } catch (e) {
      throw 'Something went wrong while saving Order Information.Try again Later';
    }
  }
}
