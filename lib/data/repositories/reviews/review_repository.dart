import 'package:aurakart/data/repositories/authentication/authentication_repository.dart';
import 'package:aurakart/data/repositories/order/order_repository.dart';
import 'package:aurakart/features/shop/models/review_model.dart';
import 'package:aurakart/utils/constants/enums.dart';
import 'package:aurakart/utils/exceptions/firebase_exceptions.dart';
import 'package:aurakart/utils/exceptions/platform_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ReviewRepository extends GetxController {
  static ReviewRepository get instance {
    if (!Get.isRegistered<ReviewRepository>()) {
      Get.put(ReviewRepository());
    }
    return Get.find<ReviewRepository>();
  }

  final _db = FirebaseFirestore.instance;

  Future<List<ReviewModel>> fetchProductReviews(String productId) async {
    try {
      final snapshot = await _db
          .collection('Reviews')
          .where('ProductId', isEqualTo: productId)
          .get();

      final reviews = snapshot.docs
          .map((document) => ReviewModel.fromSnapshot(document))
          .toList();

      reviews.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return reviews;
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching reviews. Please try again.';
    }
  }

  Future<ReviewModel?> fetchUserReview({
    required String productId,
    required String userId,
  }) async {
    try {
      final document =
          await _db.collection('Reviews').doc('${userId}_$productId').get();
      if (!document.exists) return null;
      return ReviewModel.fromSnapshot(document);
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching your review. Please try again.';
    }
  }

  Future<bool> hasDeliveredProduct(String productId) async {
    final authUser = AuthenticationRepository.instance.authUser;
    if (authUser == null) return false;

    final orders = await OrderRepository.instance.fetchUserOrders();
    return orders.any(
      (order) =>
          order.status == OrderStatus.delivered &&
          order.items.any((item) => item.productId == productId),
    );
  }

  Future<void> submitReview(ReviewModel review) async {
    try {
      await _db
          .collection('Reviews')
          .doc('${review.userId}_${review.productId}')
          .set(review.toJson());
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while saving your review. Please try again.';
    }
  }
}
