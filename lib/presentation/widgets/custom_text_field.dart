
import 'package:flutter/material.dart';
import 'package:todo_app/presentation/res/colors_manager.dart';
import 'package:todo_app/presentation/res/fonts_manager.dart';
import 'package:todo_app/presentation/res/styles_manager.dart';
import 'package:todo_app/presentation/res/values_manager.dart';


class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.hint,
    required this.label,
    required this.textFieldController,
    this.textInputType = TextInputType.text,
    this.readOnly = true,
    this.onTap,
    this.suffixIcon,
    this.mandatory = true,
  }) : super(key: key);

  final String hint;
  final String label;
  final TextEditingController textFieldController;
  final TextInputType textInputType;
  final bool readOnly;
  final Function()? onTap;
  final Widget? suffixIcon;
  final bool mandatory;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: getSemiBoldStyle(color: ColorsManager.black, fontSize: FontSizes.s16),),
          const SizedBox(height: AppSize.s8,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextFormField(
              readOnly: readOnly,
              controller: textFieldController,
              keyboardType: textInputType ,
              onTap: onTap,
              onFieldSubmitted: (value){
                FocusScope.of(context).requestFocus( FocusNode());
              },

              validator: mandatory?(value){
                if (value == null || value.isEmpty) {
                  return "$label is Required";
                }
                return null;
              }:noValidate(),
              style: getRegularStyle(color: ColorsManager.black, fontSize: FontSizes.s16),
              decoration: getTextFieldStyle(hintText: hint,suffixIcon:suffixIcon ),
            ),
          ),
        ],
      ),
    );
  }
  noValidate(){}
}
