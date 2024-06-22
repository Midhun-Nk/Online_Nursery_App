
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:online_nursery_plant_shop/common/productcartvertical.dart';
import 'package:online_nursery_plant_shop/common/style/product_price.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/cart/widgets/tcard_item_controller.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/homescreens/widget/homewidget.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/order/widgets/buyercontrolller.dart';
import 'package:online_nursery_plant_shop/utils/constants/colors.dart';
import 'package:online_nursery_plant_shop/utils/constants/enums.dart';
import 'package:online_nursery_plant_shop/utils/constants/image_strings.dart';
import 'package:online_nursery_plant_shop/utils/constants/sizes.dart';
import 'package:online_nursery_plant_shop/utils/helpers/helper_functions.dart';
class SellerScreenList extends StatefulWidget {
  const SellerScreenList({
    Key? key,
    this.showAddRemoveButton = true,
  }) : super(key: key);

  final bool showAddRemoveButton;

  @override
  State<SellerScreenList> createState() => _SellerScreenListState();
}

class _SellerScreenListState extends State<SellerScreenList> {
 

  @override
  Widget build(BuildContext context) {
    
    final dark = THelperFunctions.isDarkMode(context);
    final Buyercontrolller controller = Get.put(Buyercontrolller());
    controller.fetchDataFromSubcollection();
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Obx(() {
        final dataList = controller.ordered.toList();
        print(dataList);
        return ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (_, index) =>
              const SizedBox(height: TSizes.spaceBtwSections),
          itemCount: dataList.length,
          itemBuilder: (_, index) {
           
            String orderDate = dataList[index]['orderDate'];
            List<String> dateParts = orderDate.split('/');
            int day = int.parse(dateParts[0]);
            int month = int.parse(dateParts[1]);
            int year = int.parse(dateParts[2]);
            day += 10;
            int daysInMonth = DateTime(year, month + 1, 0).day;
            if (day > daysInMonth) {
              day -= daysInMonth;
              month++;
            }
            String newOrderDate = '$day/${month.toString().padLeft(2, '0')}/$year';
      
            return Column(
              children: [
                TRoundedContainer(
                  padding: const EdgeInsets.all(TSizes.md),
                  showBorder: true,
                  backgroundColor: dark ? TColors.dark : TColors.light,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Icon(Iconsax.ship),
                          const SizedBox(width: TSizes.spaceBtwItems / 2),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Processing",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .apply(color: TColors.primary, fontSizeDelta: 1),
                                ),
                                Text(
                                  dataList[index]['orderDate'],
                                  style: Theme.of(context).textTheme.headlineSmall,
                                ),
                              ],
                            ),
                          ),
                          // IconButton(
                          //   onPressed: () {
                          //     deleteOrder(context, dataList[index]['buyerId']);
                          //   },
                          //   icon: const Icon(
                          //     Icons.cancel,
                          //     size: TSizes.iconSm,
                          //     color: Colors.red,
                          //   ),
                          // )
                        ],
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                TRoundedImage(
                                  isNetworkImage: true,
                                  imageUrl: dataList[index]['image'],
                                  width: 60,
                                  height: 60,
                                  padding: const EdgeInsets.all(TSizes.sm),
                                  backgroundColor: THelperFunctions.isDarkMode(context)
                                      ? TColors.darkerGrey
                                      : TColors.light,
                                ),
                                const SizedBox(width: TSizes.spaceBtwItems),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TBRandTitleWithVerificationICon(title: dataList[index]['sellerName']),
                                      Flexible(
                                        child: TBrandTitleText(
                                          brandTextSize: TextSizes.large,
                                          title: dataList[index]['productName'],
                                          maxLines: 1,
                                        ),
                                      ),
                                      Text.rich(TextSpan(children: [
                                        TextSpan(
                                          text: 'Quantity: ',
                                          style: Theme.of(context).textTheme.bodySmall,
                                        ),
                                        TextSpan(
                                          text: dataList[index]['selectedQuantity'].toString(),
                                          style: Theme.of(context).textTheme.bodyLarge,
                                        ),
                                        TextSpan(
                                          text: ' items ',
                                          style: Theme.of(context).textTheme.bodySmall,
                                        ),
                                      ]))
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: TSizes.spaceBtwInputFields),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(0),
                                  child: SizedBox(
                                    width: 90,
                                    child: Text(
                                      'Total Price:',
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                TProductPRice(price: dataList[index]['totalAmount']),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(Iconsax.tag),
                                const SizedBox(width: TSizes.spaceBtwItems / 2),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Sales Orders",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .apply(color: TColors.primary, fontSizeDelta: 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: TSizes.spaceBtwItems),
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(Iconsax.calendar),
                                const SizedBox(width: TSizes.spaceBtwItems / 2),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Delivery Date",
                                        style: Theme.of(context).textTheme.labelMedium,
                                      ),
                                      Text(newOrderDate, style: Theme.of(context).textTheme.titleMedium),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(
                            width: TSizes.spaceBtwItems,
                          ),
                          Text(
                            dataList[index]['buyerName'],
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            color: Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(
                            width: TSizes.spaceBtwItems,
                          ),
                          Text(
                            dataList[index]['phoneNumber'],
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_history,
                            color: Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(
                            width: TSizes.spaceBtwItems,
                          ),
                          Expanded(
                              child: Text(
                            "Address:  ${dataList[index]['street']} ,${dataList[index]['city']}, ${dataList[index]['country']}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ))
                        ],
                      ),

                    ],
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }

  void deleteOrder(BuildContext context, String documentId) async {
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        
        return AlertDialog(
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to cancel this order?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Return false if user cancels
              },
              child: Text("No"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Return true if user confirms
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
          final controller = Get.put(CartController());

      FirebaseFirestore.instance
          .collection('Orders') // Replace 'your_collection_name' with your actual collection name
          .doc(FirebaseAuth.instance.currentUser!.uid).collection('User_Orders').doc(documentId)
          .delete()
          .then((value) {
        print("Document successfully deleted!");
        // Refresh UI by updating the state of the widget
        controller.fetchDataFromSubcollection();
      }).catchError((error) {
        print("Error deleting document: $error");
      });
    }
  }
}
