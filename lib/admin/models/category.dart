import 'dart:convert';

class Category {
  String? id;
  String imageUrl;
  String nameAr;
  String nameEn;
  Category(
      {required this.imageUrl,
      required this.nameAr,
      required this.nameEn,
      this.id});

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'nameAr': nameAr,
      'nameEn': nameEn,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
        imageUrl: map['imageUrl'] ?? '',
        nameAr: map['nameAr'] ?? '',
        nameEn: map['nameEn'] ?? '',
        id: map['id'] ?? ' ');
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));
}
