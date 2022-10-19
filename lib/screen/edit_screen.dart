// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:todo/database/database_helper.dart';
//
// import '../model/todo_model.dart';
//
// class EditScreen extends StatefulWidget {
//   final String ? titleController;
//   final String ? descriptionController;
//   final int ? id;
//   const EditScreen({Key? key, this.titleController, this.descriptionController, this.id}) : super(key: key);
//
//   @override
//   State<EditScreen> createState() => _EditScreenState();
// }
//
// class _EditScreenState extends State<EditScreen> {
//
//
//    Random random = Random();
//    DbHelper _dbHelper = DbHelper();
//
//   final title = TextEditingController();
//   final des = TextEditingController();
//
//   @override
//   void initState() {
//     setState(() {
//       title.text = widget.titleController!;
//       des.text = widget.descriptionController!;
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.purple,
//         title: Text("Edit Screen"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             SizedBox(height: 40,),
//
//
//             Padding(
//               padding: const EdgeInsets.only(left: 28.0,right: 28),
//               child: TextField(
//
//                 controller: title,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: "Title",
//                   label: Text("Title"),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 28.0,right: 28,top: 20),
//               child: TextField(
//                 controller: des,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//
//                   hintText: "Des",
//                   label: Text("Des"),
//                 ),
//               ),
//             ),
//
//             SizedBox(height: 40,),
//             Center(
//               child: ElevatedButton(
//                 onPressed: () async {
//
//
//                   var todoModel = TodoModel(
//                       id: widget.id!,
//                       title: title.text,
//                       description: des.text,
//                       dateTime: DateFormat().add_jm().format(DateTime.now()));
//                   await _dbHelper.updateTodo(todoModel);
//                   Navigator.pop(context,true);
//                   setState(() {
//
//                   });
//
//                 },
//                 child: Text("Submit"),
//                 style: ElevatedButton.styleFrom(primary: Colors.purple),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }



  import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/database/database_helper.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/screen/todo_screen.dart';

class EditScreen extends StatefulWidget {
  final int ? id;
  final String ? title;
  final String ? description;

  const EditScreen({super.key, this.id, this.title, this.description});



  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {

   final DbHelper _dbHelper = DbHelper();

    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();


  @override
  void initState() {
    titleController.text = widget.title!;
    descriptionController.text = widget.description!;
    setState(() {

    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Edit Screen"),
      ),
      body: Column(
        children: [


          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              controller:titleController,
              decoration: InputDecoration(
                hintText: "Title",
                  labelText: "Title",
                border: OutlineInputBorder()
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                  hintText: "Description",
                  labelText: "Description",
                  border: OutlineInputBorder()
              ),
            ),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.purple),
              onPressed: () async{

              var updateTodo = TodoModel(
                id:widget.id!,
                title: titleController.text,
                description: descriptionController.text,
                dateTime: DateFormat().add_jm().format(DateTime.now()),
              );


              await  _dbHelper.updateTodo(updateTodo);
              Navigator.pop(context,true);
              // Navigator.push(context, MaterialPageRoute(builder: (_)=> TodoScreen()));
              setState(() {

              });

              }, child: Text("Update Todo"))

        ],
      ),
    );
  }
}
