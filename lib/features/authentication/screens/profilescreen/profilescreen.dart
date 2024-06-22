import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:online_nursery_plant_shop/common/appbar.dart';
import 'package:online_nursery_plant_shop/common/shimmer_effect.dart';
import 'package:online_nursery_plant_shop/common/style/section_heading.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/profilescreen/change_name.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/profilescreen/profile_menu.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/shop/widget/brandshowcase.dart';
import 'package:online_nursery_plant_shop/features/personalization/controllers/user_controller.dart';
import 'package:online_nursery_plant_shop/utils/constants/image_strings.dart';
import 'package:online_nursery_plant_shop/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      appBar: const TAppBar(
        showbackarrow: true,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Obx(() {
                    final networkImage = controller.user.value.profilePicture;
                    final image =
                        networkImage.isNotEmpty ? networkImage : TImages.user;
                    return controller.imageUploading.value
                        ? const TshimmerEffect(
                            height: 80,
                            width: 80,
                            radius: 80,
                          )
                        : TCircularImage(
                            image: image,
                            width: 80,
                            height: 80,
                            isNetworkImage: networkImage.isNotEmpty,
                          );
                  }),
                  TextButton(
                      onPressed: () => controller.uploadUserProfilePicture(),
                      child: const Text(
                        "Change Profile Picture",
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            const Divider(),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            const TSectionHeading(
              title: 'Profile Information',
              showActionButton: false,
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            TProfileMenu(
              title: "Name",
              value: controller.user.value.fullName,
              onPressed: () => Get.to(() => const ChangeName()),
            ),
            TProfileMenu(
              title: "Username",
              value: controller.user.value.userName,
              onPressed: () {},
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            const Divider(),
            const TSectionHeading(
                title: "Personal Information", showActionButton: false),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            TProfileMenu(
                title: "User ID",
                value: controller.user.value.id,
                icon: Iconsax.copy,
                onPressed: () {}),
            TProfileMenu(
                title: "E-Mail",
                value: controller.user.value.email,
                onPressed: () {}),
            // TProfileMenu(
            //     title: "Phone Number",
            //     value: controller.user.value.phoneNumber,
            //     onPressed: () {}),

            const Divider(),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Center(
              child: OutlinedButton(
                  onPressed: () => controller.deleteAccountWarningPopUp(),
                  child: const Text(
                    "Close Account",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
