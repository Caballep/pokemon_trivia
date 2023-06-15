import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PokemonDb {
  static const String databaseName = 'pokemon_database.db';
  static const int databaseVersion = 1;

  Future<Database> open() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, databaseName);
    return openDatabase(path, version: databaseVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE pokemons (
        number INTEGER PRIMARY KEY, 
        name TEXT,
        frontSpriteUrl TEXT,
        mainType TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE generations (
        code TEXT,
        startsWith INTEGER,
        endsWith INTEGER,
        mainRegionName TEXT,
        accessState INTEGER DEFAULT 1
      )
    ''');
  }
}
