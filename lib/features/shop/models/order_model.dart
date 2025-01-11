import 'package:aurakart/features/personalization/models/address_model.dart';
import 'package:aurakart/features/shop/models/cart_item.model.dart';
import 'package:aurakart/utils/constants/enums.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderModel {
  final String id;
  final String userId;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? address;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;

  OrderModel(
      {required this.id,
      this.userId = '',
      required this.status,
      required this.totalAmount,
      required this.orderDate,
      this.paymentMethod = 'Paypal',
      this.address,
      this.deliveryDate,
      required this.items});
  String get formattedOrderDate => AHelperFunctions.getFormattedDate(orderDate);
  String get formattedDeliveryDate => deliveryDate != null
      ? AHelperFunctions.getFormattedDate(deliveryDate!)
      : '';
  String get orderStatusText => status == OrderStatus.delivered
      ? 'Delivered'
      : status == OrderStatus.shipped
          ? 'Shipment on the way'
          : 'Processing';
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status.toString(),
      'totalAmount': totalAmount,
      'orderDate': orderDate,
      'paymentMethod': paymentMethod,
      'address': address?.toJson(),
      'deliveryDate': deliveryDate,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return OrderModel(
      id: data['id'] as String,
      userId: ['userId'] as String,
      status:
          OrderStatus.values.firstWhere((e) => e.toString() == data['status']),
      totalAmount: ['totalAmount'] as double,
      orderDate: (data['orderDate'] as Timestamp).toDate(),
      paymentMethod: ['paymentMethod'] as String,
      address: AddressModel.fromMap(data['address'] as Map<String, dynamic>),
      deliveryDate: data['deliveryDate'] == null
          ? null
          : (data['deliveryDate'] as Timestamp).toDate(),
      items: (data['items'] as List<dynamic>)
          .map((itemData) =>
              CartItemModel.fromJson(itemData as Map<String, dynamic>))
          .toList(),
    );
  }
}
