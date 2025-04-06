import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ServiceDatabase {
  static final ServiceDatabase _instance = ServiceDatabase._internal();
  static Database? _database;

  factory ServiceDatabase() {
    return _instance;
  }

  ServiceDatabase._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'cfa-db-mobile.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    // Creazione tabella prodotti
    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        codiceArticolo TEXT NOT NULL,
        barcode TEXT NOT NULL,
        descrizioneProdotto TEXT NOT NULL,
        prezzo REAL NOT NULL,
        stock INTEGER NOT NULL,
        urlPhoto TEXT
      )
    ''');

    // Creazione tabella vendor
    await db.execute('''
      CREATE TABLE vendor (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        codiceVendor TEXT NOT NULL,
        nome TEXT NOT NULL,
        email TEXT NOT NULL,
        numeroTelefono TEXT NOT NULL,
        password TEXT NOT NULL,
        statoUser TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE Cliente (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        codiceCliente TEXT NOT NULL,
        nome TEXT NOT NULL,
        email TEXT NOT NULL,
        numeroTelefono TEXT NOT NULL,
      )
    ''');

    // Creazione tabella ordHeader
    await db.execute('''
      CREATE TABLE ordHeader (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nroOrdine TEXT NOT NULL,
        codiceVendor TEXT NOT NULL,
        codiceCliente TEXT NOT NULL,
        totaleOrdine REAL NOT NULL,
        totaleRighe INTEGER NOT NULL,
        dataOrdine TEXT NOT NULL,
        dataConsegna TEXT NOT NULL,
        dataCreazione TEXT NOT NULL,
        dataModifica TEXT NOT NULL,
        statoOrdinePagamento TEXT NOT NULL,
        statoOrdine TEXT NOT NULL,
        Foreign Key (codiceVendor) REFERENCES vendor (id),

      )
    ''');

    // Creazione tabella ordDetails
    await db.execute('''
      CREATE TABLE ordDetails (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nroOrdine TEXT NOT NULL,
        codiceArticolo TEXT NOT NULL,
        quantita INTEGER NOT NULL,
        prezzoUnitario REAL NOT NULL, 
        iva REAL NOT NULL,
        sconto REAL NOT NULL,
        statoRiga TEXT NOT NULL,
        dataConsegna TEXT NOT NULL,
        dataCreazione TEXT NOT NULL,
        dataModifica TEXT NOT NULL,
        FOREIGN KEY (nroOrdine) REFERENCES ordHeader (nroOrdine),
        FOREIGN KEY (codiceArticolo) REFERENCES products (codiceArticolo)
      )
    ''');
  }

  Future<void> closeDatabase() async {
    final db = _database;
    if (db != null) {
      await db.close();
    }
  }
}
