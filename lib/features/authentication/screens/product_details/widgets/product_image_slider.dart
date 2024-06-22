
import 'package:flutter/material.dart';
import 'package:online_nursery_plant_shop/common/appbar.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/homescreens/widget/homewidget.dart';
import 'package:online_nursery_plant_shop/utils/constants/colors.dart';
import 'package:online_nursery_plant_shop/utils/constants/sizes.dart';
import 'package:online_nursery_plant_shop/utils/helpers/helper_functions.dart';

class TImageProductSlider extends StatelessWidget {
  const TImageProductSlider({
    super.key, required this.imageUrl,
    
  });

final String imageUrl;

  @override
  Widget build(BuildContext context) {
        final dark = THelperFunctions.isDarkMode(context);

    return TCurvedEdgeWidget(
      child: Container(
        color: dark ? TColors.darkerGrey : TColors.light,
        child: Stack(
          children: [
             SizedBox(
                height: 400,
                child: Padding( 
                  padding:
                     const EdgeInsets.all(TSizes.productImageRadius * 2),
                  child: Center(
                      child: Image(
                          image: NetworkImage(imageUrl))),
                )),
           
    
             const TAppBar(
              showbackarrow: true,
             
       
      )
          ]          
          
        ),
      ),
    );
  }
}

