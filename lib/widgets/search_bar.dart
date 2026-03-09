import 'package:flutter/material.dart';



class SimpleSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SimpleSearchBar({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        onChanged: onChanged, // Yazı değiştikçe ana widget'a (HomeScreen) bildir
        style: const TextStyle(fontSize: 14),
        decoration: const InputDecoration(
          icon: Icon(Icons.search, color: Colors.grey, size: 20),
          hintText: 'Search products',
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
          border: InputBorder.none, 
        ),
      ),
    );
  }
}
