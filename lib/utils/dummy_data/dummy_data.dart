import 'package:aurakart/features/personalization/models/user_model.dart';
import 'package:aurakart/features/shop/models/category_model.dart';
import 'package:aurakart/utils/constants/enums.dart';
import 'package:aurakart/utils/constants/image_strings.dart';

class ADummyData {
  // // Bunners
  // static final List<BannerModel> banners = [
  //     BannerModel(imageUrl: AImages.banner1, targetScreen: ARoutes.order, active: false),
  //     BannerModel(imageUrl: AImages.banner2, targetScreen: ARoutes.cart, active: true),
  //     BannerModel (imageUrl: AImages.banner3, targetScreen: ARoutes.favourites, active: true),
  //     BannerModel (imageUrl: AImages.banner4, targetScreen: ARoutes.search, active: true),
  //     BannerModel(imageUrl: AImages.banner5, targetScreen: ARoutes.settings, active: true),
  //     BannerModel (imageUrl: AImages.banner6, targetScreen: ARoutes.userAddress, active: true),
  //     BannerModel(imageurl: AImages.banner7, targetScreen: ARoutes.checkout, active: false), 
  // ];

  // // User
  // static final UserModel user = UserModel (
  //   id: '1',
  //   username: 'hiiam',
  //   firstName: 'Aura',
  //   lastName: 'kart',
  //   email: 'aurakart@gmail.com',
  //   phoneNumber: "+91 12345 12345",
  //   profilePicture: AImages.user,
  //   addresses: [
  //     AddressModel(
  //       id: '1',
  //       name: 'aura',
  //       phoneNumber: "+91 12345 12345",
  //       street: '82356 Timmy Coves',
  //       city: 'South Liana',
  //       state: 'Maine',
  //       postalCode: "87665",
  //       country: 'USA',
  //     ),
  //   ],
  // );


  // // Cart
  // static final CartModel cart = CartModel(
  //   cartId: '001',
  //   items: [
  //     CartItemModel(
  //       productId: '001',
  //       variationid: '1',
  //       quantity: 1,
  //       title: products[0].title,
  //       image: products[0].thumbnail,
  //       brandName: products [80.brand!.name,
  //       price: products[0].productVariations![0].price,
  //       selectedVariation: products[0].productVariations![0].attributeValues, 
  //     ),
  //   ],
  // );

  // // order
  // static final List<OrderModel> orders = [
  //   OrderModel(
  //     id: 'CWT0012',
  //     status: OrderStatus.processing,
  //     items: cart.items,
  //     totalAmount: 135,
  //     orderDate: DateTime(9203, 03, 2),
  //     deliveryDate: DateTime(2932, 93,2),
  //   )
  // ];

  // List of all Categories
  // static final List<CategoryModel> categories = [
  //   CategoryModel(id: '1', image: AImages.sportIcon, name: 'Sports', isFeatured: true),
  //   CategoryModel(id: '5', image: AImages.furnitureIcon, name: 'Furniture', isFeatured: true),
  //   CategoryModel(id: '2', image: AImages.electronicsIcon, name: 'Electronics', isFeatured: true),
  //   CategoryModel(id: '3', image: AImages.clothIcon, name: 'Clothes', isFeatured: true),
  //   CategoryModel(id: '14', image: AImages.animalIcon, name: "Animals", isFeatured: true),
  //   CategoryModel(id: '6', image: AImages.shoeIcon, name: "Shoes", isFeatured: true),
  //   CategoryModel(id: '66', image: AImages.cosmeticsIcon, name: "Cosmetics", isFeatured: true),
  //   CategoryModel(id: '14', image: AImages.jeweleryIcon, name: "Jewelery", isFeatured: true),

  //   /// subcategories
  //   CategoryModel(id: '8', image: AImages.sportIcon, name: 'Sport Shoes', parentId: '1', isFeatured: false),
  //   CategoryModel(id: '9', image: AImages.sportIcon, name: 'Track suits', parentId: '1', isFeatured: false),
  //   CategoryModel(id: '10', image: AImages.sportIcon, name: 'Sports Equipments', parentId: '1', isFeatured: false),

  //   // furniture
  //   CategoryModel(id: '11', image: AImages.furnitureIcon, name: 'Bedroom furniture', parentId: '5', isFeatured: false),
  //   CategoryModel(id: '12', image: AImages.furnitureIcon, name: 'Kitchen furniture', parentId: '5', isFeatured: false),
  //   CategoryModel (id: '13', image: AImages.furnitureIcon, name: 'Office furniture', parentId: '5', isFeatured: false),

  //   // electronics
  //   CategoryModel(id: '14', image: AImages.electronicsIcon, name: 'Laptop', parentId: '2', isFeatured: false),
  //   CategoryModel (id: '15', image: AImages.electronicsIcon, name: 'Mobile', parentId: '2', isFeatured: false)
  // ];

  // Products
  // static const String productImage1 = "assets/images/products/nike-shoes.png";
  // static const String productImage2 = "assets/images/products/product-1.png";
  // static const String productImage3 =
  //     "assets/images/products/product-jacket.png";
  // static const String productImage4 =
  //     "assets/images/products/product-jeans.png";
  // static const String productImage5 =
  //     "assets/images/products/product-shirt.png";
  // static const String productImage6 =
  //     "assets/images/products/product-slippers.png";
  // static const String productImage7 =
  //     "assets/images/products/NikeAirJOrdonBlackRed.png";
  // static const String productImage8 =
  //     "assets/images/products/NikeAirJOrdonOrange.png";
  // static const String productImage9 =
  //     "assets/images/products/NikeAirJordonwhiteMagenta.png";
  // static const String productImage10 =
  //     "assets/images/products/NikeAirJOrdonWhiteRed.png";
  // static const String productImage11 =
  //     "assets/images/products/samsung_s9_mobile.png";
  // static const String productImage12 =
  //     "assets/images/products/samsung_s9_mobile_withback.png";
  // static const String productImage13 =
  //     "assets/images/products/samsung_s9_mobile_back.png";
  // static const String productImage14 =
  //     "assets/images/products/iphone8_mobile.png";
  // static const String productImage15 =
  //     "assets/images/products/iphone8_mobile_back.png";
  // static const String productImage16 =
  //     "assets/images/products/iphone8_mobile_dual_side.png";
  // static const String productImage17 =
  //     "assets/images/products/iphone8_mobile_front.png";
  // static const String productImage18 =
  //     "assets/images/products/tomi_dogfood.png";
  // static const String productImage19 =
  //     "assets/images/products/NikeAirJordonSingleBlue.png";
  // static const String productImage20 =
  //     "assets/images/products/NikeAirJordonSingleOrange.png";
  // static const String productImage21 = "assets/images/products/NikeAirMax.png";
  // static const String productImage22 =
  //     "assets/images/products/NikeBasketballShoeGreenBlack.png";
  // static const String productImage23 =
  //     "assets/images/products/NikeWildhorse.png";
  // static const String productImage24 =
  //     "assets/images/products/tracksuit_black.png";
  // static const String productImage25 =
  //     "assets/images/products/tracksuit_blue.png";
  // static const String productImage26 =
  //     "assets/images/products/tracksuit_red.png";
  // static const String productImage27 =
  //     "assets/images/products/trcksuit_parrotgreen.png";
  // static const String productImage28 =
  //     "assets/images/products/Adidas_Football.png";
  // static const String productImage29 =
  //     "assets/images/products/baseball_bat.png";
  // static const String productImage30 = "assets/images/products/cricket_bat.png";
  // static const String productImage31 =
  //     "assets/images/products/tennis_racket.png";
  // static const String productImage32 = "assets/images/products/bedroom_bed.png";
  // static const String productImage33 =
  //     "assets/images/products/bedroom_lamp.png";
  // static const String productImage34 =
  //     "assets/images/products/bedroom_sofa.png";
  // static const String productImage35 =
  //     "assets/images/products/bedroom_wardrobe.png";
  // static const String productImage36 =
  //     "assets/images/products/kitchen_counter.png";
  // static const String productImage37 =
  //     "assets/images/products/kitchen_dining table.png";
  // static const String productImage38 =
  //     "assets/images/products/kitchen_refrigerator.png";
  // static const String productImage39 =
  //     "assets/images/products/office_chair_1.png";
  // static const String productImage40 =
  //     "assets/images/products/office_chair_2.png";
  // static const String productImage41 =
  //     "assets/images/products/office_desk_1.png";
  // static const String productImage42 =
  //     "assets/images/products/office_desk_2.png";
  // static const String productImage43 =
  //     "assets/images/products/bedroom_bed_black.png";
  // static const String productImage44 =
  //     "assets/images/products/bedroom_bed_grey.png";
  // static const String productImage45 =
  //     "assets/images/products/bedroom_bed_simple_brown.png";
  // static const String productImage46 =
  //     "assets/images/products/bedroom_bed_with_comforter.png";
  // static const String productImage47 =
  //     "assets/images/products/acer_laptop_1.png";
  // static const String productImage48 =
  //     "assets/images/products/acer_laptop_2.png";
  // static const String productImage49 =
  //     "assets/images/products/acer_laptop_3.png";
  // static const String productImage50 =
  //     "assets/images/products/acer_laptop_4.png";
  // static const String productImage51 =
  //     "assets/images/products/iphone_13_pro.png";
  // static const String productImage52 =
  //     "assets/images/products/iphone_14_pro.png";
  // static const String productImage53 =
  //     "assets/images/products/iphone_14_white.png";
  // static const String productImage54 =
  //     "assets/images/products/product-shirt_blue_1.png";
  // static const String productImage55 =
  //     "assets/images/products/product-shirt_blue_2.png";
  // static const String productImage56 =
  //     "assets/images/products/acer_laptop_var_1.png";
  // static const String productImage57 =
  //     "assets/images/products/acer_laptop_var_2.png";
  // static const String productImage58 =
  //     "assets/images/products/acer_laptop_var_3.png";
  // static const String productImage59 =
  //     "assets/images/products/acer_laptop_var_4.png";
  // static const String productImage60 =
  //     "assets/images/products/tshirt_red_collar.png";
  // static const String productImage61 =
  //     "assets/images/products/tshirt_yellow_collar.png";
  // static const String productImage62 =
  //     "assets/images/products/tshirt_green_collar.png";
  // static const String productImage63 =
  //     "assets/images/products/tshirt_blue_collar.png";
  // static const String productImage64 =
  //     "assets/images/products/leather_jacket_1.png";
  // static const String productImage65 =
  //     "assets/images/products/leather_jacket_2.png";
  // static const String productImage66 =
  //     "assets/images/products/leather_jacket_3.png";
  // static const String productImage67 =
  //     "assets/images/products/leather_jacket_4.png";
  // static const String productImage68 =
  //     "assets/images/products/tshirt_blue_without_collar_back.png";
  // static const String productImage69 =
  //     "assets/images/products/tshirt_blue_without_collar_front.png";
  // static const String productImage70 =
  //     "assets/images/products/iphone_12_red.png";
  // static const String productImage71 =
  //     "assets/images/products/iphone_12_blue.png";
  // static const String productImage72 =
  //     "assets/images/products/iphone_12_green.png";
  // static const String productImage73 =
  //     "assets/images/products/iphone_12_black.png";
  // static const String productImage74 =
  //     "assets/images/products/slipper-product-1.png";
  // static const String productImage75 =
  //     "assets/images/products/slipper-product-2.png";
  // static const String productImage76 =
  //     "assets/images/products/slipper-product-3.png";
  // static const String productImage77 =
  //     "assets/images/products/slipper-product.png";


  // Banners
  // static const String promoBanner1 = "assets/images/banners/promo-banner-1.png";
  // static const String promoBanner2 = "assets/images/banners/promo-banner-2.png";
  // static const String promoBanner3 = "assets/images/banners/promo-banner-3.png";
  // static const String banner1 = "assets/images/banners/banner_1.jpg";
  // static const String banner2 = "assets/images/banners/banner_2.jpg";
  // static const String banner3 = "assets/images/banners/banner_3.jpg";
  // static const String banner4 = "assets/images/banners/banner_4.jpg";
  // static const String banner5 = "assets/images/banners/banner_5.jpg";
  // static const String banner6 = "assets/images/banners/banner_6.jpg";
  // static const String banner7 = "assets/images/banners/banner_7.jpg";
  // static const String banner8 = "assets/images/banners/banner_8.jpg";

  // Brand Icons
  // static const String nikeLogo = "assets/icons/brands/nike.png";
  // static const String adidasLogo = "assets/icons/brands/adidas-logo.png";
  // static const String appleLogo = "assets/icons/brands/apple-logo.png";
  // static const String jordanLogo = "assets/icons/brands/jordan-logo.png";
  // static const String pumaLogo = "assets/icons/brands/puma-logo.png";
  // static const String zaraLogo = "assets/icons/brands/zara-logo.png";
  // static const String kenwoodLogo = "assets/icons/brands/kenwood-logo.png";
  // static const String hermanMillerLogo =
  //     "assets/icons/brands/herman-miller-logo.png";
  // static const String ikeaLogo = "assets/icons/brands/ikea_logo.png";
  // static const String acerlogo = "assets/icons/brands/acer_logo.png";

  // Category Icons
  // static const String sportIcon = "assets/icons/categories/sports.png";
  // static const String perfumeIcon = "assets/icons/categories/perfume.png";
  // static const String sneakersIcon = "assets/icons/categories/sneakers.png";
  // static const String tshirtIcon = "assets/icons/categories/tshirt.png";
  // static const String tvIcon = "assets/icons/categories/tv.png";
  // static const String sportsIcon =
  //     "assets/icons/categories/icons8-bowling-64.png";
  // static const String clothIcon =
  //     "assets/icons/categories/icons8-tailors-dummy-64.png";
  // static const String shoeIcon = "assets/icons/categories/icons8-shoes-64.png";
  // static const String cosmeticsIcon =
  //     "assets/icons/categories/icons8-cosmetics-64.png";
  // static const String animalIcon =
  //     "assets/icons/categories/icons8-dog-heart-64.png";
  // static const String toyIcon =
  //     "assets/icons/categories/icons8-wooden-toy-car-50.png";
  // static const String furnitureIcon =
  //     "assets/icons/categories/icons8-dining-chair-64.png";
  // static const String jeweleryIcon =
  //     "assets/icons/categories/icons8-sparkling-diamond-64.png";
  // static const String electronicsIcon =
  //     "assets/icons/categories/icons8-smartphone-64.png";
}