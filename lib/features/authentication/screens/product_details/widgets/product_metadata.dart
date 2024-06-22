import 'package:flutter/material.dart';
import 'package:online_nursery_plant_shop/common/productcartvertical.dart';
import 'package:online_nursery_plant_shop/common/style/product_price.dart';
import 'package:online_nursery_plant_shop/common/style/product_title_text.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/homescreens/widget/homewidget.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/shop/widget/brandshowcase.dart';
import 'package:online_nursery_plant_shop/utils/constants/colors.dart';
import 'package:online_nursery_plant_shop/utils/constants/enums.dart';
import 'package:online_nursery_plant_shop/utils/constants/image_strings.dart';
import 'package:online_nursery_plant_shop/utils/constants/sizes.dart';
import 'package:online_nursery_plant_shop/utils/helpers/helper_functions.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TRoundedContainer(
              radius: TSizes.sm,
              backgroundColor: TColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.sm, vertical: TSizes.sm),
              child: Text("25%",
                  style: Theme.of(context).textTheme.labelLarge!.apply(
                        color: TColors.black,
                      )),
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Text("₹400",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .apply(decoration: TextDecoration.lineThrough)),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            const TProductPRice(
              price: 987,
              islarge: true,
            )
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 1.5,
        ),
        const TProductTitleText(title: 'Green Nike Sports Shirt'),
        const SizedBox(
          height: TSizes.spaceBtwItems / 1.5,
        ),

            const SizedBox(
          height: TSizes.spaceBtwItems / 1.5,
        ),
       
        Row(children: [
           const TProductTitleText(title: 'Status'),
const SizedBox(
          width: TSizes.spaceBtwItems / 1.5,
        ),

          Text("In Stock",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 1.5,
        ),],),
        const SizedBox(
          height: TSizes.spaceBtwItems / 1.5,
        ),
        Row(
          children: [
            TCircularImage(image: TImages.user,
            width: 32,
            height: 32,
            overlayColor: dark?  TColors.white: TColors.black,
            ),
            const TBRandTitleWithVerificationICon(title: "Mike",brandTextSize: TextSizes.medium,),
          ],
        )
      ],
    );
  }
}
