import 'package:flutter/material.dart';
import 'package:todo_app/domain/cubit/cubit.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({
    Key? key,
    required this.task,
    required this.status,
    required this.colorValue,
    required this.radius,
    required this.checkColorValue
  }) : super(key: key);

  final Map task;
  final String status;
  final double radius;
  final int colorValue;
  final int checkColorValue;


  @override
  Widget build(BuildContext context) {
    return Checkbox(
        fillColor: MaterialStateProperty.all(Color(colorValue)),
        side: BorderSide(
          color: Color(colorValue),
          width: 1.3,
        ),
        checkColor: Color(checkColorValue),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius)),
        value: status == 'done',
        onChanged: (bool? value) {
          // user can make mark the task 'completed' or 'uncompleted' by pressing on the checkbox
          if (task['status'] == 'new') {
            AppCubit.get(context)
                .updateStatus(status: 'done', id: task['id']);
          } else if (task['status'] == 'done') {
            AppCubit.get(context)
                .updateStatus(status: 'new', id: task['id']);
          }
        });
  }
}