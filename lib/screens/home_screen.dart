import 'package:flutter/material.dart';
import '../data/product_data.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import '../widgets/search_bar.dart';
import '../utils/cart_manager.dart';
import 'product_detail_screen.dart';
import 'cart_screen.dart'; 



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> allProducts = [];
  List<Product> displayedProducts = [];

  @override
  void initState() {
    super.initState();
    // Uygulama açılırken verileri yükle
    allProducts = getProducts();
    displayedProducts = allProducts;
  }

  // Arama metnine göre ürünleri filtrele
  void _filterProducts(String query) {
    setState(() {
      displayedProducts = allProducts
          .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,       
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Kısım: Üst Başlık 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Discover",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  // Sepet İkonu ve Tıklama 
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CartScreen()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      // Sepet dolunca rozet göstermek için 
                      child: const Icon(Icons.shopping_bag_outlined, size: 28),
                    ),
                  )
                ],
              ),
            ),
            
            // alt metin
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Find your perfect device.",
                style: TextStyle(color: Colors.grey[400], fontSize: 13),
              ),
            ),
            
            const SizedBox(height: 10),
            
            // 2. Kısım: Arama Çubuğu 
            SimpleSearchBar(onChanged: _filterProducts),
            
            // 3. Kısım: "GIFT STORE" Banner'ı 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(                   
                    image: NetworkImage('https://wantapi.com/assets/banner.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            
            // 4. Kısım: Ürün Izgarası (GridView)
            Expanded(
              child: displayedProducts.isEmpty
                  ? const Center(child: Text("Ürün bulunamadı."))
                  : GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, 
                        crossAxisSpacing: 15, 
                        mainAxisSpacing: 15, 
                        childAspectRatio: 0.65, 
                      ),
                      itemCount: displayedProducts.length,
                      itemBuilder: (context, index) {
                        final product = displayedProducts[index];
                        return ProductCard(
                          product: product,
                          onTap: () {
                        
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(product: product),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
