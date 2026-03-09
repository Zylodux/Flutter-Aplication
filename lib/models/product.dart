class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;
  final String category;
  final double rate;
  final int count;

  // Constructor 
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    required this.rate,
    required this.count,
  });

  // Gelen JSON (Map<String, dynamic>) değerlerini alıp, Product sınıfımızın 
  // özelliklerine atayarak yeni bir Product nesnesi oluşturur.
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
      category: json['category'] ?? '',
      rate: (json['rating']?['rate'] as num?)?.toDouble() ?? 0.0,
      count: (json['rating']?['count'] as num?)?.toInt() ?? 0,
    );
  }

 
  // Gerekli olduğunda Product objemizi JSON verisine (Map) dönüştürürüz.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'image': image,
      'category': category,
      'rating': {
        'rate': rate,
        'count': count,
      }
    };
  }
}
