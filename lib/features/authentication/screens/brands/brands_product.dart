import 'package:flutter/material.dart';
import 'package:online_nursery_plant_shop/common/appbar.dart';
import 'package:online_nursery_plant_shop/common/sortable.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/shop/widget/brandshowcase.dart';
import 'package:online_nursery_plant_shop/utils/constants/sizes.dart';

class BrandsProducts extends StatelessWidget {
  const BrandsProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TAppBar(
        title: Text('Brands Product'),
        showbackarrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            TBrandCard(showBorder: true),
            SizedBox(height: TSizes.spaceBtwSections,),
            TSortableProducts(),
          ],
        ),),
      ),
    );
  }
}