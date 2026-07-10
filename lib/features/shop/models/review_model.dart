import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String id;
  final String productId;
  final String userId;
  final String userName;
  final String userImage;
  final double rating;
  final String comment;
  final DateTime createdAt;
  final String? sellerReply;
  final DateTime? sellerReplyAt;

  const ReviewModel({
    required this.id,
    required this.productId,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.rating,
    required this.comment,
    required this.createdAt,
    this.sellerReply,
    this.sellerReplyAt,
  });

  static ReviewModel empty() => ReviewModel(
        id: '',
        productId: '',
        userId: '',
        userName: '',
        userImage: '',
        rating: 0,
        comment: '',
        createdAt: DateTime.now(),
      );

  Map<String, dynamic> toJson() {
    return {
      'ProductId': productId,
      'UserId': userId,
      'UserName': userName,
      'UserImage': userImage,
      'Rating': rating,
      'Comment': comment,
      'CreatedAt': createdAt,
      'SellerReply': sellerReply,
      'SellerReplyAt': sellerReplyAt,
    };
  }

  factory ReviewModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data();
    if (data == null) return ReviewModel.empty();

    return ReviewModel(
      id: document.id,
      productId: data['ProductId'] ?? '',
      userId: data['UserId'] ?? '',
      userName: data['UserName'] ?? '',
      userImage: data['UserImage'] ?? '',
      rating: double.parse((data['Rating'] ?? 0).toString()),
      comment: data['Comment'] ?? '',
      createdAt: data['CreatedAt'] is Timestamp
          ? (data['CreatedAt'] as Timestamp).toDate()
          : DateTime.now(),
      sellerReply: data['SellerReply'],
      sellerReplyAt: data['SellerReplyAt'] is Timestamp
          ? (data['SellerReplyAt'] as Timestamp).toDate()
          : null,
    );
  }
}

class ReviewStats {
  final double averageRating;
  final int totalReviews;
  final Map<int, double> distribution;

  const ReviewStats({
    this.averageRating = 0,
    this.totalReviews = 0,
    this.distribution = const {1: 0, 2: 0, 3: 0, 4: 0, 5: 0},
  });

  factory ReviewStats.fromReviews(List<ReviewModel> reviews) {
    if (reviews.isEmpty) return const ReviewStats();

    final counts = {for (var star in [1, 2, 3, 4, 5]) star: 0};
    var total = 0.0;

    for (final review in reviews) {
      final star = review.rating.round().clamp(1, 5);
      counts[star] = (counts[star] ?? 0) + 1;
      total += review.rating;
    }

    final distribution = {
      for (final entry in counts.entries)
        entry.key: entry.value / reviews.length,
    };

    return ReviewStats(
      averageRating: total / reviews.length,
      totalReviews: reviews.length,
      distribution: distribution,
    );
  }
}
