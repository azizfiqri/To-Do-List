import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_keeper_getx/controllers/note_controller.dart';
import 'package:notes_keeper_getx/screens/insert_note_screen.dart';
import 'package:notes_keeper_getx/screens/update_note_sceen.dart';

import '../temes_service.dart';

class HomeScreen extends StatelessWidget {
  final noteController = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do List"),
        // automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: ThemeService().switchTheme,
            icon: Icon(Icons.settings),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            () => CreateNoteScreen(),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              child: Text(
                "${noteController.day} , ${noteController.date} ${noteController.month} ${noteController.year} ",
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: StreamBuilder<QuerySnapshot>(
                            stream: noteController.notesStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var data = snapshot.data.docs;
                                return Text(
                                  data.length.toString(),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                        Text(
                          "Created Task",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: StreamBuilder<QuerySnapshot>(
                            stream: noteController.notesStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var data = snapshot.data.docs;
                                var totalCompleted = 0;
                                data.forEach((element) {
                                  if (element["completed"] == true) {
                                    totalCompleted++;
                                  }
                                });
                                return Text(
                                  totalCompleted.toString(),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                        Text(
                          "Completed Task",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.end,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40.0,
            ),
            Divider(),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: noteController.notesStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data.docs;
                    return ListView.builder(
                      itemBuilder: (context, i) {
                        return ListTile(
                          title: Text(
                            data[i]["text"],
                            style: data[i]["completed"] == true
                                ? TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.lineThrough,
                                  )
                                : TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Get.to(() => UpdateNoteScreen(), arguments: [
                                    data[i].reference,
                                    data[i]["text"],
                                    data[i]["desc"],
                                  ]);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  noteController.deleteNote(data[i].reference);
                                },
                              ),
                            ],
                          ),
                          leading: Checkbox(
                            shape: CircleBorder(),
                            value: data[i]["completed"] == true ? true : false,
                            onChanged: (val) {
                              noteController.toggleTask(
                                data[i].reference,
                                data[i]["completed"],
                              );
                            },
                            checkColor: Colors.white,
                            activeColor: Colors.green,
                          ),
                        );
                      },
                      itemCount: data.length,
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
