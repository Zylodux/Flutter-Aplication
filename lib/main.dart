import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MiniKatalogApp());
}


class MiniKatalogApp extends StatelessWidget {
  const MiniKatalogApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Katalog',
      debugShowCheckedModeBanner: false, // Sağ üstteki "DEBUG" yazısını kaldırır
      // Uygulama genelinde kullanılacak renk paleti
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white, // AppBar üzerindeki yazıların/butonların rengi
          elevation: 0, // AppBar altındaki gölgeyi kaldırır
        ),
      ),
      // Uygulama açıldığında ilk gösterilecek sayfa
      home: const HomeScreen(),
    );
  }
}
