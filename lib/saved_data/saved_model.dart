// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:floor/floor.dart';

@entity
class SavedModel {
  @PrimaryKey(autoGenerate:true)
  int? id;
  String name;
  String taskS;
  SavedModel({
    this.id,
    required this.name,
    required this.taskS,
  });

}
