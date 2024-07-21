import "package:flutter/material.dart";
import 'package:flutter_ogreniyorum/constants/colors.dart';
import 'package:flutter_ogreniyorum/constants/tasktype.dart';
import 'package:flutter_ogreniyorum/model/task.dart';
import 'package:flutter_ogreniyorum/screens/add_new_task.dart';
import 'package:flutter_ogreniyorum/todoitem.dart';
import 'package:hexcolor/hexcolor.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<Task> todo = [
    Task(
        title: "Study Lesson",
        description: "Study COMP101",
        isCompleted: false,
        type: TaskType.note),
  ];

  List<Task> completed = [
    Task(
        title: "Homework",
        description: "Finish your homework",
        isCompleted: false,
        type: TaskType.contest),
    Task(
        title: "Walk your doggo",
        description: "Go for a walk wth rocky",
        isCompleted: false,
        type: TaskType.calendar),
  ];

  void addNewTask(Task newTask) {
    setState(() {
      todo.add(newTask);
    });
  }

  void moveTaskToCompleted(Task task) {
    setState(() {
      task.isCompleted = true;
      todo.remove(task);
      completed.add(task);
    });
  }

  void moveTaskToTodoList(Task task) {
    setState(() {
      task.isCompleted = false;
      completed.remove(task);
      todo.add(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: HexColor(backgroundColor),
          body: Column(
            children: [
              //Header
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("lib/assets/images/header.png"),
                      fit: BoxFit.cover),
                ),
                width: deviceWidth,
                height: deviceHeight / 3,
                child: const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Text(
                        "October 20, 2024",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Text(
                        "My To Do List",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //Top Column
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: todo.length,
                      itemBuilder: (context, index) {
                        return TodoItem(
                          task: todo[index],
                          onTaskStatusChanged: () {
                            moveTaskToCompleted(todo[index]);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),

              //Completed Text
              const Padding(
                padding: EdgeInsets.only(
                  left: 20,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Completed",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              //Bottom Column
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: completed.length,
                      itemBuilder: (context, index) {
                        return TodoItem(
                          task: completed[index],
                          onTaskStatusChanged: () {
                            moveTaskToTodoList(completed[index]);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),

              //Bottom Button
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddNewTaskScreen(
                        addNewTask: (newTask) => addNewTask(newTask),
                      ),
                    ),
                  );
                },
                child: const Text("Add New Task"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
