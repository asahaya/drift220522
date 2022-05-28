import 'package:drift220522/drift/todolist.dart';
import 'package:drift220522/main.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key,required this.database,required this.editText,required this.snapshot}) : super(key: key);
  final MyDatabase database;
  final String? editText;
  final AsyncSnapshot<List<TodolistData>>? snapshot;

  
  
  @override
  State<EditPage> createState() => _EditPageState();
}
class _EditPageState extends State<EditPage> {
  final TextEditingController textCon=TextEditingController();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('EDIT'),
      ),
      body: Column(
        children: [
          TextFormField(
            // initialValue:widget.editText ,
            controller: TextEditingController(text: widget.editText),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.plus_one),
        label: Text("Edit ToDo"),
        backgroundColor: (textCon.text=="") ?Colors.black:Colors.red,
        onPressed: ()async{
          if(textCon.text!=null){
            // await widget.database.addTodo(textCon.text);
            await widget.database.updateTodo(widget.snapshot.data![index], textCon.text);
            Navigator.push(context, MaterialPageRoute(builder: (context)=>DriftSample(database: widget.database)));
          }
        },
      ),
    );
  }
}

// onPressed: () async {
// await widget.database.addTodo(
// 'test test test',
// );
// },