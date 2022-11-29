import 'package:floor/floor.dart';
import 'package:newlist/saved_data/saved_model.dart';

@dao
abstract class SavedDAO{

   @Query('SELECT * FROM SavedModel')
   Future<List<SavedModel>> getAllFav();

   @Query('SELECT * FROM SavedModel')
   Stream<List<SavedModel>> watchAllFav();

   @insert
   Future<void> insertFav(SavedModel fav);

  @update
  Future<void> updateFav(SavedModel fav);

   @delete
   Future<int> deleteFav(SavedModel fav);

}