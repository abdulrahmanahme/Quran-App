
import 'package:quran_app/core/model/model_data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AayahDataBase {

  static final AayahDataBase instance = AayahDataBase._init();
  static Database? _database;
  AayahDataBase._init();
 late List<AayahModel> savedAayah;
 int? index;

  Future<Database> get dataBase async {
    if (_database != null) return _database!;
    _database = await _initDB(); 
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbpath = await getDatabasesPath();
    final path =  join(dbpath, 'Ayah.db');
    return await openDatabase(path,
        version: 1, onCreate:(Database db, int version)async{
    final idType = ' INTEGER PRIMARY KEY AUTOINCREMENT ';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';
    await db.execute('''
CREATE TABLE $tableAayah (
  ${AayahFields.title} $textType,
  ${AayahFields.time} $textType,
  ${AayahFields.bookmarkedAyah} $integerType,
  ${AayahFields.bookmarkedSura} $integerType
)
'''); 
    print('==============Created DataBase =================');

});
  
  }


  Future<AayahModel> create(AayahModel artical) async {
    final db = await instance.dataBase;
    final id = await db.insert(tableAayah, artical.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
       
    print('==============Created Successfuly =================');

    return artical.copy(id: id);
  }

  Future<AayahModel> readArtical(String title) async {
    final db = await instance.dataBase;
    final map = await db.query(tableAayah,
        columns: AayahFields.values,
        where: '${AayahFields.title} = ?',
        whereArgs: [title]);
    if (map.isNotEmpty) {
      return AayahModel.fromJson(map.first);
    } else {
      throw Exception('ID $title not found');
    }
  }
Future<List<AayahModel>> readAllNotes() async {
    final db = await instance.dataBase;

    final orderBy = '${AayahFields.time} ASC';
    final result = await db.query(tableAayah, orderBy: orderBy);

    return result.map((json) =>AayahModel.fromJson(json)).toList();
  }

  Future<int> delete(String title) async {
    final db = await instance.dataBase;

    return await db.delete(
      tableAayah,
      where: '${AayahFields.title} = ?',
      whereArgs: [title],
    );
  }

  Future close() async {
    final db = await instance.dataBase;
    db.close();
  }
}