import 'package:hive/hive.dart';

class HomeToDoDataBase {
  List toDoList = [];

  final _homeMyBox = Hive.box('homemybox');

  void createInitialData(){
    toDoList = [
      ['Swipe to delete', false, DateTime.now()],
      ['Click Add button to add new task', false, DateTime.now()],
    ];
  }

  void loadData() {
    // Make sure all tasks have 3 elements [taskName, taskCompleted, dueDate]
    toDoList = _homeMyBox.get('TODOLIST', defaultValue: []).map((task) {
      if (task.length < 3) {
        return [task[0], task[1], DateTime.now()]; // Add a default due date if missing
      }
      return task;
    }).toList();
  }


  void updateData(){
    _homeMyBox.put('TODOLIST', toDoList);
  }

}

class PersonalToDoDataBase {
  List toDoList = [];

  final _personalMyBox = Hive.box('personalmybox');

  void createInitialData(){
    toDoList = [
      ['Swipe to delete', false, DateTime.now()],
      ['Click Add button to add new task', false, DateTime.now()],
    ];
  }

  void loadData() {
    // Make sure all tasks have 3 elements [taskName, taskCompleted, dueDate]
    toDoList = _personalMyBox.get('TODOLIST', defaultValue: []).map((task) {
      if (task.length < 3) {
        return [task[0], task[1], DateTime.now()]; // Add a default due date if missing
      }
      return task;
    }).toList();
  }


  void updateData(){
    _personalMyBox.put('TODOLIST', toDoList);
  }

}

class WorkToDoDataBase {
  List toDoList = [];

  final _workMyBox = Hive.box('workmybox');

  void createInitialData(){
    toDoList = [
      ['Swipe to delete', false, DateTime.now()],
      ['Click Add button to add new task', false, DateTime.now()],
    ];
  }

  void loadData() {
    // Make sure all tasks have 3 elements [taskName, taskCompleted, dueDate]
    toDoList = _workMyBox.get('TODOLIST', defaultValue: []).map((task) {
      if (task.length < 3) {
        return [task[0], task[1], DateTime.now()]; // Add a default due date if missing
      }
      return task;
    }).toList();
  }


  void updateData(){
    _workMyBox.put('TODOLIST', toDoList);
  }

}