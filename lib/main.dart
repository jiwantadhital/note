import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:newlist/drop_down.dart';
import 'package:newlist/saved_data/database/database.dart';
import 'package:newlist/saved_data/repositories/repository.dart';
import 'package:newlist/saved_data/repositories/saved_repo_prov.dart';
import 'package:newlist/saved_data/savedDAO.dart';
import 'package:newlist/saved_data/saved_model.dart';
import 'package:newlist/ui/bottom_sheet.dart';
import 'package:provider/provider.dart';

void main() {
  GetIt getIt = GetIt.instance;

  // Register our database first.
  getIt.registerSingletonAsync<AppDatabase>(
      () async =>$FloorAppDatabase.databaseBuilder('saved.db').build());
      getIt.registerSingletonWithDependencies<SavedDAO>((){
        return GetIt.instance.get<AppDatabase>().savedDAO;
      },dependsOn: [AppDatabase]);
  getIt.registerSingletonWithDependencies<SavedRepo>((){
    return SavedRepo();
  },dependsOn: [AppDatabase, SavedDAO]);
  runApp( MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context){
          return SavedRepoPro();
        })
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:  FutureBuilder(
          future: GetIt.instance.allReady(),
          builder: (context,AsyncSnapshot snapshot) {
            return snapshot.hasData?MyHomePage():Scaffold(body: Center(child: Text("No DATA"),));
          }
        ),
      ),
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

List tasks = [
  "To Do",
  "Doing",
  "Done"
];

   TextEditingController _controller = TextEditingController();
  List<SavedModel> _searchList = [];
  var nameController = TextEditingController();
 var taskController = TextEditingController();
String? taskdo;
String taskNow = "";
@override
  void dispose() {
    _controller;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    context.watch<SavedRepoPro>().watchAllList();
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          onChanged: _onSearchTextChanged,
        ),
        actions: [
         GestureDetector(
          onTap: (){
            showModalBottomSheet(
                          context: context,
           builder: ( (context) {
             return Container(
              height: 100,
              color: Colors.white,
             );
           })).then((val) {
            setState(() {
              
            });
           }
           );
          },
          child: Icon(Icons.filter)),
        ],
      ),
      body: Container(
        child: Consumer<SavedRepoPro>(
          builder: ((context, value, child) {
            return _searchList.length != 0|| _controller.text.isNotEmpty? ListView.builder(
          itemCount: _searchList.length,
          itemBuilder: (context,index){
          return Container(
            margin: EdgeInsets.all(5),
            height: 100,
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue
            ),
            child: Column(
              children: [
                Text(_searchList[index].name),
                Text(_searchList[index].taskS),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: (){
                        var item = value.savedList;
                        value.deleteSavedAll(item[index]);
                      },
                      child: Icon(Icons.delete)),
                      InkWell(
                      onTap: (){
                        showModalBottomSheet(
                          context: context,
           builder: ( (context) {
             return BottomSheetN(name: value.savedList[index].name, task: value.savedList[index].taskS,id: value.savedList[index].id!.toInt(),);
           })).then((val) {
            setState(() {
              
            });
           });
                      },
                      child: Icon(Icons.edit)),
                  ],
                )
              ],
            ),
          );
        }):SingleChildScrollView(
          child: Column(
            children: 
              [
                Container(
                  margin: EdgeInsets.all(20),
                  height: 60,
                  child: ListView.builder(
                    itemCount: value.savedList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                    return Container(
                      margin: EdgeInsets.all(5),
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                      ),
                      child: Center(child: Text(value.savedList[index].taskS)),
                    );
                  }),
                  // child: Row(
                  //   children: [
                  //     GestureDetector(
                  //       onTap: (){
                  //         setState(() {
                  //           taskNow="";
                  //         });
                  //       },
                  //       child: Container(
                  //       margin: EdgeInsets.only(left: 5),
                  //       width: 100,
                  //       height: 50,
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(10),
                  //         color: Colors.grey
                  //       ),
                  //       child: Center(child: Text("All",)),
                  //                         ),
                  //     ),
                  //     GestureDetector(
                  //       onTap: (){
                  //         setState(() {
                  //           taskNow="To do";
                  //         });
                  //       },
                  //       child: Container(
                  //       margin: EdgeInsets.only(left: 5),
                  //       width: 100,
                  //       height: 50,
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(10),
                  //         color: Colors.grey
                  //       ),
                  //       child: Center(child: Text("To Do",)),
                  //                         ),
                  //     ),
                  //    GestureDetector(
                  //     onTap: (){
                  //            setState(() {
                  //           taskNow="Doing";
                  //         });
                  //       },
                  //      child: Container(
                  //       margin: EdgeInsets.only(left: 5),
                  //       width: 100,
                  //       height: 50,
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(10),
                  //         color: Colors.grey
                  //       ),
                  //       child: Center(child: Text("Doing",)),
                  //                        ),
                  //    ),
                  //    GestureDetector(
                  //     onTap: (){
                  //            setState(() {
                  //           taskNow="Done";
                  //         });
                  //       },
                  //      child: Container(
                  //       margin: EdgeInsets.only(left: 5),
                  //       width: 100,
                  //       height: 50,
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(10),
                  //         color: Colors.grey
                  //       ),
                  //       child: Center(child: Text("Done",)),
                  //                        ),
                  //    ),
                  //   ],
                  // )
                ),
                Container(
                height: 400,
                child: taskNow==""? ListView.builder(
                  itemCount: value.savedList.length,
                  itemBuilder: (context,index){
                    var datas = value.savedList[index].taskS;
                  return Container(
                    margin: EdgeInsets.all(5),
                    height: 100,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue
                    ),
                    child: Column(
                      children: [
                        Text(value.savedList[index].name),
                        Text(value.savedList[index].taskS),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: (){
                                var item = value.savedList;
                                value.deleteSavedAll(item[index]);
                              },
                              child: Icon(Icons.delete)),
                              InkWell(
                              onTap: (){
                                showModalBottomSheet(
                                  context: context,
                   builder: ( (context) {
                     return BottomSheetN(name: value.savedList[index].name, task: value.savedList[index].taskS,id: value.savedList[index].id!.toInt(),);
                   })).then((val) {
                    setState(() {
                      
                    });
                   });
                              },
                              child: Icon(Icons.edit)),
                          ],
                        )
                      ],
                    ),
                  );
                }):ListView.builder(
                  itemCount: value.savedList.length,
                  itemBuilder: (context,index){
                    var datas = value.savedList[index].taskS;
                  return value.savedList[index].taskS==taskNow? Container(
                    margin: EdgeInsets.all(5),
                    height: 100,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue
                    ),
                    child: Column(
                      children: [
                        Text(value.savedList[index].name),
                        Text(value.savedList[index].taskS),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: (){
                                var item = value.savedList;
                                value.deleteSavedAll(item[index]);
                              },
                              child: Icon(Icons.delete)),
                              InkWell(
                              onTap: (){
                                showModalBottomSheet(
                                  context: context,
                   builder: ( (context) {
                     return BottomSheetN(name: value.savedList[index].name, task: value.savedList[index].taskS,id: value.savedList[index].id!.toInt(),);
                   })).then((val) {
                    setState(() {
                      
                    });
                   });
                              },
                              child: Icon(Icons.edit)),
                          ],
                        )
                      ],
                    ),
                  ):Text("");
                }),
              ),
            ],
          ),
        );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(context: context,
           builder: ( (context) {
             return Consumer<SavedRepoPro>(builder: ((context, value, child) {
                return Container(
              height: 500,
              color: Colors.white,
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextField(controller: nameController,),
                    SizedBox(height: 10,),
                    DropdownField(hintText: "To do", users: [
                      "To do",
                      "Doing",
                      "Done"
                    ], myvalue: (val){
                      setState(() {
                        taskdo = val.toString();
                      });
                    }),
                    SizedBox(height: 20,),
                    ElevatedButton(onPressed: (){
                      value.addsavedAll(nameController.text, taskdo.toString());
                        Navigator.pop(context);
                    }, child: Text("Submit"))
                  ],
                ),
              ),
             );
             }));
           })).whenComplete(() {
        setState(() {
          
        });
           });
        },
        child: Icon(Icons.add),
      ),
    );
  }
      _onSearchTextChanged(String text)async{
      var all = Provider.of<SavedRepoPro>(context,listen: false).savedList;
      _searchList.clear();
      if(text.isEmpty){
        setState(() {
        });
        return;
      }
      all.forEach((searchDetails) {
        if(searchDetails.name.toLowerCase().contains(text.toLowerCase())){
          _searchList.add(searchDetails);
          _searchList.sort((a, b) {
            return a.name.toString().compareTo(b.name.toString());
          },);
        }
       });
       setState(() {
         
       });
    }
}
