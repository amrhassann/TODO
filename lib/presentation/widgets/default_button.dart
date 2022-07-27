import 'package:flutter/material.dart';
import 'package:todo_app/presentation/res/colors_manager.dart';
import 'package:todo_app/presentation/res/fonts_manager.dart';
import 'package:todo_app/presentation/res/styles_manager.dart';


class DefaultButton extends StatelessWidget {
  const DefaultButton({Key? key, required this.onPressed, required this.label, required this.width , this.backgroundColor = ColorsManager.green})
      : super(key: key);

  final void Function() onPressed;
  final String label;
  final double width;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onPressed,
      child: Container(
        height: 45,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Center(
          child: Text(
            label,
            style: getRegularStyle(color: ColorsManager.white, fontSize: FontSizes.s16),
          ),
        ),
      ),
    );
  }
}
