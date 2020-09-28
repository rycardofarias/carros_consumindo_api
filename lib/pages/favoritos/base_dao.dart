import 'dart:async';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/favoritos/db_helper.dart';
import 'package:carros/pages/favoritos/enity.dart';
import 'package:sqflite/sqflite.dart';

// Data Access Object
abstract class BaseDAO <T extends Enity> {

  Future<Database> get db => DatabaseHelper.getInstance().db;

  String get tableName;

  T fromJson(Map<String, dynamic> map);

  Future<int> save(T enity) async {
    var dbClient = await db;
    var id = await dbClient.insert(tableName, enity.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('id: $id');
    return id;
  }

  Future<List<T>> findAll() async {
    final dbClient = await db;

    final list = await dbClient.rawQuery('select * from $tableName');

    final carros = list.map<T>((json) => fromJson(json)).toList();

    return carros;
  }

  Future<List<T>> findAllByTipo(String tipo) async {
    final dbClient = await db;

    final list = await dbClient.rawQuery('select * from $tableName where tipo =? ',[tipo]);

    final carros = list.map<T>((json) => fromJson(json)).toList();

    return carros;
  }

  Future<T> findById(int id) async {
    var dbClient = await db;
    final list =
    await dbClient.rawQuery('select * from $tableName where id = ?', [id]);

    if (list.length > 0) {
      return fromJson(list.first);
    }

    return null;
  }

  Future<bool> exists(int id) async {
    T c = await findById(id);
    var exists = c != null;
    return exists;
  }

  Future<int> count() async {
    final dbClient = await db;
    final list = await dbClient.rawQuery('select count(*) from $tableName');
    return Sqflite.firstIntValue(list);
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from $tableName where id = ?', [id]);
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from $tableName');
  }
}