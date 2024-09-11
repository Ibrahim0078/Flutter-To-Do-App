import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final DateTime? dueDate;  // Add due date
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  Function(BuildContext)? updateFunction;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    this.dueDate,
    required this.onChanged,
    required this.deleteFunction,
    required this.updateFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: updateFunction,
              icon: Icons.edit,
              backgroundColor: Colors.yellow.shade400,
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.zero,
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.zero,
              ),
            ),
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade400,
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.zero,
                topRight: Radius.circular(12),
                bottomLeft: Radius.zero,
                bottomRight: Radius.circular(12),
              ),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: taskCompleted,
                    onChanged: onChanged,
                    activeColor: Colors.white,
                    checkColor: Colors.lightBlue,
                    side: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      taskName,
                      style: TextStyle(
                        fontSize: 15,
                        decoration: taskCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              if (dueDate != null)
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 2.0, right: 0.0, bottom: 0.0),
                  child: Text(
                    'Due: ${DateFormat.yMMMd().format(dueDate!)}',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
