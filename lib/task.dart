import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  const Task({Key? key}) : super(key: key);

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            
          },
        ),
          backgroundColor:  const Color(0XFF4C53FF),
          title: const Text(
            'Task',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Task Name',
                labelStyle: TextStyle(
                  color:Colors.grey,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                floatingLabelStyle: TextStyle(
                  color:  const Color(0XFF4C53FF),
                  fontSize: 15.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color:  const Color(0XFF4C53FF), width: 1.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                helperText:
                    "This is the name of your task",
                alignLabelWithHint: true,
                helperStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
               maxLines: 8,
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(
                  color:Colors.grey,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                floatingLabelStyle: TextStyle(
                  color:  const Color(0XFF4C53FF),
                  fontSize: 15.0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color:  const Color(0XFF4C53FF), width: 2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                helperText:
                    "Get your members on board with a few words  about your Workspace.",
                alignLabelWithHint: true,
                helperStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),

              ),
              
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              child: const Text('Save'),
            ),
          ]),
        )));
  }
}
