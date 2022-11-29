import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PaginateView extends StatelessWidget {
  const PaginateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context,index){
          return Container(
            height: 100,
            width: double.maxFinite,
            child: Column(
              children: [
                Text("titla"),
                Text("desc"),
              ],
            ),
          );
        }),
      ),
    );
  }
}