import 'package:flutter/material.dart';
import '../data/product_data.dart';
import '../models/cart_item.dart';
import '../widgets/safe_network_image.dart';
import '../widgets/app_back_button.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItem> _cartItems = [];
  double get _subtotal => _cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  double get _shipping => _subtotal >= 35 ? 0 : 5.99;
  double get _tax => _subtotal * 0.08;
  double get _total => _subtotal + _shipping + _tax;

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  void _loadCartItems() {
    if (ProductData.products.length > 2) {
      _cartItems = [
        CartItem(
          product: ProductData.products[0],
          quantity: 1,
          selectedColor: ProductData.products[0].colors.first,
          selectedSize: ProductData.products[0].sizes.first,
        ),
        CartItem(
          product: ProductData.products[2],
          quantity: 2,
          selectedColor: ProductData.products[2].colors.first,
          selectedSize: ProductData.products[2].sizes.first,
        ),
      ];
    }
  }

  void _updateQuantity(int index, int newQuantity) {
    setState(() {
      if (newQuantity <= 0) {
        _cartItems.removeAt(index);
      } else {
        _cartItems[index].quantity = newQuantity;
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Item removed from cart'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_cartItems.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          leading: const AppBackButton(),
          title: const Text('Shopping Cart'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_bag_outlined,
                size: 80,
                color: Colors.grey.shade400,
              ),
              const SizedBox(height: 16),
              const Text(
                'Your cart is empty',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Browse our collection and add items you love',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Start Shopping'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text('Shopping Cart (${_cartItems.length})'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _cartItems.clear();
              });
            },
            child: Text(
              'Clear All',
              style: TextStyle(
                color: Colors.red.shade400,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Free shipping banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: _subtotal >= 35 ? Colors.green.shade50 : Colors.amber.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _subtotal >= 35 ? Icons.check_circle : Icons.local_shipping,
                  color: _subtotal >= 35 ? Colors.green : Colors.amber,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    _subtotal >= 35
                        ? 'You qualify for FREE shipping! 🎉'
                        : 'Add \$${(35 - _subtotal).toStringAsFixed(2)} more for FREE shipping',
                    style: TextStyle(
                      color: _subtotal >= 35 ? Colors.green.shade700 : Colors.amber.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Cart Items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                final item = _cartItems[index];
                final product = item.product;
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 80,
                          height: 100,
                          child: SafeNetworkImage(
                            url: product.imageUrl,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${item.selectedColor} / ${item.selectedSize}',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '\$${product.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFE91E63),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.remove, size: 16),
                                          onPressed: () {
                                            _updateQuantity(index, item.quantity - 1);
                                          },
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(
                                            minWidth: 28,
                                            minHeight: 28,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 30,
                                          child: Center(
                                            child: Text(
                                              '${item.quantity}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.add, size: 16),
                                          onPressed: () {
                                            _updateQuantity(index, item.quantity + 1);
                                          },
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(
                                            minWidth: 28,
                                            minHeight: 28,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete_outline,
                                      color: Colors.red.shade400,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      _removeItem(index);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Order Summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildSummaryRow('Subtotal', '\$${_subtotal.toStringAsFixed(2)}'),
                _buildSummaryRow(
                  'Shipping',
                  _shipping == 0 ? 'FREE' : '\$${_shipping.toStringAsFixed(2)}',
                  _shipping == 0 ? Colors.green : null,
                ),
                _buildSummaryRow('Tax', '\$${_tax.toStringAsFixed(2)}'),
                const Divider(height: 16),
                _buildSummaryRow(
                  'Total',
                  '\$${_total.toStringAsFixed(2)}',
                  null,
                  true,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Proceeding to checkout...'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE91E63),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Proceed to Checkout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, [Color? valueColor, bool isTotal = false]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isTotal ? Colors.black : Colors.grey.shade600,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? (isTotal ? Colors.black : Colors.grey.shade800),
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 18 : 14,
            ),
          ),
        ],
      ),
    );
  }
}
