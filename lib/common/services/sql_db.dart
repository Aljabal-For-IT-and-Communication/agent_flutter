import 'dart:async';
import 'package:app/common/entities/entities.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDbService {

  final _databaseName = 'chat_v1.db';
  final _databaseVersion = 1;
  late final Database _database;

  Future<SqlDbService> init() async {
    print("数据库初始化");
    _database = await _initDB();
    return this;
  }

  _initDB() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,version: _databaseVersion, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE chat_users (id INTEGER PRIMARY KEY AUTOINCREMENT, token TEXT, cid INTEGER, name TEXT,avatar TEXT,last_msg TEXT,last_time TEXT, msg_num INTEGER)');
    print("创建数据表");
  }

  Future<int> insertChatUser(ChatUserItem item) async {
    print("插入数据表");
    return await _database.insert("chat_users", {
      'token': item.token,
      'cid': item.cid,
      'name': item.name,
      'avatar': item.avatar,
      'last_msg': item.lastMsg,
      'last_time': item.lastTime,
      'msg_num': item.msgNum,
    });
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    String sql = "SELECT * FROM chat_users ORDER BY last_time DESC";
    return await _database.rawQuery(sql,[]);
  }

  Future<List<Map<String, dynamic>>> queryByTokenRow(String? token) async {
    String sql = "SELECT * FROM chat_users WHERE token = ?";
    return await _database.rawQuery(sql,[token]);
  }

  Future<int> deleteByIdChatUser(int? id) async {
    return await _database.delete("chat_users", where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAllChatUser() async {
    return await _database.delete("chat_users");
  }

  Future<int> updateChatUser(ChatUserItem item)async{
    return await _database.rawUpdate('UPDATE chat_users SET name = ?, avatar = ?, last_msg = ?, last_time = ?, msg_num = ? WHERE token = ?', [item.name, item.avatar,item.lastMsg,item.lastTime,item.msgNum, item.token]);
  }

  Future<int> clearByTokenReadMsgNum(String? token) async {
    return await _database.rawUpdate('UPDATE chat_users SET msg_num = 0 WHERE token = ?', [token]);
  }
  Future<int> getByTokenUnreadMsgNum(String? token) async {
    final result = await _database.query(
      'chat_users',
      columns: ['msg_num'],
      where: 'token = ?',
      whereArgs: [token],
    );
    if (result.isNotEmpty) {
      int? msgNum = result.first['msg_num'] as int?;
      return msgNum??0;
    } else {
      return 0; // 用户不存在
    }
  }

  Future<int> getUnreadMsgNum() async {
    String sql = "SELECT sum(msg_num) as sum_msg_num FROM chat_users";
    final result = await _database.rawQuery(sql,[]);
    if (result.isNotEmpty) {
      int? msgNum = result.first['sum_msg_num'] as int?;
      return msgNum??0;
    } else {
      return 0; // 用户不存在
    }
  }


}
