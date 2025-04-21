import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final String description;
  final num price;
  final num discountPercentage;
  final num rating;
  final num stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int? ?? 0, // Provide default if null
      title: json['title'] as String? ?? '', // Provide default if null
      description:
          json['description'] as String? ?? '', // Provide default if null
      price: json['price'] as num? ?? 0, // Provide default if null
      discountPercentage:
          json['discountPercentage'] as num? ?? 0.0, // Provide default if null
      rating:
          (json['rating'] as num?)?.toDouble() ??
          0.0, // Provide default if null
      stock: json['stock'] as num? ?? 0, // Provide default if null
      brand: json['brand'] as String? ?? '', // Provide default if null
      category: json['category'] as String? ?? '', // Provide default if null
      thumbnail: json['thumbnail'] as String? ?? '', // Provide default if null
      images:
          (json['images'] as List<dynamic>?)?.cast<String>() ??
          [], // Provide default if null
    );
  }

  @override
  List<Object?> get props => [id, title, price];
}
