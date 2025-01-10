import 'package:aurakart/data/repositories/repositories/address_repositories.dart';
import 'package:aurakart/features/personalization/models/address_model.dart';
import 'package:aurakart/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();
  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street  = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
   GlobalKey<FormState> addressFormkey=GlobalKey<FormState>();
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  ///Fetch all user specific addresses

  Future<List<AddressModel>> getAllUserAddress() async {
    try {
      final addresses = await addressRepository.fecthUserAddresses();
      selectedAddress.value = addresses.firstWhere(
          (element) => element.selectedAddress,
          orElse: () => AddressModel.empty());
      return addresses;
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Address not found', message: e.toString());
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      //Clear the "selected" field
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(selectedAddress.value.id , false);
      }
      //Assign selected address
      newSelectedAddress.selectedAddress=true;
      selectedAddress.value = newSelectedAddress ;

      //Set the "Selected" field to true for the newly selected address
    } catch (e) {
      ALoaders.errorSnackBar(
          title: 'Error in Selection', message: e.toString());
    }
  }

  //  add neww address
  Future addNewAddress()
  async {
    
  }

  
} 
