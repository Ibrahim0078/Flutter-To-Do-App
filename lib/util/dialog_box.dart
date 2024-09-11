import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DialogBox extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final Function(DateTime?) onDueDatePicked;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
    required this.onDueDatePicked,
  });

  @override
  _DialogBoxState createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  DateTime? _selectedDate;

  Future<void> _pickDueDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.lightBlue,
              onPrimary: Colors.white,
              onSurface: Colors.lightBlue,
            ),
            dialogBackgroundColor: Colors.lightBlueAccent,
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
      widget.onDueDatePicked(_selectedDate);  // Pass selected date to parent
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.lightBlueAccent,
      content: Container(
        height: 215,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: widget.controller,
                decoration: InputDecoration(
                  hintText: 'Enter task',
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 10),
            Column(
              children: [
                Text(
                  _selectedDate == null
                      ? 'No due date chosen'
                      : 'Due Date: ${DateFormat.yMMMd().format(_selectedDate!)}',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => _pickDueDate(context),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.lightBlue),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: Text('Pick Due Date',),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: widget.onSave,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.lightBlue),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: Text('Save'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: widget.onCancel,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.lightBlue),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
