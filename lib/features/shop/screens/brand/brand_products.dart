import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/common/widgets/brands/brand_card.dart';
import 'package:aurakart/common/widgets/products/sortable/sortable_products.dart';
import 'package:aurakart/features/shop/models/product_model.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // Appbar
      appBar: AAppBar(
        title: Text('Nike'),
      ),

      // Body
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            children: [
              /// Brand Detail
              ABrandCard(showBorder: true),
              SizedBox(height: ASizes.spaceBtwSections),

              ASortableProducts(products: []),
            ],
          ),
        ),
      ),
    );
  }
}
