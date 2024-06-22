import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:online_nursery_plant_shop/common/network_manager.dart';
import 'package:online_nursery_plant_shop/common/warning_snackbar.dart';
import 'package:online_nursery_plant_shop/utils/constants/image_strings.dart';
import 'package:online_nursery_plant_shop/utils/popups/full_screen_loader.dart';

class ProductUploader {
  final String productName;
  final String productDescription;
  final int productPrice;
  final int productQuantity; // Changed to int
  final String dropdownValue; // New field for the dropdown value
  final File? imageFile;
  final String userName; // New field to store the seller's email
  final String userId;
  final String phoneNumber;
  final int discount;
  final String tokenKey;
  final String emailId;


  ProductUploader({
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productQuantity,
    required this.dropdownValue,
    required this.imageFile,
    required this.userName,
    required this.userId,
    required this.discount,
    required this.phoneNumber,
    required this.tokenKey,
    required this.emailId

  });
// Function to generate a random 8-character alphanumeric key
String generateRandomProductId() {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final random = Random();
  return String.fromCharCodes(Iterable.generate(8, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
}
  Future<void> uploadData() async {
    try {
      TFullScreenLoader.openLoadingDialog(
        'Processing', TImages.processingAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (productName.isEmpty || productDescription.isEmpty || productPrice.toString().isEmpty || productQuantity.toString().isEmpty || dropdownValue.isEmpty || imageFile == null) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(title: 'Oh Snap!', message: 'Please fill all the fields and select an image');
        return;
      }

    if ((productPrice) <= 0 || productQuantity <= 0) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(title: 'Oh Snap!', message: 'Price and Quantity must be greater than 0');
        return;
      }

     if (discount < 0 || discount > 100) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(title: 'Oh Snap!', message: 'Discount must be between 0 and 100');
        return;
      }


      if (dropdownValue.isEmpty) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(title: 'Oh Snap!', message: 'Please select a category');
        return;
      }

      if (imageFile == null) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(title: 'Oh Snap!', message: 'Please select an image');
        return;
      }

      if (userName.isEmpty) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(title: 'Oh Snap!', message: 'Seller email is missing');
        return;
      }
      
    final productId = generateRandomProductId();


      final imageUrl = await _uploadImageToFirebase();
      if (imageUrl != null && tokenKey == 'tokenkey') {
        // Save imageUrl along with other data from input fields and dropdown value
        print('productName: $productName');
        print('productDescription: $productDescription');
        print('productPrice: $productPrice');
        print('Dropdown Value: $dropdownValue');
        print('Image URL: $imageUrl');
        print('Seller Email: $userName'); // Log the seller's email
        print('User ID: $userId'); // Log the user ID

        // Now, store the data (including the image URL and dropdown value) into Firestore
        try {
          await FirebaseFirestore.instance.collection('Products').doc(productId).set({
            'ProductName': productName,
            'ProductDescription': productDescription,
            'ProductPrice': productPrice,
            'ProductQuantity': productQuantity,
            'Dropdown_Value': dropdownValue, // Store the dropdown value
            'Image_Url': imageUrl,
            'UserName': userName, // Include the seller's email
            'UserId': userId,
            'productId' : productId,
            'Discount': discount,
            'PhoneNumber': phoneNumber,
            'EmailId': emailId
            // Other fields if needed
          });
          TFullScreenLoader.stopLoading();
          print('Data stored in Firestore successfully!');
          TLoaders.sucessSnackBar(title: 'Uploaded Successfully!', message: 'Your item is now available for sale');
        } catch (e) {
          print('Error storing data in Firestore: $e');
          TFullScreenLoader.stopLoading();
          TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
        }
      } else {
        // Handle case when image upload fails
        print('Image upload failed.');
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(title: 'Oh Snap! Your Not a Verified Seller', message: 'Invalid token key');
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap !', message: e.toString());
      print('Error uploading data: $e');
    }
  }

  Future<String?> _uploadImageToFirebase() async {
    try {
      if (imageFile == null) return null;

      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('Productimages/${DateTime.now().millisecondsSinceEpoch}.jpg');

      firebase_storage.UploadTask task = ref.putFile(imageFile!);

      await task;
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}

class UploadController {
  final TextEditingController productName = TextEditingController();
  final TextEditingController productDescription = TextEditingController();
  final TextEditingController productPrice = TextEditingController();
  final TextEditingController productQuantity = TextEditingController();
    final TextEditingController discount = TextEditingController();
        final TextEditingController tokenKey = TextEditingController();

    

  
  Rx<File?> imageFile = Rx<File?>(null);
  Rx<String?> dropdownValue = Rx<String?>(null); // Rx variable to hold dropdown value

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? getCurrentUserID() {
    final userID = FirebaseAuth.instance.currentUser;
    if (userID != null) {
      return userID.uid;
    } else {
      print('userID is not signed in.');
      return null;
    }
  }

  Future<String?> getuserName(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await _firestore.collection('Users').doc(userId).get();
      if (userDoc.exists) {
        // Retrieve seller email from user document
        return userDoc.data()?['UserName'] ;
      } else {
        print('Document with ID $userId does not exist.');
        
        return null;
      }
    } catch (e) {
      print('Error retrieving seller email: $e');
            TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());

      return null;
    }
  }
  
  Future<String?> getPhoneNumber(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await _firestore.collection('Users').doc(userId).get();
      if (userDoc.exists) {
        // Retrieve seller email from user document
        return userDoc.data()?['PhoneNumber'] ;
      } else {
        print('Document with ID $userId does not exist.');
        
        return null;
      }
    } catch (e) {
      print('Error retrieving seller email: $e');
            TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());

      return null;
    }
  }
  
  Future<String?> getEmailAdress(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await _firestore.collection('Users').doc(userId).get();
      if (userDoc.exists) {
        // Retrieve seller email from user document
        return userDoc.data()?['Email'] ;
      } else {
        print('Document with ID $userId does not exist.');
        
        return null;
      }
    } catch (e) {
      print('Error retrieving seller email: $e');
            TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());

      return null;
    }
  }


  Future<void> selectImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        imageFile.value = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error selecting image: $e');
            TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());

    }
  }

  void removeImage() {
    imageFile.value = null; // Set the image file value to null to remove the selected image
  }

  // Function to update dropdown value
  void updateDropdownValue(String value) {
    dropdownValue.value = value;
  }

  Future<void> submitData(String userId) async {
    try {

 

            final String  userId = getCurrentUserID() ?? '';

      // Fetch the seller's email using the SellerController
      String? userName = await getuserName(userId);
      String phoneNumber = await getPhoneNumber(userId) ?? '';
      String emailId = await getEmailAdress(userId) ?? '';

      if (userName != null) {
        final uploader = ProductUploader(
          tokenKey: tokenKey.text,
          discount: int.parse(discount.text),
          productName: productName.text,
          productDescription: productDescription.text,
          productPrice: int.parse(productPrice.text),
          productQuantity: int.parse(productQuantity.text),
          dropdownValue: dropdownValue.value ?? '', // Pass dropdown value
          imageFile: imageFile.value,
          userName: userName,
          userId: userId ,// Pass the seller's email
          phoneNumber: phoneNumber,
          emailId: emailId
        );

        await uploader.uploadData();
        resetValues();
      } else {
        print('Failed to fetch seller email.');
      }
    } catch (e) {
      print('Error submitting data: $e');

    }
  }

  void resetValues() {
    productName.clear();
    discount.clear();
    productDescription.clear();
    productPrice.clear();
    productQuantity.clear();
    dropdownValue.value = null;
    imageFile.value = null;
  }
}
