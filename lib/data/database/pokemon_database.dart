import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../../models/movement.dart';
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

    await db.execute('''
      CREATE TABLE movements (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pokemonId INTEGER NOT NULL,
        pokemonName TEXT NOT NULL,
        pokemonImageAsset TEXT NOT NULL,
        movedTo TEXT NOT NULL,
        timestamp TEXT NOT NULL
      )
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(
          "ALTER TABLE pokemons ADD COLUMN imageAsset TEXT NOT NULL DEFAULT 'assets/images/placeholder.png'");
    }

    if (oldVersion < 3) {
      await db.execute('''
        CREATE TABLE movements (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          pokemonId INTEGER NOT NULL,
          pokemonName TEXT NOT NULL,
          pokemonImageAsset TEXT NOT NULL,
          movedTo TEXT NOT NULL,
          timestamp TEXT NOT NULL
        )
      ''');
    }
  }

  Future<int> insertMovement(Movement movement) async {
    final db = await instance.database;
    return await db.insert('movements', movement.toMap());
  }

  Future<List<Movement>> getMovements() async {
    final db = await instance.database;
    final maps = await db.query('movements', orderBy: 'timestamp DESC');
    return maps.map((map) => Movement.fromMap(map)).toList();
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

  Future<int> updatePokemon(Pokemon pokemon) async {
    final db = await instance.database;
    return await db.update(
      'pokemons',
      pokemon.toMap(),
      where: 'id = ?',
      whereArgs: [pokemon.id],
    );
  }

  Future<int> deletePokemon(int id) async {
    final db = await instance.database;
    return await db.delete('pokemons', where: 'id = ?', whereArgs: [id]);
  }
}