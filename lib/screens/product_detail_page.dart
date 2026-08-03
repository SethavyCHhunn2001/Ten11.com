import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/safe_network_image.dart';
import '../widgets/app_back_button.dart';

class ProductDetailPage extends StatefulWidget {
  final Product? product;

  const ProductDetailPage({super.key, this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  String _selectedColor = '';
  String _selectedSize = '';
  int _quantity = 1;
  bool _isInWishlist = false;
  int _currentImageIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    if (widget.product != null) {
      _selectedColor = widget.product!.colors.first;
      _selectedSize = widget.product!.sizes.first;
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _addToCart() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Added to cart!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _toggleWishlist() {
    setState(() {
      _isInWishlist = !_isInWishlist;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isInWishlist ? 'Added to wishlist!' : 'Removed from wishlist!',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    if (product == null) {
      return const Scaffold(
        body: Center(child: Text('Product not found')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Product Details'),
        actions: [
          IconButton(
            icon: Icon(
              _isInWishlist ? Icons.favorite : Icons.favorite_border,
              color: _isInWishlist ? Colors.red : null,
            ),
            onPressed: _toggleWishlist,
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Gallery
            Container(
              height: 350,
              color: Colors.grey.shade100,
              child: Stack(
                children: [
                  PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                    children: [
                      SafeNetworkImage(url: product.imageUrl),
                      // Additional images would be here
                      Container(
                        color: Colors.pink.shade100,
                        child: const Center(
                          child: Text(
                            'View 2',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.blue.shade100,
                        child: const Center(
                          child: Text(
                            'View 3',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentImageIndex == index ? 24 : 8,
                          height: 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: _currentImageIndex == index
                                ? Colors.pink
                                : Colors.white.withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Product Info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tags
                  Wrap(
                    spacing: 8,
                    children: [
                      if (product.isNew)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'New',
                            style: TextStyle(
                              color: Colors.blue.shade700,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      if (product.isBestSeller)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber.shade100,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Best Seller',
                            style: TextStyle(
                              color: Colors.amber.shade700,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      if (product.isOnSale)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.shade100,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Sale ${product.discountPercentage}% OFF',
                            style: TextStyle(
                              color: Colors.red.shade700,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Name
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Rating
                  Row(
                    children: [
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            index < product.rating.floor()
                                ? Icons.star
                                : index < product.rating.ceil()
                                    ? Icons.star_half
                                    : Icons.star_border,
                            color: Colors.amber,
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${product.rating} (${product.reviews} reviews)',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Price
                  Row(
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE91E63),
                        ),
                      ),
                      if (product.originalPrice > 0) ...[
                        const SizedBox(width: 12),
                        Text(
                          '\$${product.originalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 18,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.shade100,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'SAVE \$${(product.originalPrice - product.price).toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.red.shade700,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Color Selection
                  const Text(
                    'Color',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: product.colors.map((color) {
                      final isSelected = color == _selectedColor;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedColor = color;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.pink.shade100 : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected ? Colors.pink : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Text(
                            color,
                            style: TextStyle(
                              color: isSelected ? Colors.pink.shade700 : Colors.black87,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),

                  // Size Selection
                  const Text(
                    'Size',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: product.sizes.map((size) {
                      final isSelected = size == _selectedSize;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedSize = size;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.pink.shade100 : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSelected ? Colors.pink : Colors.grey.shade300,
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            size,
                            style: TextStyle(
                              color: isSelected ? Colors.pink.shade700 : Colors.black87,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),

                  // Quantity
                  const Text(
                    'Quantity',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, size: 20),
                              onPressed: () {
                                if (_quantity > 1) {
                                  setState(() {
                                    _quantity--;
                                  });
                                }
                              },
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                minWidth: 40,
                                minHeight: 40,
                              ),
                            ),
                            SizedBox(
                              width: 40,
                              child: Center(
                                child: Text(
                                  '$_quantity',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add, size: 20),
                              onPressed: () {
                                setState(() {
                                  _quantity++;
                                });
                              },
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                minWidth: 40,
                                minHeight: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'In Stock',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Description
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Product Details
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _buildDetailRow('Material', product.material),
                        _buildDetailRow('Care Instructions', product.careInstructions),
                        _buildDetailRow('Category', product.category),
                        _buildDetailRow('Sub-Category', product.subCategory),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Add to Cart Button
                  ElevatedButton(
                    onPressed: _addToCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE91E63),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Buy Now Button
                  OutlinedButton(
                    onPressed: () {
                      // Implement buy now
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 56),
                      side: const BorderSide(color: Color(0xFFE91E63)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Buy Now',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE91E63),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
