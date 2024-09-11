import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/data/database.dart';
import '../util/todo_tile.dart';
import '../util/dialog_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeMyBox = Hive.box('homemybox');
  HomeToDoDataBase db = HomeToDoDataBase();
  DateTime? _selectedDueDate;

  @override
  void initState() {
    if (_homeMyBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false, _selectedDueDate ?? DateTime.now()]);
      _controller.clear();
      _selectedDueDate = null;
    });
    Navigator.of(context).pop();
    db.updateData();
  }


  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
          onDueDatePicked: (date) {
            _selectedDueDate = date;
          },
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateData();
  }

  void updateExistingTask(int index) {
    setState(() {
      db.toDoList[index][0] = _controller.text;
      db.toDoList[index][2] = _selectedDueDate;  // Update due date
      _controller.clear();
      _selectedDueDate = null;
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  void updateTask(int index) {
    _controller.text = db.toDoList[index][0];  // Pre-fill task name for editing
    _selectedDueDate = db.toDoList[index][2];  // Pre-fill due date for editing
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: () {
            updateExistingTask(index);
          },
          onCancel: () => Navigator.of(context).pop(),
          onDueDatePicked: (date) {
            _selectedDueDate = date;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('TO DO'),
        centerTitle: true,
        elevation: 5,
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.white,
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            dueDate: db.toDoList[index].length > 2 ? db.toDoList[index][2] : null,  // Check if due date exists
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
            updateFunction: (context) => updateTask(index),
          );

        },
      ),
    );
  }
}
