import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_nursery_plant_shop/common/network_manager.dart';
import 'package:online_nursery_plant_shop/common/warning_snackbar.dart';
import 'package:online_nursery_plant_shop/data/repositories/user/user_repositiory.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/profilescreen/profilescreen.dart';
import 'package:online_nursery_plant_shop/features/personalization/controllers/user_controller.dart';
import 'package:online_nursery_plant_shop/utils/constants/image_strings.dart';
import 'package:online_nursery_plant_shop/utils/popups/full_screen_loader.dart';

class UpdateNameController extends GetxController{
  static UpdateNameController get  instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userReporsiory = Get.put(UserRepositiory());
  final GlobalKey<FormState> updateNameFormKey = GlobalKey<FormState>();


@override
void onInit() {
  super.onInit();
initializeNames();
}

Future<void> initializeNames()async{
  firstName.text = userController.user.value.firstName;
  lastName.text = userController.user.value.lastName;
}

Future<void> updateUserName() async{
try{
   TFullScreenLoader.openLoadingDialog('We Are Updating Your Information', TImages.processingAnimation);

   final isConnected = await NetworkManager.instance.isConnected();

   if (!isConnected) {
     TFullScreenLoader.stopLoading();
     return;
   }
   if (!updateNameFormKey.currentState!.validate()) {
     TFullScreenLoader.stopLoading();
     return;
   }

   Map<String, dynamic> name = {
     'FirstName': firstName.text.trim(),
     'LastName': lastName.text.trim(),
   };

   await userReporsiory.updateSingleField(name);


   userController.user.value.firstName = firstName.text.trim();
    userController.user.value.lastName = lastName.text.trim();

    TFullScreenLoader.stopLoading();
    TLoaders.sucessSnackBar(title: 'Congratulations', message: 'Your Name Has Been Updated');
    Get.off(()=>const ProfileScreen()); 
}catch(e){
  TFullScreenLoader.stopLoading();
  TLoaders.errorSnackBar(title: 'Oh Snap', message: 'Your Name Could Not Be Updated');
}
}
}