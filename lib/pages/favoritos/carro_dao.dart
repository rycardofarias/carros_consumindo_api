import 'dart:async';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/favoritos/base_dao.dart';
import 'package:carros/pages/favoritos/db_helper.dart';
import 'package:sqflite/sqflite.dart';

// Data Access Object
class CarroDAO extends BaseDAO<Carro>{
  @override
  String get tableName => "carro";

  @override
  Carro fromJson(Map <String, dynamic> map) {
    return Carro.fromJson(map);
  }

}