import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/database/database_helper.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/screen/edit_screen.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  bool loader = false;
  final DbHelper _dbHelper = DbHelper();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  
  Random random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          inputDialouge();
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 5,
        title: Text("Todo"),
      ),
      body: Container(
        child:  loader ? Center(child: CircularProgressIndicator(color: Colors.purple,),): FutureBuilder(
          future: _dbHelper.getTodoModel(),
          builder:
              (BuildContext context, AsyncSnapshot<List<TodoModel>?> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Something went Wrong"),
              );
            } else {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 5,
                        child: ListTile(
                          onTap: () async{
                   var data = await         Navigator.push(context, MaterialPageRoute(builder: (_)=> EditScreen(
                              id: snapshot.data![index].id ,
                              title:snapshot.data![index].title ,
                              description:snapshot.data![index].description ,
                            )));

                   if(data!=null){
                     if(data==true){
                      setState(() {
                        _dbHelper.getTodoModel();
                      });
                     }
                   }
                          },

                       //    onTap: () {
                       //
                       //      // showDialog(context: context, builder: (_){
                       //      //   return AlertDialog(
                       //      //     title: Text("Delete!"),
                       //      //   );
                       //      // });
                       //      //
                       //      _dbHelper.delete(snapshot.data![index].id!);
                       //      setState(() {
                       //
                       //      });
                       //
                       //
                       // // var data = await    Navigator.push(context, MaterialPageRoute(builder: (_)=> EditScreen(
                       // //        titleController: snapshot.data![index].title,
                       // //        descriptionController: snapshot.data![index].description,
                       // //        id: snapshot.data![index].id,
                       // //      )));
                       // // if(data!=null){
                       // //   if(data==true){
                       // //     setState(() {
                       // //       _dbHelper.getTodoModel();
                       // //     });
                       // //   }
                       // // }
                       //    },
                          trailing:  Column(
                            children: [
                              Text("${snapshot.data![index].dateTime}"),
                              SizedBox(height: 10,),
                              InkWell(
                                onTap: (){

                                  showDialog(context: context, builder: (context){
                                    return AlertDialog(
                                      title: Text("Delete"),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("Are you sure want to delete?"),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              ElevatedButton(

                                                style: ElevatedButton.styleFrom(primary: Colors.red),

                                                  onPressed: (){
                                                _dbHelper.delete(snapshot.data![index].id!);
                                                Navigator.pop(context);

                                                setState(() {

                                                });
                                              }, child: Text("Yes")),
                                              SizedBox(width: 20,),
                                              ElevatedButton(onPressed: (){
                                                Navigator.pop(context);
                                              }, child: Text("No")),
                                              SizedBox(width: 20,),

                                            ],
                                          ),

                                        ],
                                      ),
                                    );
                                  });

                                },
                                  child: Icon(Icons.delete,color: Colors.red,)),
                            ],
                          ),
                          // Column(
                          //   children: [
                          //
                          //     SizedBox(height: 10,),
                          //
                          //     // GestureDetector(
                          //     //   onTap: (){
                          //     //     setState(() {
                          //     //       _dbHelper.deleteTodo(snapshot.data![index].id!);
                          //     //
                          //     //     });
                          //     //   },
                          //     //     child: Icon(Icons.delete,color: Colors.red,)),
                          //   ],
                          // ),
                          title: Text("${snapshot.data![index].title}"),
                          subtitle:
                              Text("${snapshot.data![index].description}"),
                        ),
                      ),
                    );
                  },
                );
              }
            }
            return Container();
          },
        ),
      ),
    );
  }

  inputDialouge() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: "Title",
                      label: Text("Title"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8, top: 20),
                  child: TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: "Description",
                      label: Text("Description"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      loader = true;
                    });

                    var todoModel = TodoModel(
                        id: random.nextInt(100),
                        title: titleController.text,
                        description: descriptionController.text,
                        dateTime: DateFormat().add_jm().format(DateTime.now()));
                    await _dbHelper.addTodo(todoModel);
                    Navigator.pop(context);
                    titleController.clear();
                    descriptionController.clear();
                    setState(() {
                      loader = false;
                    });
                  },
                  child: Text("Submit"),
                  style: ElevatedButton.styleFrom(primary: Colors.purple),
                )
              ],
            ),
          );
        });
  }
}
