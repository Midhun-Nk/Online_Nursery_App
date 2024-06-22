import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/loginscreen/loginscreen.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/signupscreen/signup_form.dart';
import 'package:online_nursery_plant_shop/utils/constants/sizes.dart';
import 'package:online_nursery_plant_shop/utils/constants/text_strings.dart';

class SignUpscreen extends StatelessWidget {
  const SignUpscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                Text(
                  TTexts.signupTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: TSizes.defaultSpace,
                ),
                const SignUpFormFeild(),
                const SizedBox(
                  height: TSizes.defaultSpace,
                ),
                TFormDivider(
                  dividerText: TTexts.signupTitle.capitalize!,
                ),
                const SizedBox(
                  height: TSizes.defaultSpace,
                ),
                const SocialButton()
              ],
            )),
      ),
    );
  }
}
