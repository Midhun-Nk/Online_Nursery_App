import 'package:flutter/material.dart';
import 'package:online_nursery_plant_shop/common/appbar.dart';
import 'package:online_nursery_plant_shop/common/sortable.dart';
import 'package:online_nursery_plant_shop/utils/constants/sizes.dart';

class AllProduct extends StatelessWidget {
  const AllProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      appBar: TAppBar(
        showbackarrow: true,
        title: Text(
          'Popular Product',
        ),
      ),
      body: SingleChildScrollView(

        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
        child: TSortableProducts(),),
      ),
    );
  }
}
