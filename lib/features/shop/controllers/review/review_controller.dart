import 'package:aurakart/data/repositories/authentication/authentication_repository.dart';
import 'package:aurakart/data/repositories/reviews/review_repository.dart';
import 'package:aurakart/features/personalization/controllers/user_controller.dart';
import 'package:aurakart/features/shop/models/product_model.dart';
import 'package:aurakart/features/shop/models/review_model.dart';
import 'package:aurakart/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewController extends GetxController {
  ReviewController({required this.product});

  final ProductModel product;

  static ReviewController getOrPut(ProductModel product) {
    if (Get.isRegistered<ReviewController>(tag: product.id)) {
      return Get.find<ReviewController>(tag: product.id);
    }
    return Get.put(ReviewController(product: product), tag: product.id);
  }

  final isLoading = true.obs;
  final isSubmitting = false.obs;
  final canReview = false.obs;
  final reviews = <ReviewModel>[].obs;
  final stats = const ReviewStats().obs;
  final userReview = Rxn<ReviewModel>();

  final rating = 0.0.obs;
  final reviewController = TextEditingController();

  ReviewRepository get _repository => ReviewRepository.instance;

  @override
  void onInit() {
    super.onInit();
    loadReviews();
  }

  @override
  void onClose() {
    reviewController.dispose();
    super.onClose();
  }

  Future<void> loadReviews() async {
    try {
      isLoading.value = true;

      final productReviews = await _repository.fetchProductReviews(product.id);
      reviews.assignAll(productReviews);
      stats.value = ReviewStats.fromReviews(productReviews);

      final authUser = AuthenticationRepository.instance.authUser;
      if (authUser != null) {
        canReview.value = await _repository.hasDeliveredProduct(product.id);
        final existingReview = await _repository.fetchUserReview(
          productId: product.id,
          userId: authUser.uid,
        );
        userReview.value = existingReview;

        if (existingReview != null) {
          rating.value = existingReview.rating;
          reviewController.text = existingReview.comment;
        }
      }
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitReview() async {
    final authUser = AuthenticationRepository.instance.authUser;
    if (authUser == null) {
      ALoaders.warningSnackBar(
        title: 'Login Required',
        message: 'Please sign in to leave a review.',
      );
      return;
    }

    if (!canReview.value) {
      ALoaders.warningSnackBar(
        title: 'Not Eligible',
        message: 'You can review this product after it has been delivered.',
      );
      return;
    }

    if (rating.value < 1) {
      ALoaders.warningSnackBar(
        title: 'Rating Required',
        message: 'Please select a star rating before submitting.',
      );
      return;
    }

    final comment = reviewController.text.trim();
    if (comment.isEmpty) {
      ALoaders.warningSnackBar(
        title: 'Review Required',
        message: 'Please write a short review before submitting.',
      );
      return;
    }

    try {
      isSubmitting.value = true;

      final user = Get.isRegistered<UserController>()
          ? UserController.instance.user.value
          : null;

      final review = ReviewModel(
        id: '${authUser.uid}_${product.id}',
        productId: product.id,
        userId: authUser.uid,
        userName: user?.fullName.isNotEmpty == true
            ? user!.fullName
            : authUser.displayName ?? 'Dekozy User',
        userImage: user?.profilePicture.isNotEmpty == true
            ? user!.profilePicture
            : authUser.photoURL ?? '',
        rating: rating.value,
        comment: comment,
        createdAt: DateTime.now(),
        sellerReply: userReview.value?.sellerReply,
        sellerReplyAt: userReview.value?.sellerReplyAt,
      );

      await _repository.submitReview(review);
      await loadReviews();

      ALoaders.successSnackBar(
        title: 'Thank you!',
        message: 'Your review has been submitted.',
      );
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isSubmitting.value = false;
    }
  }
}
