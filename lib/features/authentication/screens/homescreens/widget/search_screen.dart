import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:online_nursery_plant_shop/common/appbar.dart';
import 'package:online_nursery_plant_shop/common/productcardvertical_controller.dart';
import 'package:online_nursery_plant_shop/common/productcartvertical.dart';
import 'package:online_nursery_plant_shop/common/shadow.dart';
import 'package:online_nursery_plant_shop/common/shapes/TGrid_Layout.dart';
import 'package:online_nursery_plant_shop/common/shimmer_effect.dart';
import 'package:online_nursery_plant_shop/common/style/product_price.dart';
import 'package:online_nursery_plant_shop/common/style/product_title_text.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/homescreens/widget/addtocart.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/homescreens/widget/homewidget.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/homescreens/widget/search_controll.dart';
import 'package:online_nursery_plant_shop/utils/constants/colors.dart';
import 'package:online_nursery_plant_shop/utils/constants/enums.dart';
import 'package:online_nursery_plant_shop/utils/constants/sizes.dart';
import 'package:online_nursery_plant_shop/utils/helpers/helper_functions.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(SearchControll());

    // Store the original unfiltered data
    final List<Map<String, dynamic>> originalData = List.from(controller.productDataList);

    void searchProduct(String query) {
      if (query.isEmpty) {
        // If the search query is empty, reset the product list to its original state
        controller.searchProduct('');
      } else {
        controller.searchProduct(query);
      }
    }

    // Function to clear the filter and reset the product list
    void clearFilter() {
      controller.clearFilter();
    }

    return Scaffold(
      appBar: TAppBar(
        showbackarrow: true,
        title: Text('Search in Store'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            TextField(
              onChanged: searchProduct,
              decoration: InputDecoration(
                labelText: 'Search Here',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: TSizes.defaultSpace),
            Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: TshimmerEffect(
                    height: 180,
                    width: 180,
                  ),
                );
              } else {
                return TGridLayout(
                  itemCount: controller.filteredProductDataList.length,
                  itemBuilder: (_, index) => GestureDetector(
                    onTap: () => Get.to(() => Addtocart(
                      sellerId: controller.filteredProductDataList[index]['userId'],
                      productId: controller.filteredProductDataList[index]['productId'],
                      image: controller.filteredProductDataList[index]['productImage'],
                      productPrice: controller.filteredProductDataList[index]['productPrice'],
                      productName: controller.filteredProductDataList[index]['productName'],
                      sellerName: controller.filteredProductDataList[index]['userName'],
                      productCategory: controller.filteredProductDataList[index]['productCategory'],
                      productDescription: controller.filteredProductDataList[index]['productDescription'],
                      productQuantity: controller.filteredProductDataList[index]['productQuantity'],
                      discount: controller.filteredProductDataList[index]['discount'],
                    )),
                    child: _buildProductItem(controller.filteredProductDataList[index], dark, context),
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(Map<String, dynamic> productData, bool dark, BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        boxShadow: [TshadowStyle.verticalProductShadow],
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        color: dark ? TColors.darkerGrey : TColors.white,
      ),
      child: Column(
        children: [
          TRoundedContainer(
            height: 180,
            padding: const EdgeInsets.all(TSizes.sm),
            backgroundColor: dark ? TColors.dark : TColors.light,
            child: Stack(
              children: [
                // TRoundedImage and Positioned widgets...
                TRoundedImage(
                  isNetworkImage: true,
                  imageUrl: productData['productImage'],
                  
                ),
              ],
            ),
          ),
          SizedBox(height: TSizes.spaceBtwItems / 2),
          Padding(
            padding: const EdgeInsets.only(left: TSizes.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TProductTitleText(
                  title: productData['productName'],
                  smallSize: true,
                ),
                SizedBox(height: TSizes.spaceBtwItems / 2),
                Column(
                  children: [
                    TBRandTitleWithVerificationICon(
                      title: productData['userName'],
                      brandTextSize: TextSizes.small,
                      maxLines: 1,
                    )
                  ],
                )
              ],
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: TSizes.sm),
                child: TProductPRice(
                  price: productData['productPrice'],
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(left: TSizes.sm),
                child: TProductPRice(
                  price: productData['productPrice'] - (productData['productPrice'] * productData['discount'] / 100).toInt(),
                  lineThrough: true,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: TColors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(TSizes.cardRadiusMd),
                    bottomRight: Radius.circular(TSizes.productImageRadius),
                  ),
                ),
                child: SizedBox(
                  height: TSizes.iconLg * 1.2,
                  width: TSizes.iconLg * 1.2,
                  child: Center(
                    child: Icon(
                      Iconsax.add,
                      color: TColors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
