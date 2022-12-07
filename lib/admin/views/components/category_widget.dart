import 'package:firebase_app/admin/models/category.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  Category category;
  CategoryWidget(this.category);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black, width: 2)),
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                  width: double.infinity,
                  height: 170,
                  child: Image.network(
                    category.imageUrl,
                    fit: BoxFit.cover,
                  )),
              Positioned(
                  right: 15,
                  top: 10,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: IconButton(
                            onPressed: () {}, icon: Icon(Icons.delete)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: IconButton(
                            onPressed: () {}, icon: Icon(Icons.edit)),
                      ),
                    ],
                  ))
            ],
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Arabic Category' + ': ' + category.nameAr,
                  ),
                  Text(
                    'English Category' + ': ' + category.nameEn,
                  ),
                ]),
          )
        ],
      ),
    );
  }
}
