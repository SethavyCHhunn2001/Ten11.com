import 'cart_item.dart';

class Order {
  final String id;
  final List<CartItem> items;
  final double total;
  final double subtotal;
  final double shipping;
  final double tax;
  final double discount;
  final String status;
  final DateTime orderDate;
  final String shippingAddress;
  final String paymentMethod;
  final String trackingNumber;

  Order({
    required this.id,
    required this.items,
    required this.total,
    required this.subtotal,
    required this.shipping,
    required this.tax,
    required this.discount,
    required this.status,
    required this.orderDate,
    required this.shippingAddress,
    required this.paymentMethod,
    required this.trackingNumber,
  });
}
