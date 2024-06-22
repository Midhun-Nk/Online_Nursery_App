import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/all_product/all_product.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/homescreens/widget/all_product.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/homescreens/widget/block.dart';

import 'package:online_nursery_plant_shop/features/authentication/screens/homescreens/widget/home_appbar.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/homescreens/widget/homewidget.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/homescreens/widget/search_screen.dart';
import 'package:online_nursery_plant_shop/utils/constants/colors.dart';
import 'package:online_nursery_plant_shop/utils/constants/image_strings.dart';

import 'package:online_nursery_plant_shop/utils/constants/sizes.dart';
import 'package:online_nursery_plant_shop/utils/helpers/helper_functions.dart';
import 'package:online_nursery_plant_shop/widget/searchbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? mtoken = "";
  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User permission granted");
      getToken();
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("Provisional status given");
    } else {
      print("User permission for notification not given");
    }
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then(
      (token) {
        setState(() {
          mtoken = token;
          print("My token is $mtoken");
        });
        saveToken(token!);
      },
    );
  }

  void saveToken(String token) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();

      if (userSnapshot.exists) {
        final String? name = userSnapshot.data()?['UserName'];

        await FirebaseFirestore.instance.collection("tokens").doc(uid).set({
          'token': token,
          'name': name,
        });
        print("Token  saved successfully");
      } else {
        print("user doesnt exist");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          TPrimaryHeaderContainer(
              child: Column(
            children: [
              const THomeAppBar(),
              const SizedBox(height: TSizes.spaceBtwItems),
              TSearchContainer(
                text: "Search in Store",
                onTap: () => Get.to(() => const SearchScreen()),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              Padding(
                padding: const EdgeInsets.only(
                  left: TSizes.defaultSpace,
                ),
                child: Column(
                  children: [
                    TSectionHeading(
                      title: "Popualar Category",
                      showActionButton: false,
                      textColor: TColors.white,
                      buttonColor: TColors.dark,
                      onPressed: () => Get.to(() => const AllProductScreen()),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const THomeCategory(),
                  ],
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
            ],
          )),
          const Padding(
              padding: EdgeInsets.all(TSizes.md),
              child: TPromoSlider(
                banners: [
                  TImages.promoBanner1,
                  TImages.promoBanner2,
                  TImages.promoBanner3,
                ],
              )),
          const SizedBox(
            height: TSizes.sm,
          ),
          Padding(
            padding: const EdgeInsets.only(left: TSizes.md),
            child: TSectionHeading(
              title: "New Arrivals",
              showActionButton: false,
              textColor: dark ? TColors.white : TColors.black,
              onPressed: () => Get.to(() => const AllProduct()),
            ),
          ),
          const SizedBox(height: TSizes.sm),
          //  Padding(
          //    padding: const EdgeInsets.only(left:TSizes.md,right:TSizes.md),
          //    child: TGridLayout(itemCount: 6, itemBuilder:(_,index)=>  TProductCartVertical(index: index),),
          //  ),
          const Padding(
            padding: EdgeInsets.only(left: TSizes.md, right: TSizes.md),
            child: ProductBlock(),
          )
        ],
      ),
    ));
  }
}
