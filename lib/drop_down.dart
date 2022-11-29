import 'package:flutter/material.dart';

class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
  
  
}
class DropdownField extends StatefulWidget {
  final String hintText;
final IconData? icon;
List users = [];
final void Function(Object?) myvalue;
  DropdownField({ Key? key,required this.hintText,this.icon,required this.users,required this.myvalue}) : super(key: key);

  @override
  State<DropdownField> createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<DropdownField> {
String? selectedUser;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16,right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20)
      ),
      child: DropdownButtonFormField(
           decoration: InputDecoration(
             focusedBorder: OutlineInputBorder(
              
      borderSide: BorderSide(color: Colors.white)),
        enabledBorder: UnderlineInputBorder(
    borderSide:
        BorderSide(color: Colors.white))),
    hint:  RichText(text: TextSpan(
      children: [
        WidgetSpan(child: Icon(widget.icon,color: Colors.red,)),
        TextSpan(text: widget.hintText,style: TextStyle(color: Colors.black)),
      ]
    ),),
    // value: selectedUser,
    isExpanded: true,
    // underline: SizedBox(),
    onChanged: widget.myvalue,
    items: widget.users.map(( user) {
      return  DropdownMenuItem(
        value: user,
        child: Row(
          children: <Widget>[
            SizedBox(width: 10,),
            Text(
              user,
              style:  TextStyle(color: Colors.black),
            ),
          ],
        ),
      );
    }).toList(),
          ),
    );
  }
}