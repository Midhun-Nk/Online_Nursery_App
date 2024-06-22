import 'package:flutter/material.dart';
import 'package:online_nursery_plant_shop/common/appbar.dart';
import 'package:online_nursery_plant_shop/common/horizontal_product_card.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/homescreens/widget/homewidget.dart';
import 'package:online_nursery_plant_shop/utils/constants/image_strings.dart';
import 'package:online_nursery_plant_shop/utils/constants/sizes.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const TAppBar(
        showbackarrow: true,
        title: Text(
          'Sub Category',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              const TRoundedImage(
                imageUrl: TImages.promoBanner3,
                applyImageRadius: true,
                width: double.infinity,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              Column(
                children: [
                  TSectionHeading(title: 'Sports Mike',onPressed: (){},),
                  const SizedBox(
                    height: TSizes.spaceBtwItems /2,
                  ),
                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      separatorBuilder: (context
                      
                      ,index)=> const SizedBox(width: TSizes.spaceBtwItems),
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      itemBuilder:(context,index)=> const ProductCarty()),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
