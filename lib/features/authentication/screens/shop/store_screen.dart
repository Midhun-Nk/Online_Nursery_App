import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_nursery_plant_shop/common/appbar.dart';
import 'package:online_nursery_plant_shop/common/tabbar.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/homescreens/widget/home_appbar.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/homescreens/widget/search_screen.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/shop/widget/tcategory_tab.dart';
import 'package:online_nursery_plant_shop/utils/constants/colors.dart';
import 'package:online_nursery_plant_shop/utils/constants/sizes.dart';
import 'package:online_nursery_plant_shop/utils/helpers/helper_functions.dart';
import 'package:online_nursery_plant_shop/widget/searchbar.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            "Store",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [TCardCounterWidget(onPressed: () {})],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: THelperFunctions.isDarkMode(context)
                    ? TColors.black
                    : TColors.white,
                expandedHeight: 200,
                flexibleSpace: Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                           TSearchContainer(
                            text: "Search in Store",
                            onTap: () => Get.to(() => const SearchScreen()),
                            showBackground: false,
                            showBorder: true,
                            padding: EdgeInsets.zero,
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwSections,
                          ),
                    
                        ])),
                        bottom:const TTabBar(tabs: [
                          
                          Tab(
                            child: Text("Plants"),
                          ),
                          Tab(
                            child: Text("Seeds"),
                          ),
                          Tab(
                            child: Text("pots"),
                          ),
                          Tab(
                            child: Text("Fertilizers"),
                          ),
                          Tab(
                            child: Text("Accessories"),
                          ),
                        ])
              )
            ];
          },
          body:  const TabBarView(
            children: [
              TcategoryTab(category: 'Plants',),
              TcategoryTab(category: 'Seeds',),
              TcategoryTab( category: 'pots',),
              TcategoryTab(category: 'Fertilizers',),
              TcategoryTab(category: 'Tools',),
            ],
          ),
        ),
      ),
    );
  }
}
