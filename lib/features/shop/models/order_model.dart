import 'package:aurakart/features/personalization/models/address_model.dart';
import 'package:aurakart/features/shop/models/cart_item.model.dart';
import 'package:aurakart/utils/constants/enums.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderModel {
  final String id;
  final String docId;
  final String userId;
  OrderStatus status;
  final double totalAmount;
  final double shippingCost;
  final double taxCost;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? shippingAddress;
  final AddressModel? billingAddress;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;
  final bool billingAddressSameAsShipping;

  OrderModel({
    required this.id,
    this.userId = '',
    this.docId = '',
    required this.status,
    required this.items,
    required this.totalAmount,
    required this.shippingCost,
    required this.taxCost,
    required this.orderDate,
    this.paymentMethod = 'Cash on delivery',
    this.billingAddress,
    this.shippingAddress,
    this.deliveryDate,
    this.billingAddressSameAsShipping = true,
  });

  String get formattedOrderDate => AHelperFunctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate => deliveryDate != null
      ? AHelperFunctions.getFormattedDate(deliveryDate!)
      : '';

  String get orderStatusText => status == OrderStatus.delivered
      ? 'Delivered'
      : status == OrderStatus.shipped
          ? 'Shipment on the way'
          : 'Processing';

  /// Static function to create an empty model
  static OrderModel empty() => OrderModel(
        id: '',
        items: [],
        status: OrderStatus.pending,
        totalAmount: 0,
        orderDate: DateTime.now(),
        shippingCost: 0,
        taxCost: 0,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status.toString(),
      'totalAmount': totalAmount,
      'shippingCost': shippingCost,
      'taxCost': taxCost,
      'orderDate': orderDate,
      'paymentMethod': paymentMethod,
      'shippingAddress': shippingAddress?.toJson(),
      'billingAddress': billingAddress?.toJson(),
      'billingAddressSameAsShipping': billingAddressSameAsShipping,
      'deliveryDate': deliveryDate,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return OrderModel(
      docId: snapshot.id,
      id: data.containsKey('id') ? data['id'] as String : '',
      userId: data.containsKey('userId') ? data['userId'] as String : '',
      status: data.containsKey('status')
          ? OrderStatus.values.firstWhere((e) => e.toString() == data['status'])
          : OrderStatus.pending,
      totalAmount:
          data.containsKey('totalAmount') ? data['totalAmount'] as double : 0.0,
      shippingCost: data.containsKey('shippingCost')
          ? (data['shippingCost'] as num).toDouble()
          : 0.0,
      taxCost: data.containsKey('taxCost')
          ? (data['taxCost'] as num).toDouble()
          : 0.0,
      orderDate: data.containsKey('orderDate')
          ? (data['orderDate'] as Timestamp).toDate()
          : DateTime.now(),
      paymentMethod: data.containsKey('paymentMethod')
          ? data['paymentMethod'] as String
          : 'Cash on delivery',
      shippingAddress: data.containsKey('shippingAddress')
          ? AddressModel.fromMap(
              data['shippingAddress'] as Map<String, dynamic>)
          : null,
      billingAddress: data.containsKey('billingAddress')
          ? AddressModel.fromMap(data['billingAddress'] as Map<String, dynamic>)
          : null,
      billingAddressSameAsShipping:
          data.containsKey('billingAddressSameAsShipping')
              ? data['billingAddressSameAsShipping'] as bool
              : true,
      deliveryDate:
          data.containsKey('deliveryDate') && data['deliveryDate'] != null
              ? (data['deliveryDate'] as Timestamp).toDate()
              : null,
      items: data.containsKey('items')
          ? (data['items'] as List<dynamic>)
              .map((itemData) =>
                  CartItemModel.fromJson(itemData as Map<String, dynamic>))
              .toList()
          : [],
    );
  }
}
