import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:online_nursery_plant_shop/common/appbar.dart';
import 'package:online_nursery_plant_shop/common/productcartvertical.dart';
import 'package:online_nursery_plant_shop/common/shapes/TGrid_Layout.dart';
import 'package:online_nursery_plant_shop/common/shapes/t_circular_icon.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/homescreens/homescreen.dart';
import 'package:online_nursery_plant_shop/utils/constants/sizes.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          TCircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to( const HomeScreen()),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
       child: Column(
        children: [
          TGridLayout(itemCount: 6, itemBuilder:  (_,index)=> const TProductCartVertical()),
        ],
       ),
       
        ),
      ),
    );
  }
}
