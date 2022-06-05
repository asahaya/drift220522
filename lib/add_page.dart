import 'package:drift220522/drift/todolist.dart';
import 'package:drift220522/main.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key, required this.database}) : super(key: key);
  final MyDatabase database;

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController textCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: textCon,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.plus_one),
        label: Text("Add ToDo"),
        backgroundColor: (textCon.text == "") ? Colors.black : Colors.red,
        onPressed: () async {
          if (textCon.text != "") {
            await widget.database.addTodo(textCon.text);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DriftSample(database: widget.database),
              ),
            );
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
