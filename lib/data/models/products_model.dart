import 'dart:convert';

class Product {
  final int? id;
  final String codiceArticolo;
  final String descrizioneProdotto;
  final String barcode;
  final int stock;
  final double prezzo;
  final List<String>? urlPhoto;

  Product(
    this.id, {
    required this.codiceArticolo,
    required this.stock,
    required this.descrizioneProdotto,
    required this.barcode,
    required this.prezzo,
    this.urlPhoto,
  });

  // Convert Product to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descrizioneProdotto': descrizioneProdotto,
      'codiceArticolo': codiceArticolo,
      'barcode': barcode,
      'description': barcode,
      'stock': stock,
      'prezzo': prezzo,
      'imageUrl': jsonEncode(urlPhoto),
    };
  }

  // Create Product from Map
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      map['id'],
      codiceArticolo: map['codiceArticolo'],
      descrizioneProdotto: map['descrizioneProdotto'],
      barcode: map['barcode'],
      prezzo: map['prezzo']?.toDouble() ?? 0.0,
      stock: map['stock'] ?? 0,
      urlPhoto:
          jsonDecode(
            map['imageUrl'].toString(),
          ).cast<String>().map((e) => e.toString()).toList(),
    );
  }
}
