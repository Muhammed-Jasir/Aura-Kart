import 'package:aurakart/common/widgets/appbar/appbar.dart';
import 'package:aurakart/features/shop/screens/orders/widgets/orders_list.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Appbar
      appBar: AAppBar(
        title: Text(
          'My Orders',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),

      // Body
      body: const Padding(
        padding: EdgeInsets.all(ASizes.defaultSpace),

        /// Orders
        child: AOrderListItems(),
      ),
    );
  }
}
