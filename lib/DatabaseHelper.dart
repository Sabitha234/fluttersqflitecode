import 'dart:async';

import 'package:sqflite/sqflite.dart' as sql;
class DatabaseHelper{
static Future<sql.Database> db() async{
  return sql.openDatabase("movieLogin",
  version: 5,
  onCreate: (sql.Database db,int version)async{
    return await createTable(db);
  }
  );
}
static Future<void> createTable(sql.Database dbe)async {
  await dbe.execute(
    "CREATE TABLE account(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,name TEXT,email_id TEXT,password TEXT,phno TEXT,profession TEXT)"
  );
}

static Future<int> insertItems(String? name,String? email,String? password,
   String? phone_no,String? prof)async{
  final database = await DatabaseHelper.db();
  final data={
    'name':name,
    'email_id':email,
    'password':password,
    'phno':phone_no,
    'profession':prof
  };
  final id=await database.insert("account",data);
  return id;
}

static Future<List<Map<String,dynamic>>> readData() async {
  final dbe=await DatabaseHelper.db();
  final data = dbe.query("account");
  return data;
}
}