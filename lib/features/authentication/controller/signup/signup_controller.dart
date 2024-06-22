import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_nursery_plant_shop/common/network_manager.dart';
import 'package:online_nursery_plant_shop/common/warning_snackbar.dart';
import 'package:online_nursery_plant_shop/data/repositories/authentication/authentication_repository.dart';
import 'package:online_nursery_plant_shop/data/repositories/user/user_model.dart';
import 'package:online_nursery_plant_shop/data/repositories/user/user_repositiory.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/signupscreen/verifyemail.dart';
import 'package:online_nursery_plant_shop/utils/constants/image_strings.dart';
import 'package:online_nursery_plant_shop/utils/popups/full_screen_loader.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final email = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;

  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  @override
  void signup() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'We Are Processing Your Information...', TImages.processingAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!signUpFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!privacyPolicy.value) {
        TLoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
                'In Order to create acount,you must Accept Privacy Policy & Terms and Conditions');
        return;
      }
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        userName: userName.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepositiory());
      await userRepository.saveUserRecord(newUser);
      
      TFullScreenLoader.stopLoading();

      TLoaders.sucessSnackBar(
          title: "Congratulations!",
          message:
              "Your Account has been created! Verify your email to Continue.");
      Get.to(() =>  VerifyEmailScreen(
        email: email.text.trim()  ,
      ));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
