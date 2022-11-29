import 'package:floor/floor.dart';
import 'package:newlist/saved_data/savedDAO.dart';
import 'package:newlist/saved_data/saved_model.dart';



import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'database.g.dart';

@Database(version:1, entities:[SavedModel])
abstract class AppDatabase extends FloorDatabase{
  SavedDAO get savedDAO;
}