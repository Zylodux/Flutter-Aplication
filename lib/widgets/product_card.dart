import 'package:flutter/material.dart';
import '../models/product.dart';



class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // GestureDetector: Tıklanma özelliğine sahip olmayan widget'lara tıklama özelliği kazandırır.
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Kısım: Resmin bulunduğu gri arka planlı kare kutucuk
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F3F3), 
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  product.image,
                  fit: BoxFit.cover,            
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Icon(Icons.image_not_supported, color: Colors.grey));
                  },
                ),
              ),
            ),
          ),
          
          // 2. Kısım: Kutunun Altındaki Yazılar (Başlık, Altbaşlık ve Fiyat)
          const SizedBox(height: 8),
          Text(
            product.title,
            style: const TextStyle(
              fontWeight: FontWeight.w700, 
              fontSize: 13,
            ),
            maxLines: 1, 
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            product.category,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 11,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            '\$${product.price.toStringAsFixed(0)}',
            style: TextStyle(
              color: Colors.blue[600], 
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
