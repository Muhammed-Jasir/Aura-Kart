import 'package:aurakart/utils/formatters/formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;
  DateTime? createdAt;
  DateTime? updatedAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured = false,
    this.parentId = '',
    this.createdAt,
    this.updatedAt,
  });

  String get formattedDate => AFormatter.formatDate(createdAt);
  String get formattedUpdatedAtDate => AFormatter.formatDate(updatedAt);

  /// Empty Helper Function
  static CategoryModel empty() =>
      CategoryModel(id: '', image: '', name: '', isFeatured: false);

  /// Convert Model to Json structure so that you can store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Image': image,
      'ParentId': parentId,
      'IsFeatured': isFeatured,
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt = DateTime.now(),
    };
  }

  /// Map Json oriented document snapshot from Firebase to Usermodel
  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      // Map Json Record to Model
      return CategoryModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        parentId: data['ParentId'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        createdAt:
            data.containsKey('CreatedAt') ? data['CreatedAt']?.toDate() : null,
        updatedAt:
            data.containsKey('UpdatedAt') ? data['UpdatedAt']?.toDate() : null,
      );
    } else {
      return CategoryModel.empty();
    }
  }
}
