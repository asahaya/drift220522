import 'package:drift220522/drift/todolist.dart';
import 'package:drift220522/main.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key,required this.database,required this.editText,required this.index}) : super(key: key);
  final MyDatabase database;
  final String? editText;
  final int? index;



  @override
  State<EditPage> createState() => _EditPageState();
}
class _EditPageState extends State<EditPage> {
  final TextEditingController textCon=TextEditingController();


  @override
  void initState() {
    super.initState();
   final textCon= TextEditingController(text: widget.editText);
  }

  @override
  Widget build(BuildContext context) {

    final controller=TextEditingController();
    controller.text=widget.editText??"";

    return Scaffold(
      appBar: AppBar(
        title: Text('EDIT'),
      ),
      body: Column(
        children: [
          TextFormField(
            // initialValue:widget.editText ,
            controller: controller,
          )
        ],
      ),
      floatingActionButton: StreamBuilder(
        stream: widget.database.watchEntries(),
          builder: (BuildContext context,
              AsyncSnapshot<List<TodolistData>> snapshot) {
          return FloatingActionButton.extended(
            icon: Icon(Icons.plus_one),
            label: Text("Edit ToDo"),
            backgroundColor: (textCon.text=="") ?Colors.black:Colors.red,
            onPressed: ()async{
              if(textCon.text!=null){
                // await widget.database.addTodo(textCon.text);
                await widget.database.updateTodo(snapshot.data![widget.index!],controller.text);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DriftSample(database: widget.database)));
              }
            },
          );
        }
      ),
    );
  }
}

// onPressed: () async {
// await widget.database.addTodo(
// 'test test test',
// );
// },