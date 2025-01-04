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
  static final List<CategoryModel> categories = [
    CategoryModel(id: '1', image: AImages.sportIcon, name: 'Sports', isFeatured: true),
    CategoryModel(id: '5', image: AImages.furnitureIcon, name: 'Furniture', isFeatured: true),
    CategoryModel(id: '2', image: AImages.electronicsIcon, name: 'Electronics', isFeatured: true),
    CategoryModel(id: '3', image: AImages.clothIcon, name: 'Clothes', isFeatured: true),
    CategoryModel(id: '14', image: AImages.animalIcon, name: "Animals", isFeatured: true),
    CategoryModel(id: '6', image: AImages.shoeIcon, name: "Shoes", isFeatured: true),
    CategoryModel(id: '66', image: AImages.cosmeticsIcon, name: "Cosmetics", isFeatured: true),
    CategoryModel(id: '14', image: AImages.jeweleryIcon, name: "Jewelery", isFeatured: true),

    /// subcategories
    CategoryModel(id: '8', image: AImages.sportIcon, name: 'Sport Shoes', parentId: '1', isFeatured: false),
    CategoryModel(id: '9', image: AImages.sportIcon, name: 'Track suits', parentId: '1', isFeatured: false),
    CategoryModel(id: '10', image: AImages.sportIcon, name: 'Sports Equipments', parentId: '1', isFeatured: false),

    // furniture
    CategoryModel(id: '11', image: AImages.furnitureIcon, name: 'Bedroom furniture', parentId: '5', isFeatured: false),
    CategoryModel(id: '12', image: AImages.furnitureIcon, name: 'Kitchen furniture', parentId: '5', isFeatured: false),
    CategoryModel (id: '13', image: AImages.furnitureIcon, name: 'Office furniture', parentId: '5', isFeatured: false),

    // electronics
    CategoryModel(id: '14', image: AImages.electronicsIcon, name: 'Laptop', parentId: '2', isFeatured: false),
    CategoryModel (id: '15', image: AImages.electronicsIcon, name: 'Mobile', parentId: '2', isFeatured: false)
  ];
}