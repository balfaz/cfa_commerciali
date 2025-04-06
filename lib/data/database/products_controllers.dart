import 'dart:async';
import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Exception class for Product-related database operations
class ProductDatabaseException implements Exception {
  final String message;
  final dynamic originalError;

  ProductDatabaseException(this.message, [this.originalError]);

  @override
  String toString() {
    if (originalError != null) {
      return 'ProductDatabaseException: $message (Original error: $originalError)';
    }
    return 'ProductDatabaseException: $message';
  }
}

// Model class for Product
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

class ProductsController {
  final Database _database;

  ProductsController(this._database);

  // Create a product
  Future<int> createProduct(Product product) async {
    try {
      return await _database.insert(
        'products',
        product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw ProductDatabaseException('Failed to create product', e);
    }
  }

  // Read a single product by ID
  Future<Product?> getProduct(int id) async {
    try {
      final List<Map<String, dynamic>> maps = await _database.query(
        'products',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (maps.isEmpty) {
        return null;
      }
      return Product.fromMap(maps.first);
    } catch (e) {
      throw ProductDatabaseException('Failed to get product with id: $id', e);
    }
  }

  // Read all products
  Future<List<Product>> getAllProducts() async {
    try {
      final List<Map<String, dynamic>> maps = await _database.query('products');
      return List.generate(maps.length, (i) {
        return Product.fromMap(maps[i]);
      });
    } catch (e) {
      throw ProductDatabaseException('Failed to get all products', e);
    }
  }

  // Read products with filters
  Future<List<Product>> getProductsWithFilter({
    String? nameFilter,
    bool? isAvailableOnly,
    double? minPrice,
    double? maxPrice,
  }) async {
    try {
      List<String> whereConditions = [];
      List<dynamic> whereArgs = [];

      if (nameFilter != null && nameFilter.isNotEmpty) {
        whereConditions.add('name LIKE ?');
        whereArgs.add('%$nameFilter%');
      }

      if (isAvailableOnly == true) {
        whereConditions.add('isAvailable = ?');
        whereArgs.add(1);
      }

      if (minPrice != null) {
        whereConditions.add('price >= ?');
        whereArgs.add(minPrice);
      }

      if (maxPrice != null) {
        whereConditions.add('price <= ?');
        whereArgs.add(maxPrice);
      }

      final String? whereClause =
          whereConditions.isNotEmpty ? whereConditions.join(' AND ') : null;

      final List<Map<String, dynamic>> maps = await _database.query(
        'products',
        where: whereClause,
        whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
      );

      return List.generate(maps.length, (i) => Product.fromMap(maps[i]));
    } catch (e) {
      throw ProductDatabaseException('Failed to query products with filter', e);
    }
  }

  // Update a product
  Future<int> updateProduct(Product product) async {
    try {
      if (product.id == null) {
        throw ProductDatabaseException('Cannot update product without an ID');
      }

      return await _database.update(
        'products',
        product.toMap(),
        where: 'id = ?',
        whereArgs: [product.id],
      );
    } catch (e) {
      throw ProductDatabaseException('Failed to update product', e);
    }
  }

  // Delete a product
  Future<int> deleteProduct(int id) async {
    try {
      return await _database.delete(
        'products',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw ProductDatabaseException(
        'Failed to delete product with id: $id',
        e,
      );
    }
  }

  // Delete all products (use with caution)
  Future<int> deleteAllProducts() async {
    try {
      return await _database.delete('products');
    } catch (e) {
      throw ProductDatabaseException('Failed to delete all products', e);
    }
  }

  // Check if a product exists
  Future<bool> productExists(int id) async {
    try {
      final result = await _database.query(
        'products',
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );
      return result.isNotEmpty;
    } catch (e) {
      throw ProductDatabaseException('Failed to check if product exists', e);
    }
  }
}
