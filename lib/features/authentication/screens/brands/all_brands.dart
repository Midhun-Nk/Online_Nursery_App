import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_nursery_plant_shop/common/appbar.dart';
import 'package:online_nursery_plant_shop/common/shapes/TGrid_Layout.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/brands/brands_product.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/homescreens/widget/homewidget.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/shop/widget/brandshowcase.dart';
import 'package:online_nursery_plant_shop/utils/constants/sizes.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const TAppBar(
        title: Text('All Brands'),
        showbackarrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(padding: 
       const EdgeInsets.all(TSizes.defaultSpace)
       , child: Column(
          children: [
const TSectionHeading(title: 'Brands',showActionButton: false,),
const SizedBox( height: TSizes.spaceBtwItems,),

 TGridLayout(
  mainAxisExtent: 80,
  itemCount: 10, itemBuilder: ( _,index)=> TBrandCard(showBorder: true,onTap: () =>  Get.to(()=> const BrandsProducts())))
          ],
        ),),
      ),
    );
  }
}