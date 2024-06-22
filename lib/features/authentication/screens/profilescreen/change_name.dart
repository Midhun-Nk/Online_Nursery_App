import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:online_nursery_plant_shop/common/appbar.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/profilescreen/update_name_controller.dart';
import 'package:online_nursery_plant_shop/utils/constants/sizes.dart';
import 'package:online_nursery_plant_shop/utils/constants/text_strings.dart';
import 'package:online_nursery_plant_shop/utils/validators/validation.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return  Scaffold(
      appBar: TAppBar(
        showbackarrow: true,
        title:  Text('Change Name',
        style:  Theme.of(context).textTheme.headlineSmall,
        ),
      ),

      body: Padding(padding:const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
Text('Use Reak Name for easy verifcation.This name will be visible to all users',
style:  Theme.of(context).textTheme.labelMedium,),
const SizedBox(height: TSizes.spaceBtwSections),
Form(
  key: controller.updateNameFormKey ,
  child: Column(
    children: [
      TextFormField(
        controller: controller.firstName,
        validator: (value)=> TValidator.validateEmptyText('First Name', value),
        expands: false,
        decoration: const InputDecoration(
          labelText: TTexts.firstName,
          prefixIcon: Icon(Iconsax.user),
        ),
      ),
      const SizedBox(height: TSizes.spaceBtwInputFields),
      TextFormField(
        controller: controller.lastName,
        validator: (value)=> TValidator.validateEmptyText('First Name', value),
        expands: false,
        decoration: const InputDecoration(
          labelText: TTexts.lastName,
          prefixIcon: Icon(Iconsax.user),
        ),
      )
    ],
  )),
  const SizedBox(height: TSizes.spaceBtwSections),

  SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: ()=> controller.updateUserName(),
      child: const Text('Save'),
    ),
  )
        ],
      ),
      ),
    );
  }
}