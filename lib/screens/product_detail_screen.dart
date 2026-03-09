import 'package:flutter/material.dart';
import '../models/product.dart';
import '../utils/cart_manager.dart';



class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  void _toggleCart() {
    setState(() {
      globalCartManager.toggleCart(widget.product);
    });
    

    bool isInCart = globalCartManager.isInCart(widget.product);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isInCart ? 'Added to Cart' : 'Removed from Cart'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
   
    final isAdded = globalCartManager.isInCart(p);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Kısım: Üst Bar 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: const [
                          Icon(Icons.arrow_back_ios, size: 18),
                          Text("Back", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // 2. Kısım:  Kaydırılabilir İçerik
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [                   
                    Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F3F3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          p.image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                             const Center(child: Icon(Icons.image, size: 50, color: Colors.grey)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Ürün Başlığı ve Alt Başlığı
                    Text(
                      p.title,
                      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      p.category.toUpperCase(),
                      style: TextStyle(fontSize: 14, color: Colors.grey[500], fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    
                    // Açıklama Başlığı
                    const Text(
                      "Description",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      p.description,
                      style: TextStyle(fontSize: 13, height: 1.5, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 24),
                    
                    // Özellikler  Başlığı
                    const Text(
                      "Specifications",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    
                    // Yan Yana Özellik Kutuları 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSpecBox("RATING", "${p.rate} ⭐"),
                        const SizedBox(width: 8),
                        _buildSpecBox("REVIEWS", "${p.count}"),
                        const SizedBox(width: 8),
                        _buildSpecBox("CATEGORY", p.category.split(' ').first),
                      ],
                    ),
                    const SizedBox(height: 40), // Alt kısımdan boşluk bırak
                  ],
                ),
              ),
            ),
            
            // 3. Kısım: Sabit  Add to Cart Butonu Ekranın Altında
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _toggleCart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, 
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    isAdded ? "Remove from Cart" : "Add to Cart  -  \$${p.price.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Özellik kutucuğu 
  Widget _buildSpecBox(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!, width: 1.5), 
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 10, color: Colors.grey[400], fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, height: 1.2),
            ),
          ],
        ),
      ),
    );
  }
}
