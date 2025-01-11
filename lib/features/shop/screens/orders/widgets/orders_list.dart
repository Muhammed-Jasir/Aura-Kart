import 'package:aurakart/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:aurakart/features/shop/controllers/product/order_controller.dart';
import 'package:aurakart/navigation_menu.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/constants/sizes.dart';
import 'package:aurakart/utils/helpers/cloud_helper_functions.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:aurakart/utils/loaders/animation_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

class AOrderListItems extends StatelessWidget {
  const AOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    return FutureBuilder(
        future: controller.fetchUserOrders(),
        builder: (_, snapshot) {
          /// Nothing Found Widget
          final emptyWidget = AAnimationLoaderWidget(
            text: 'Whoops! No Orders Yet!',
            animation: AImages.orderCompletedAnimation,
            showAction: true,
            actionText: 'Let\'s fill it',
            onActionPressed: () => Get.off(() => const NavigationMenu()),
          );

          ///Helper function Handle Loader,No Record,OR ERROR MESSAGE
          final response = ACloudHelperFunctions.checkMultiRecordState(
              snapshot: snapshot, nothingFound: emptyWidget);
          if (response != null) return response;

          /// Congratulation Record Found
          final orders = snapshot.data!;

          return ListView.separated(
              shrinkWrap: true,
              itemCount: orders.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: ASizes.spaceBtwItems),
              itemBuilder: (_, index) {
                final order = orders[index];
                return ARoundedContainer(
                  showBorder: true,
                  backgroundColor: AHelperFunctions.isDarkMode(context)
                      ? AColors.dark
                      : AColors.light,
                  child: Column(
                    children: [
                      /// Row 1
                      Row(
                        children: [
                          /// Icon
                          const Icon(Iconsax.ship),
                          const SizedBox(width: ASizes.spaceBtwItems / 2),

                          /// Status & Date
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order.orderStatusText,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .apply(
                                          color: AColors.primary,
                                          fontWeightDelta: 1),
                                ),
                                Text(
                                  order.formattedOrderDate,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ],
                            ),
                          ),

                          /// Icon
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Iconsax.arrow_right_34,
                                size: ASizes.iconSm),
                          ),
                        ],
                      ),

                      const SizedBox(height: ASizes.spaceBtwItems),

                      /// Row 2
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                /// Icon
                                const Icon(Iconsax.ship),
                                const SizedBox(width: ASizes.spaceBtwItems / 2),

                                /// Status & Date
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        order.id,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                      Text(
                                        order.id,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Shipping Date
                          Expanded(
                            child: Row(
                              children: [
                                /// Icon
                                const Icon(Iconsax.calendar),
                                const SizedBox(width: ASizes.spaceBtwItems / 2),

                                /// Status & Date
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Shipping Date',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                      Text(
                                        order.formattedDeliveryDate,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
