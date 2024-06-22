import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:online_nursery_plant_shop/common/appbar.dart';
import 'package:online_nursery_plant_shop/features/authentication/screens/seller_screen/seller_controller.dart';
import 'package:online_nursery_plant_shop/utils/constants/sizes.dart';
import 'package:online_nursery_plant_shop/utils/constants/text_strings.dart';
import 'package:online_nursery_plant_shop/utils/validators/validation.dart';

class SellerScreen extends StatelessWidget {
  const SellerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UploadController uploadController = Get.put(UploadController());

    return Scaffold(
      appBar: const TAppBar(
        title: Text('Become a Seller'),
        showbackarrow: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ 
              const Text(
                'Become Seller on our platform',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.normal
                ),
              ),
              SizedBox(height: TSizes.spaceBtwItems), // Adjust height as needed
             const Text.rich(
  TextSpan(
    text: 'Join our app as a seller and tap into a thriving community of plant enthusiasts. Showcase your botanical offerings and earn lucrative rewards with each sale.   ',
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    children: <TextSpan>[
      TextSpan(
        text: 'To Become a partner, contact us on onlinenursery2024@gmail.com and grab your tokenKey Today!',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blue, // Change color to highlight
        ),
      ),
    ],
  ),
),

                            SizedBox(height: TSizes.spaceBtwItems), // Adjust height as needed
                            Text('Fill in the details below to get started:'),
                            SizedBox(height: TSizes.spaceBtwItems), // Adjust height as needed

              Form(
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: uploadController.tokenKey,
                        validator: (value) => TValidator.validateEmptyText(
                          'Seller Token Key',
                          value,
                        ),
                        expands: false,
                        decoration: const InputDecoration(
                          labelText: 'Seller Token Key',
                          prefixIcon: Icon(Iconsax.user),
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      TextFormField(
                        controller: uploadController.productName,
                        validator: (value) => TValidator.validateEmptyText(
                          'Product Name',
                          value,
                        ),
                        expands: false,
                        decoration: const InputDecoration(
                          labelText: TTexts.productName,
                          prefixIcon: Icon(Iconsax.user),
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      TextFormField(
                        controller: uploadController.productDescription,
                        validator: (value) => TValidator.validateEmptyText(
                          'Product Description',
                          value,
                        ),
                        expands: false,
                        decoration: const InputDecoration(
                          labelText: TTexts.productDescription,
                          prefixIcon: Icon(Iconsax.user),
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      TextFormField(
                        controller: uploadController.productPrice,
                        validator: (value) => TValidator.validateEmptyText(
                          'Product Price',
                          value,
                        ),
                        expands: false,
                        decoration: const InputDecoration(
                          labelText: TTexts.productPrice,
                          prefixIcon: Icon(Iconsax.user),
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      TextFormField(
                        controller: uploadController.discount,
                        validator: (value) => TValidator.validateEmptyText(
                          'Discount Price',
                          value,
                        ),
                        expands: false,
                        decoration: const InputDecoration(
                          labelText: 'Discount Price',
                          prefixIcon: Icon(Iconsax.user),
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      TextFormField(
                        controller: uploadController.productQuantity,
                        validator: (value) => TValidator.validateEmptyText(
                          'Product Quantity',
                          value,
                        ),
                        expands: false,
                        decoration: const InputDecoration(
                          labelText: TTexts.productQuantity,
                          prefixIcon: Icon(Iconsax.user),
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      DropdownButtonFormField(
                        hint: const Text('Select Category'),
                        value: uploadController.dropdownValue.value,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.sort),
                        ),
                        onChanged: (value) {
                          uploadController.updateDropdownValue(
                            value.toString(),
                          ); // Update dropdown value
                        },
                        items: [
                          'Plants',
                          'Seeds',
                          'pots',
                          'Fertilizers',
                          'Tools'
                        ].map((option) {
                          return DropdownMenuItem(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      Obx(() {
                        return Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(
                                  8), // Adjust padding as needed
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors
                                      .black, // Adjust border color as needed
                                  width: 1, // Adjust border width as needed
                                ),
                              ),
                              child: uploadController.imageFile.value == null
                                  ? const Text('No Product image selected.')
                                  : Image.file(
                                      uploadController.imageFile.value!,
                                    ),
                            ),
                            if (uploadController.imageFile.value != null)
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    uploadController
                                        .removeImage(); // Function to remove the selected image
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(1),
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 255, 2, 2),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      }),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      Obx(() {
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: uploadController.selectImage,
                            child: Text(
                              uploadController.imageFile.value != null
                                  ? 'Change Image'
                                  : 'Select Image',
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () async {
                            // Pass the user ID to submitData function
                            String? userId =
                                FirebaseAuth.instance.currentUser?.uid;
                            if (userId != null) {
                              // Pass the user ID to submitData function
                              await uploadController.submitData(userId);
                            } else {
                              print('User not logged in.');
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              // Text form fields for inputting data
            ],
          ),
        ),
      ),
    );
  }
}
