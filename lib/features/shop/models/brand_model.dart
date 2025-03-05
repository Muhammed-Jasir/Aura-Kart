import 'package:aurakart/features/shop/models/category_model.dart';
import 'package:aurakart/utils/formatters/formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool isFeatured;
  int? productsCount;
  DateTime? createdAt;
  DateTime? updatedAt;

  // not mapped
  List<CategoryModel>? brandCategories;

  BrandModel({
    required this.id,
    required this.image,
    required this.name,
    this.isFeatured = false,
    this.productsCount,
    this.createdAt,
    this.updatedAt,
    this.brandCategories,
  });

  String get formattedDate => AFormatter.formatDate(createdAt);

  String get formatUpdatedAtDate => AFormatter.formatDate(updatedAt);

  /// Empty Helper Function
  static BrandModel empty() => BrandModel(id: '', name: '', image: '');

  /// Convert model to Json structure so that you can store data in FireBase
  toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'CreatedAt': createdAt,
      'IsFeatured': isFeatured,
      'ProductsCount': productsCount = 0,
      'UpdatedAt': updatedAt = DateTime.now(),
    };
  }

  /// Map Json oriented document snapshot from Firebase to BannerModel
  factory BrandModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();

    if (data != null) {
      // Map JSON Record to the Model
      return BrandModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        productsCount: data['ProductsCount'] ?? '',
        createdAt:
            data.containsKey('CreatedAt') ? data['CreatedAt']?.toDate() : null,
        updatedAt:
            data.containsKey('UpdatedAt') ? data['UpdatedAt']?.toDate() : null,
      );
    } else {
      return BrandModel.empty();
    }
  }

  /// Map Json oriented document snapshot from Firebase to BannerModel
  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;

    if (data.isNotEmpty) {
      return BrandModel(
        id: data['Id'] ?? '',
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        productsCount: int.parse((data['ProductsCount'] ?? 0).toString()),
        createdAt:
            data.containsKey('CreatedAt') ? data['CreatedAt']?.toDate() : null,
        updatedAt:
            data.containsKey('UpdatedAt') ? data['UpdatedAt']?.toDate() : null,
      );
    } else {
      return BrandModel.empty();
    }
  }
}
