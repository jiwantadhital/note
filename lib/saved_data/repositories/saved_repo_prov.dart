import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:newlist/saved_data/repositories/repository.dart';
import 'package:newlist/saved_data/saved_model.dart';

class SavedRepoPro extends ChangeNotifier{

late SavedRepo savedRepo;

List<SavedModel> savedList = [];

SavedRepoPro(){
  savedRepo = GetIt.instance.get<SavedRepo>();
  watchAllList();
}

void watchAllList(){
  savedRepo.watchAll().listen((savedList) {
    this.savedList = savedList;
    notifyListeners();
  });
}

Future<void> addsavedAll(String name, String task)async{
var newSavedList = SavedModel(name: name, taskS: task);
await savedRepo.insertAll(newSavedList);
}

Future<void> updateSaved(String name, String task, int id)async{
var newSavedList = SavedModel(name: name, taskS: task,id: id);
await savedRepo.updateAll(newSavedList);
}

Future<void> deleteSavedAll(SavedModel savedModel) async{
  await savedRepo.deleteAll(savedModel);
}

}