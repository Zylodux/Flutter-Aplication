import 'package:flutter/material.dart';
import '../models/product.dart';
import '../utils/cart_manager.dart';




class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // ValueNotifier'ı dinleyen bir yapı kurmak için (Ekranın kendini güncellemesi için)
  @override
  void initState() {
    super.initState();
    globalCartManager.cartItems.addListener(_cartUpdated);
  }

  @override
  void dispose() {
    globalCartManager.cartItems.removeListener(_cartUpdated);
    super.dispose();
  }

  void _cartUpdated() {
    setState(() {}); // Liste değiştiğinde ekranı yenilet
  }

  @override
  Widget build(BuildContext context) {
    final cartList = globalCartManager.cartItems.value;
    
    // Sepet Toplam Tutarı
    double totalAmount = cartList.fold(0, (sum, item) => sum + item.price);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Kısım: Üst Bar ("< Cart")
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
                          Text("Cart", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // 2. Kısım: Liste veya Boş Durum
            Expanded(
              child: cartList.isEmpty
                  ? _buildEmptyCart() // Sepet boşysa
                  : ListView.separated( // Sepet doluysa
                      padding: const EdgeInsets.all(20.0),
                      itemCount: cartList.length,
                      separatorBuilder: (context, index) => const Divider(height: 30, color: Colors.grey),
                      itemBuilder: (context, index) {
                        final product = cartList[index];
                        return _buildCartItem(product);
                      },
                    ),
            ),
            
            // 3. Kısım: Alt bilgi ve "Checkout" Butonu
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // alt metin
                    Row(
                      children: [
                        const Icon(Icons.info_outline, size: 14, color: Colors.grey),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Lorem Ipsum is simply dummy text of the printing.",
                            style: TextStyle(fontSize: 11, color: Colors.grey[400]),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    //  Checkout Butonu
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: cartList.isEmpty ? null : () {
                          //  Gerçekte ödeme sayfasına gider
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Checkout feature is simulated!')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: Colors.grey[300], 
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          cartList.isEmpty ? "Checkout" : "Checkout  -  \$${totalAmount.toStringAsFixed(0)}",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Sepetteki ürünün tasarımı 
  Widget _buildCartItem(Product product) {
    return Row(
      children: [
        // Sol Resim 
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F3F3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(product.image, fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.image, color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(width: 16),
        
        // Orta Yazılar
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 2),
              Text(product.category, style: TextStyle(color: Colors.grey[500], fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 2),
              Text("\$${product.price.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
            ],
          ),
        ),
        
        // Sağ Çıkarma Butonu
        IconButton(
          onPressed: () {
            globalCartManager.toggleCart(product);
          },
          icon: Icon(Icons.remove_circle_outline, color: Colors.grey[400]),
        ),
      ],
    );
  }

  // Sepet Boş Görünümü
  Widget _buildEmptyCart() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey[300]),
        const SizedBox(height: 16),
        const Text("Your cart is empty", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text("Add items to start shopping", style: TextStyle(fontSize: 14, color: Colors.grey[400])),
      ],
    );
  }
}
