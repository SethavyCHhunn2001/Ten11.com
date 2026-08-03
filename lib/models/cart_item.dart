import 'product.dart';

class CartItem {
  final Product product;
  int quantity;
  final String selectedColor;
  final String selectedSize;

  CartItem({
    required this.product,
    required this.quantity,
    required this.selectedColor,
    required this.selectedSize,
  });

  double get totalPrice => product.price * quantity;

  Map<String, dynamic> toJson() => {
        'product': product.toJson(),
        'quantity': quantity,
        'selectedColor': selectedColor,
        'selectedSize': selectedSize,
      };

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        product: Product.fromJson(json['product']),
        quantity: json['quantity'],
        selectedColor: json['selectedColor'],
        selectedSize: json['selectedSize'],
      );

  CartItem copyWith({
    Product? product,
    int? quantity,
    String? selectedColor,
    String? selectedSize,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedSize: selectedSize ?? this.selectedSize,
    );
  }
}
