import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ServiceDatabase {
  static Database? _db;

  static const String _dbName = 'cfa-db-mobile.db';

  Future<Database> initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    //? Creazione tabella prodotti
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

    //? Creazione tabella vendor
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

    //? Creazione tabella cliente
    await db.execute('''
      CREATE TABLE cte (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        codiceCliente TEXT NOT NULL,
        nome TEXT NOT NULL,
        email TEXT NOT NULL,
        numeroTelefono TEXT NOT NULL
      )
    ''');

    //? Creazione tabella ordHeader
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
        statoOrdine TEXT NOT NULL
      )
    ''');

    //? Creazione tabella ordDetails
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
        dataModifica TEXT NOT NULL)
    ''');
  }

  Future<void> closeDatabase() async {
    //final db = _db;
    if (_db != null) {
      await _db!.close();
    }
  }
}
