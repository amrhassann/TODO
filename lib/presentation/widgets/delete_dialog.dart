import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/domain/cubit/cubit.dart';
import 'package:todo_app/presentation/res/colors_manager.dart';
import 'package:todo_app/presentation/res/fonts_manager.dart';
import 'package:todo_app/presentation/res/styles_manager.dart';
import 'package:todo_app/presentation/res/values_manager.dart';
import 'package:todo_app/presentation/widgets/default_button.dart';

Future<dynamic> buildShowDialog(
    {required BuildContext context, required int id}) {
  var deviceWidth = MediaQuery.of(context).size.width;
  var deviceHeight = MediaQuery.of(context).size.height;

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          content: Container(
            padding: const EdgeInsets.all(AppPadding.p20),
            height: deviceHeight * .42,
            width: deviceWidth,
            child: Column(
              children: [
                Lottie.asset('assets/json/delete.json',
                    repeat: true, height: deviceHeight * .15),
                Text(
                  'Confirm Delete',
                  style: getSemiBoldStyle(
                      color: ColorsManager.red, fontSize: FontSizes.s18),
                ),
                const SizedBox(
                  height: AppSize.s25,
                ),
                Text(
                  "Do you want to delete this task?",
                  style: getRegularStyle(
                      color: ColorsManager.black, fontSize: FontSizes.s16),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(
                                ColorsManager.lightGray1)),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Cancel',
                          style: getMediumStyle(
                              color: ColorsManager.black,
                              fontSize: FontSizes.s16),
                        )),
                    DefaultButton(
                      onPressed: () {
                        AppCubit.get(context).deleteTask(id: id);
                        Navigator.pop(context);
                      },
                      label: 'Delete',
                      width: deviceWidth * .3,
                      backgroundColor: ColorsManager.red,
                    )
                  ],
                )
              ],
            ),
          ),
        );
      });
}
