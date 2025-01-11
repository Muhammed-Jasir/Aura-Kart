import 'package:aurakart/data/repositories/repositories/address_repositories.dart';
import 'package:aurakart/features/personalization/models/address_model.dart';
import 'package:aurakart/utils/constants/image_strings.dart';
import 'package:aurakart/utils/helpers/network_manager.dart';
import 'package:aurakart/utils/popups/full_screen_loader.dart';
import 'package:aurakart/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();
  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormkey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
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
        await addressRepository.updateSelectedField(
            selectedAddress.value.id, false);
      }
      //Assign selected address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      //Set the "Selected" field to true for the newly selected address
      await addressRepository.updateSelectedField(
          selectedAddress.value.id, true);
    } catch (e) {
      ALoaders.errorSnackBar(
          title: 'Error in Selection', message: e.toString());
    }
  }

  //  add neww address
  Future addNewAddress() async {
    try {
      // Start Loading
      AFullScreenLoader.openLoadingDialog(
          'Storing Address...', AImages.docerAnimation);

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullScreenLoader.stopLoading();
        return;
      }
      //Form Validation
      if (!addressFormkey.currentState!.validate()) {
        AFullScreenLoader.stopLoading();
        return;
      }
      //Save Address data
      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        selectedAddress: true,
      );
      final id = await addressRepository.addAddress(address);
      //Update Selected Address status
      address.id = id;
      await selectAddress(address);
      //Remove Loader
      AFullScreenLoader.stopLoading();
      //Show Success Message
      ALoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your Address has been saved successfully.');
      //Refresh Address Data
      refreshData.toggle();
//reset fields
      resetFormFields();
//Redirect
      Navigator.of(Get.context!).pop();
    } catch (e) {
      //Remove Loader
      AFullScreenLoader.stopLoading();
      ALoaders.errorSnackBar(title: 'Address not found', message: e.toString());
    }
  }

  /// Fuction to reset form fields
  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormkey.currentState?.reset();
  }
}
