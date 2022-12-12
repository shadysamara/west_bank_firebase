import 'dart:developer';

import 'package:firebase_app/admin/models/product.dart';
import 'package:firebase_app/admin/providers/admin_provider.dart';
import 'package:firebase_app/admin/views/components/category_widget.dart';
import 'package:firebase_app/admin/views/components/product_widget.dart';
import 'package:firebase_app/admin/views/screens/add_category.dart';
import 'package:firebase_app/app_router/app_router.dart';
import 'package:firebase_app/data_repositories/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                AppRouter.appRouter.goToWidget(AddNewCategory());
              },
              icon: Icon(Icons.add))
        ],
        title: Text('All Products'),
      ),
      body: Consumer<AdminProvider>(builder: (context, provider, w) {
        return provider.allProducts == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: provider.allProducts!.length,
                itemBuilder: (context, index) {
                  return ProductWidget(provider.allProducts![index]);
                });
      }),
    );
  }
}
