import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:newlist/saved_data/savedDAO.dart';
import 'package:newlist/saved_data/saved_model.dart';

class SavedRepo {

late SavedDAO savedDAO;

SavedRepo(){
  savedDAO = GetIt.instance.get<SavedDAO>();
}

Future<List<SavedModel>> getAll(){
  return savedDAO.getAllFav();
}

Future<void> insertAll(SavedModel savedModel){
  return savedDAO.insertFav(savedModel);
}
Future<void> updateAll(SavedModel savedModel){
  return savedDAO.updateFav(savedModel);
}

Future<int> deleteAll(SavedModel savedModel){
  return savedDAO.deleteFav(savedModel);
} 

Stream<List<SavedModel>> watchAll(){
  return savedDAO.watchAllFav();
}
}