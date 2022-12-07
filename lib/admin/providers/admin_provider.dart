import 'dart:io';

import 'package:firebase_app/admin/models/category.dart';
import 'package:firebase_app/app_router/app_router.dart';
import 'package:firebase_app/data_repositories/firestore_helper.dart';
import 'package:firebase_app/data_repositories/storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminProvider extends ChangeNotifier {
  AdminProvider() {
    getAllCategories();
  }
  String? requiredValidation(String? content) {
    if (content == null || content.isEmpty) {
      return "Required field";
    }
  }

  // add new category
  File? imageFile;
  TextEditingController catNameArController = TextEditingController();
  TextEditingController catNameEnController = TextEditingController();
  GlobalKey<FormState> categoryFormKey = GlobalKey<FormState>();
  pickImageForCategory() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  addNewCategory() async {
    if (imageFile != null) {
      if (categoryFormKey.currentState!.validate()) {
        // add category process
        AppRouter.appRouter.showLoadingDialoug();
        String imageUrl = await StorageHelper.storageHelper
            .uploadNewImage("cats_images", imageFile!);
        Category category = Category(
            imageUrl: imageUrl,
            nameAr: catNameArController.text,
            nameEn: catNameEnController.text);

        String? id =
            await FirestoreHelper.firestoreHelper.addNewCategory(category);

        AppRouter.appRouter.hideDialoug();
        if (id != null) {
          category.id = id;
          allCategories!.add(category);
          notifyListeners();
          catNameArController.clear();
          catNameEnController.clear();
          imageFile = null;
          notifyListeners();
          AppRouter.appRouter
              .showCustomDialoug('Success', 'Your category has been added');
        }
      }
    } else {
      AppRouter.appRouter
          .showCustomDialoug('Error', 'You have to pick image first');
    }
  }

  // get cateogies
  List<Category>? allCategories;
  getAllCategories() async {
    allCategories = await FirestoreHelper.firestoreHelper.getAllCategories();
    notifyListeners();
  }

  // delete category
  deleteCategory(String id) async {
    bool deleteSuccess =
        await FirestoreHelper.firestoreHelper.deleteCategoey(id);
  }
  // update category
//   updateCategory()async{
//     FirestoreHelper.firestoreHelper.updateCategory(category)
//   }
}
