



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
