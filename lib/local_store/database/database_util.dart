import 'package:basic_frame/bean/dog.dart';
import 'package:basic_frame/util/logger/logger_util.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

///数据库工具
class DBProvider {
  DBProvider._internal(this._directoryPath);

  static DBProvider? _instance;

  ///初始化数据库路径
  ///建议传入路径：getDatabasesPath()，该路径获取必须在主isolate中调用
  ///[path]：数据库路径
  factory DBProvider(String directoryPath) => _instance ??= DBProvider._internal(directoryPath);

  //数据库文件存储目录
  final String _directoryPath;

  Database? _database;
  Future _loadDatabase() async {
    _database ??=
        await openDatabase(join(_directoryPath, 'my_database.db'),
            onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)');
    }, version: 1);
  }

  Future<int> insert(Dog dog) async {
    await _loadDatabase();
    return await _database!.insert('dogs', dog.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Dog>> query() async {
    await _loadDatabase();
    final List<Map<String, dynamic>> maps = await _database!.query('dogs');
    return List.generate(maps.length, (i) {
      return Dog(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age'],
      );
    });
  }

  ///使用 whereArgs 将参数传递给 where 语句。有助于防止 SQL 注入攻击。
  /// 这里不要使用字符串模板，比如： where: "id = ${dog.id}"！
  Future<int> update(Dog dog) async {
    // Get a reference to the database.
    await _loadDatabase();

    // Update the given Dog.
    return await _database!.update(
      'dogs',
      dog.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [dog.id],
    );
  }

  Future<int> delete(int id) async {
    // Get a reference to the database (获得数据库引用)
    await _loadDatabase();

    // Remove the Dog from the database.
    return await _database!.delete(
      'dogs',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  ///用于测试
  void test() async {
    try {
      // Create a Dog and add it to the dogs table
      var fido = const Dog(
        id: 0,
        name: 'Fido',
        age: 35,
      );

      int row = await insert(fido);
      LoggerUtil().d('插入dog数据：$row');
    } catch (e) {
      LoggerUtil().e(e);
    }
  }
}
