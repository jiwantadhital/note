// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:newlist/saved_data/repositories/saved_repo_prov.dart';
import 'package:newlist/saved_data/saved_model.dart';
import 'package:provider/provider.dart';

import 'package:newlist/saved_data/repositories/repository.dart';

class BottomSheetN extends StatefulWidget {
  
  int id;
String name;
String task;
  BottomSheetN({
    Key? key,
    required this.id,
    required this.name,
    required this.task,
  }) : super(key: key);

  @override
  State<BottomSheetN> createState() => _BottomSheetNState();
}

class _BottomSheetNState extends State<BottomSheetN> {

  var nameEditingController = TextEditingController();
   var taskEditingController = TextEditingController();
bool isNull = true;
@override
  void initState() {
    if(widget.id != null){
      nameEditingController.text=widget.name;
      taskEditingController.text=widget.task;
      isNull=false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SavedRepoPro>(builder: ((context, value, child) {
      return Container(
              height: 500,
              color: Colors.white,
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextField(controller: nameEditingController,),
                    SizedBox(height: 10,),
                    TextField(controller: taskEditingController,),
                    SizedBox(height: 20,),
                    ElevatedButton(onPressed: (){
                      // var updateData = SavedModel(name: widget.nameEditingController.text, taskS: widget.taskEditingController.text);
                      value.updateSaved(nameEditingController.text, taskEditingController.text, widget.id);
                        Navigator.pop(context);
                    }, child: Text("Edit"))
                  ],
                ),
              ),
             );
    }));
  }
}