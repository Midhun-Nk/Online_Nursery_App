import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:online_nursery_plant_shop/features/authentication/controller/signup/signup_controller.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/signupscreen/terms_and_condition.dart';
import 'package:online_nursery_plant_shop/utils/constants/sizes.dart';
import 'package:online_nursery_plant_shop/utils/constants/text_strings.dart';
import 'package:online_nursery_plant_shop/utils/validators/validation.dart';

class SignUpFormFeild extends StatelessWidget {
  const SignUpFormFeild({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signUpFormKey,
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller.firstName,
                validator: (value)=>TValidator.validateEmptyText('First Name', value),
                expands: false,
                decoration: const InputDecoration(
                  labelText: TTexts.firstName,
                  prefixIcon: Icon(Iconsax.user),
                ),
              ),
            ),
            const SizedBox(
              width: TSizes.spaceBtwInputFields,
            ),
            Expanded(
              child: TextFormField(
                                validator: (value)=>TValidator.validateEmptyText('Last Name', value),

                controller: controller.lastName,
                expands: false,
                decoration: const InputDecoration(
                  labelText: TTexts.lastName,
                  prefixIcon: Icon(Iconsax.user),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
        TextFormField(
          controller: controller.userName,
                          validator: (value)=>TValidator.validateEmptyText('userName', value),

          expands: false,
          decoration: const InputDecoration(
            labelText: TTexts.username,
            prefixIcon: Icon(Iconsax.user_edit),
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
        TextFormField(
                          validator: (value)=>TValidator.validateEmail( value),

          controller: controller.email,
          expands: false,
          decoration: const InputDecoration(
            labelText: TTexts.email,
            prefixIcon: Icon(Iconsax.direct),
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
        TextFormField(
                                    validator: (value)=>TValidator.validatePhoneNumber( value),

          controller: controller.phoneNumber,
          expands: false,
          decoration: const InputDecoration(
            labelText: TTexts.phoneNo,
            prefixIcon: Icon(Iconsax.call),
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
        Obx(
          ()=> TextFormField(
            controller: controller.password,
                                      validator: (value)=>TValidator.validatePassword( value),
          
            expands: false,
            obscureText: controller.hidePassword.value,
            decoration:  InputDecoration(
              labelText: TTexts.password,
              prefixIcon: const Icon(Iconsax.password_check),
              suffixIcon: IconButton(onPressed: ()=> controller.hidePassword.value =!controller.hidePassword.value, icon:  Icon(controller.hidePassword.value? Iconsax.eye_slash: Iconsax.eye)),
              
            ),
          ),
        ),
        const SizedBox(
          height: TSizes.defaultSpace,
        ),
        const TermsAndConditionCheckBox(),
        const SizedBox(
          height: TSizes.defaultSpace,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: ()  => controller.signup(),
            child: const Text(TTexts.createAccount),
          ),
        ),
      ],
    ));
  }
}
