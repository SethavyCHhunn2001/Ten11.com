import 'package:flutter/material.dart';
import '../data/product_data.dart';
import '../models/product.dart';
import '../widgets/safe_network_image.dart';
import '../widgets/app_back_button.dart';
import 'product_detail_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String _selectedCategory = 'All';

  final List<Map<String, String>> _categories = [
    {'name': 'All', 'icon': 'all'},
    {'name': 'Tops', 'icon': 'top'},
    {'name': 'Bottoms', 'icon': 'bottom'},
    {'name': 'Dresses', 'icon': 'dress'},
    {'name': 'Bags', 'icon': 'bag'},
    {'name': 'Accessories', 'icon': 'accessory'},
    {'name': 'Best Sellers', 'icon': 'best'},
  ];

  List<Product> get _filteredProducts {
    if (_selectedCategory == 'All') {
      return ProductData.products;
    }
    return ProductData.products
        .where((p) => p.category == _selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Shop by Category'),
      ),
      body: Column(
        children: [
          // Category Grid
          Container(
            height: 100,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: _categories.map((category) {
                final isSelected = category['name'] == _selectedCategory;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = category['name']!;
                    });
                  },
                  child: Container(
                    width: 70,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.pink.shade100 : Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? Colors.pink : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getCategoryIcon(category['icon']!),
                          color: isSelected ? Colors.pink : Colors.grey.shade600,
                          size: 28,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          category['name']!,
                          style: TextStyle(
                            color: isSelected ? Colors.pink.shade700 : Colors.grey.shade700,
                            fontSize: 11,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Product Count
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              '${_filteredProducts.length} products found',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ),

          // Products
          Expanded(
            child: _filteredProducts.isEmpty
                ? Center(
                    child: Text(
                      'No products in this category yet',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = _filteredProducts[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailPage(product: product),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.grey.shade200),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  ),
                                  child: SafeNetworkImage(url: product.imageUrl),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(
                                          '\$${product.price.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Color(0xFFE91E63),
                                          ),
                                        ),
                                        if (product.originalPrice > 0) ...[
                                          const SizedBox(width: 6),
                                          Text(
                                            '\$${product.originalPrice.toStringAsFixed(2)}',
                                            style: TextStyle(
                                              decoration: TextDecoration.lineThrough,
                                              fontSize: 11,
                                              color: Colors.grey.shade500,
                                            ),
                                          ),
                                        ],
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
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String iconName) {
    switch (iconName) {
      case 'all':
        return Icons.grid_view;
      case 'top':
        return Icons.style;
      case 'bottom':
        return Icons.accessibility_new;
      case 'dress':
        return Icons.female;
      case 'bag':
        return Icons.shopping_bag;
      case 'accessory':
        return Icons.watch;
      case 'best':
        return Icons.star;
      default:
        return Icons.category;
    }
  }
}
