import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_nursery_plant_shop/common/network_manager.dart';
import 'package:online_nursery_plant_shop/common/warning_snackbar.dart';
import 'package:online_nursery_plant_shop/data/repositories/authentication/authentication_repository.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/loginscreen/password_configuration/reset_password.dart';
import 'package:online_nursery_plant_shop/utils/constants/image_strings.dart';
import 'package:online_nursery_plant_shop/utils/popups/full_screen_loader.dart';

class ForgetPasswordController extends GetxController {


  static ForgetPasswordController get instance => Get.find();
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  sendPasswordResetEmail()async{
    try{
     TFullScreenLoader.openLoadingDialog('Sending Email', TImages.processingAnimation);

     final isConnected = await NetworkManager.instance.isConnected();

    if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!forgetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      
      await AuthenticationRepository.instance.sendPasswordRestEmail(email.text.trim());

      TFullScreenLoader.stopLoading();

      TLoaders.sucessSnackBar(title: 'Email Sent', message: 'Please Check Your Email to Reset Password'.tr);
 Get.to(()=>ResetPasswordScreen(email: email.text.trim(),));
    }catch(e){
            TFullScreenLoader.stopLoading();
                  TLoaders.errorSnackBar(title: 'Oh Snap', message: 'Please Check Your Email to Reset Password'.tr);


    }

  }

  resendPasswordRestEmail( String email)async{
     try{
     TFullScreenLoader.openLoadingDialog('Processing Your Request', TImages.processingAnimation);

     final isConnected = await NetworkManager.instance.isConnected();

    if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.sendPasswordRestEmail(email);

      TFullScreenLoader.stopLoading();

      TLoaders.sucessSnackBar(title: 'Email Sent', message: 'Please Check Your Email to Reset Password'.tr);
    }catch(e){
            TFullScreenLoader.stopLoading();
                  TLoaders.errorSnackBar(title: 'Oh Snap', message: 'Please Check Your Email to Reset Password'.tr);


    }

  }
  }
