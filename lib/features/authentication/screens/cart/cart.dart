import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_nursery_plant_shop/common/appbar.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/cart/widgets/checkout.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/cart/widgets/tcard_items.dart';
import 'package:online_nursery_plant_shop/utils/constants/sizes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: TAppBar(
        showbackarrow: true,
        title: Text(
          'OrderList',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body:const Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: TCardItems( ),
      ),

     
    );
  }
}
