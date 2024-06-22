import 'package:flutter/material.dart';
import 'package:online_nursery_plant_shop/common/appbar.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/order/widgets/order_list_items.dart';
import 'package:online_nursery_plant_shop/utils/constants/sizes.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showbackarrow: true,
        title: Text(
          'My Order',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: const Padding(padding: 
      EdgeInsets.all(TSizes.defaultSpace),
      child: TOrderListItems(), )
    );
  }
}