import 'package:aurakart/features/authentication/screens/login/login.dart';
import 'package:aurakart/features/authentication/screens/onboarding/onboarding.dart';
import 'package:aurakart/features/authentication/screens/password_configuration/forgot_password.dart';
import 'package:aurakart/features/authentication/screens/signup/signup.dart';
import 'package:aurakart/features/authentication/screens/signup/verify_email.dart';
import 'package:aurakart/features/personalization/screens/address/address.dart';
import 'package:aurakart/features/personalization/screens/profile/profile.dart';
import 'package:aurakart/features/personalization/screens/settings/setting.dart';
import 'package:aurakart/features/shop/models/product_model.dart';
import 'package:aurakart/features/shop/screens/cart/cart.dart';
import 'package:aurakart/features/shop/screens/checkout/checkout.dart';
import 'package:aurakart/features/shop/screens/orders/order.dart';
import 'package:aurakart/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:aurakart/features/shop/screens/store/store.dart';
import 'package:aurakart/features/shop/screens/wishlist/wishlist.dart';
import 'package:aurakart/routes/routes.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../features/shop/screens/home/home.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: ARoutes.home, page: () => const HomeScreen()),
    GetPage(name: ARoutes.store, page: () => const StoreScreen()),
    GetPage(name: ARoutes.favourites, page: () => const FavouriteScreen()),
    GetPage(name: ARoutes.settings, page: () => const SettingsScreen()),
    GetPage(
      name: ARoutes.productReviews,
      page: () => const ProductReviewsScreens(),
    ),
    GetPage(name: ARoutes.order, page: () => const OrderScreen()),
    GetPage(name: ARoutes.checkout, page: () => const CheckoutScreen()),
    GetPage(name: ARoutes.cart, page: () => const CartScreen()),
    GetPage(name: ARoutes.userProfile, page: () => const ProfileScreen()),
    GetPage(name: ARoutes.userAddress, page: () => const UserAddressScreen()),
    GetPage(name: ARoutes.signup, page: () => const SignupScreen()),
    GetPage(name: ARoutes.verifyEmail, page: () => const VerifyEmailScreen()),
    GetPage(name: ARoutes.signIn, page: () => const LoginScreen()),
    GetPage(name: ARoutes.forgetPassword, page: () => const ForgetPassword()),
    GetPage(name: ARoutes.onBoarding, page: () => const OnBoardingScreen()),

    // Add more GetPage entries as needed
  ];
}
