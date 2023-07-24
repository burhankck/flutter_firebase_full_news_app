// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import '../utility/base/base_firebase_model.dart';



class News extends Equatable with IdModel, BaseFirebaseModel <News> {
final  String? category;
 final String? categoryID;
 final String? title;
final  String? backgroundImage;
@override
  final  String? id;

  News({
    this.category,
    this.categoryID,
    this.title,
    this.backgroundImage,
    this.id,
  });

  @override
  List<Object?> get props => [category, categoryID, title, backgroundImage, id];

  News copyWith({
    String? category,
    String? categoryID,
    String? title,
    String? backgroundImage,
    String? id,
  }) {
    return News(
      category: category ?? this.category,
      categoryID: categoryID ?? this.categoryID,
      title: title ?? this.title,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'categoryID': categoryID,
      'title': title,
      'backgroundImage': backgroundImage,
      'id': id,
    };
  }

  @override
  News fromJson(Map<String, dynamic> json) {
   return News(
      category: json['category'] as String?,
      categoryID: json['categoryID'] as String?,
      title: json['title'] as String?,
      backgroundImage: json['backgroundImage'] as String?,
      id: json['id'] as String?,
    );
  }
}
