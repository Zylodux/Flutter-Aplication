import 'package:flutter/foundation.dart';
import '../models/product.dart';


class CartManager {
  // Sınıfın tek bir kopyasını hafızada tutuyoruz
  static final CartManager _instance = CartManager._internal();

  factory CartManager() {
    return _instance;
  }

  CartManager._internal();

  // ValueNotifier, liste değiştiğinde ekranı dinleyenlere haber verir
  final ValueNotifier<List<Product>> cartItems = ValueNotifier<List<Product>>([]);

  // Sepette bu ürün var mı kontrol et
  bool isInCart(Product product) {
    return cartItems.value.any((p) => p.id == product.id);
  }

  // Sepete ekle ya da sepetten çıkar
  void toggleCart(Product product) {
    // Listeyi kopyala 
    final currentList = List<Product>.from(cartItems.value);
    
    if (isInCart(product)) {
      currentList.removeWhere((p) => p.id == product.id); // Çıkar
    } else {
      currentList.add(product); // Ekle
    }
    
    // Yeni listeyi atayarak dinleyen ekranları uyar
    cartItems.value = currentList;
  }
}

// Kolay kullanım için global bir referans
final globalCartManager = CartManager();
