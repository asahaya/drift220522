// import 'package:drift220522/drift/todolist.dart';
// import 'package:flutter/material.dart';
//
// class ListItemWid extends StatelessWidget {
//   const ListItemWid({
//     required this.todolist,
//     required this.onClicked,
//     Key? key,
//   }) : super(key: key);
//   final Todolist todolist;
//   final VoidCallback? onClicked;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         color: Colors.white,
//       ),
//       child: ListTile(
//         contentPadding: EdgeInsets.all(16),
//         leading: Container(
//           decoration: BoxDecoration(
//             color: Colors.greenAccent,
//           ),
//           child: Text(todolist.content.toString()),
//         ),
//         title: Text(todolist.content.toString()),
//         trailing: IconButton(
//           icon: Icon(
//             Icons.delete,
//             color: Colors.red,
//             size: 32,
//           ),
//           onPressed: onClicked,
//         ),
//       ),
//     );
//   }
// }
