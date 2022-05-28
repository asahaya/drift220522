import 'package:drift220522/add_page.dart';
import 'package:drift220522/drift/todolist.dart';
import 'package:drift220522/edit_page.dart';
import 'package:flutter/material.dart';

void main() {
  final database = MyDatabase();
  runApp(MyApp(
    database: database,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.database}) : super(key: key);
  final MyDatabase database;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DriftSample(
        database: database,
      ),
    );
  }
}

class DriftSample extends StatefulWidget {
  const DriftSample({Key? key, required this.database}) : super(key: key);
  final MyDatabase database;

  @override
  State<DriftSample> createState() => _DriftSampleState();
}

class _DriftSampleState extends State<DriftSample> {
  final listKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO-DRIFT'),
        backgroundColor: Colors.cyan,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: StreamBuilder(
                stream: widget.database.watchEntries(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<TodolistData>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                      key: listKey,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    snapshot.data![index].content,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                ],
                              ),
                              onLongPress: () async {
                                final list =
                                    await widget.database.allTodoEntries;
                                if (list.isNotEmpty) {
                                  await widget.database.deleteTodo(list[index]);
                                }
                              },
                              onPressed: () async {
                                final list =
                                    await widget.database.allTodoEntries;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditPage(
                                            database: widget.database,
                                            editText:
                                            snapshot.data![index].content,
                                           snapshot: snapshot,

                                        )));
                              },
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Expanded(
                //   child: Padding(
                //       padding: const EdgeInsets.all(8),
                //       child: ElevatedButton(
                //         child: const Text('Add'),
                //         onPressed: () async {
                //           await widget.database.addTodo(
                //             'test test test',
                //           );
                //         },
                //       )),
                // ),
                // Expanded(
                //   child: Padding(
                //       padding: const EdgeInsets.all(8),
                //       child: ElevatedButton(
                //         child: const Text('Remove'),
                //         onPressed: () async {
                //           final list = await widget.database.allTodoEntries;
                //           if (list.isNotEmpty) {
                //             await widget.database
                //                 .deleteTodo(list[list.length - 1]);
                //           }
                //         },
                //       )),
                // ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.animation),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddPage(database: widget.database)),
          );
        },
      ),
    );
  }
}
