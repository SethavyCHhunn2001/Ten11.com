class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double originalPrice;
  final String category;
  final String subCategory;
  final String imageUrl;
  final List<String> colors;
  final List<String> sizes;
  final String material;
  final String careInstructions;
  final double rating;
  final int reviews;
  final bool isNew;
  final bool isBestSeller;
  final bool isOnSale;
  final int discountPercentage;
  final String tag;
  final DateTime createdAt;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.originalPrice = 0.0,
    required this.category,
    required this.subCategory,
    required this.imageUrl,
    required this.colors,
    required this.sizes,
    required this.material,
    required this.careInstructions,
    this.rating = 4.5,
    this.reviews = 0,
    this.isNew = false,
    this.isBestSeller = false,
    this.isOnSale = false,
    this.discountPercentage = 0,
    required this.tag,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'originalPrice': originalPrice,
        'category': category,
        'subCategory': subCategory,
        'imageUrl': imageUrl,
        'colors': colors,
        'sizes': sizes,
        'material': material,
        'careInstructions': careInstructions,
        'rating': rating,
        'reviews': reviews,
        'isNew': isNew,
        'isBestSeller': isBestSeller,
        'isOnSale': isOnSale,
        'discountPercentage': discountPercentage,
        'tag': tag,
        'createdAt': createdAt.toIso8601String(),
      };

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        price: (json['price'] as num).toDouble(),
        originalPrice: ((json['originalPrice'] ?? 0.0) as num).toDouble(),
        category: json['category'],
        subCategory: json['subCategory'],
        imageUrl: json['imageUrl'],
        colors: List<String>.from(json['colors']),
        sizes: List<String>.from(json['sizes']),
        material: json['material'],
        careInstructions: json['careInstructions'],
        rating: ((json['rating'] ?? 4.5) as num).toDouble(),
        reviews: json['reviews'] ?? 0,
        isNew: json['isNew'] ?? false,
        isBestSeller: json['isBestSeller'] ?? false,
        isOnSale: json['isOnSale'] ?? false,
        discountPercentage: json['discountPercentage'] ?? 0,
        tag: json['tag'],
        createdAt: DateTime.parse(json['createdAt']),
      );

  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    double? originalPrice,
    String? category,
    String? subCategory,
    String? imageUrl,
    List<String>? colors,
    List<String>? sizes,
    String? material,
    String? careInstructions,
    double? rating,
    int? reviews,
    bool? isNew,
    bool? isBestSeller,
    bool? isOnSale,
    int? discountPercentage,
    String? tag,
    DateTime? createdAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      imageUrl: imageUrl ?? this.imageUrl,
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
      material: material ?? this.material,
      careInstructions: careInstructions ?? this.careInstructions,
      rating: rating ?? this.rating,
      reviews: reviews ?? this.reviews,
      isNew: isNew ?? this.isNew,
      isBestSeller: isBestSeller ?? this.isBestSeller,
      isOnSale: isOnSale ?? this.isOnSale,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      tag: tag ?? this.tag,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
