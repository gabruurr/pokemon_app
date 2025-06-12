import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/pokemon.dart';

class PokemonDatabase {
  static final PokemonDatabase instance = PokemonDatabase._init();
  static Database? _database;

  PokemonDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('pokemon.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 3,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE pokemons (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        tipo TEXT NOT NULL,
        imageAsset TEXT NOT NULL, 
        estaNaEquipe INTEGER NOT NULL
      )
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(
          "ALTER TABLE pokemons ADD COLUMN imageAsset TEXT NOT NULL DEFAULT 'assets/images/placeholder.png'");
    }
  }

  Future<List<Pokemon>> getPokemons() async {
    final db = await instance.database;
    final maps = await db.query('pokemons');

    return maps.map((map) => Pokemon.fromMap(map)).toList();
  }

  Future<int> insertPokemon(Pokemon pokemon) async {
    final db = await instance.database;
    return await db.insert('pokemons', pokemon.toMap());
  }
}
