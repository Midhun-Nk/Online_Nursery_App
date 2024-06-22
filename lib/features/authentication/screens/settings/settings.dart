import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:online_nursery_plant_shop/common/appbar.dart';
import 'package:online_nursery_plant_shop/common/horizontal_product_card.dart';
import 'package:online_nursery_plant_shop/common/messger_user.dart';
import 'package:online_nursery_plant_shop/data/repositories/authentication/authentication_repository.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/cart/cart.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/homescreens/widget/homewidget.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/order/order.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/profilescreen/address/address.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/profilescreen/profilescreen.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/settings/widgets/seller_screen.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/settings/widgets/settings_menu_tile.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/settings/widgets/settingswidgets.dart';
import 'package:online_nursery_plant_shop/utils/constants/sizes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          TPrimaryHeaderContainer(
              child: Column(
            children: [
              TAppBar(
                title: Text(
                  'Account',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .apply(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
               TUserProfileTile ( onPressed: () => Get.to(()=> const  ProfileScreen(),)),
              
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const SizedBox(
                height: TSizes.md,
              ),
            ],
          )),
          Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
               const  TSectionHeading(
                  title: 'Account Settings',
                  showActionButton: false,
                  
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                
                TSettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: "My Address",
                    subtitle: 'Set Shoping Delivery Address',
                    onTap: () => Get.to(() => const UserAddressScreen())),
                TSettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: "My Cart",
                    subtitle: 'Add , Remove Products and move to checkout',
                    onTap: () {
                      Get.to(() => const ProductCarty());

                    }),
                TSettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: "My Order",
                    subtitle: 'In-Progress and Completed Orders',
                    onTap: () => Get.to(() => const CartScreen())),
                TSettingsMenuTile(
                    icon: Iconsax.bank,
                    title: "Experties",
                    subtitle: 'Chat with Experts',
                   onTap: () => Get.to(() =>  const IndoxmainpagePage()),),
                TSettingsMenuTile(
                    icon: Iconsax.discount_shape,
                    title: "Seller TokenKey",
                    subtitle: 'Your Seller Token Key:- tokenkey',
                    onTap: () => Get.to(() => const SellerScreenList())
                    ),
       
                const SizedBox(height: TSizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirm Logout"),
                            content: Text("Are you sure you want to logout?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close the dialog
                                },
                                child: Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  AuthenticationRepository.instance.logOut();
                                  Navigator.pop(context); // Close the dialog
                                },
                                child: Text("Logout"),
                              ),
                            ],
                          );
                        },
                      );
                    }, 
                    child: const Text("Logout")
                  )
              
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
