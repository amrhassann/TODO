import 'package:flutter/material.dart';
import 'package:todo_app/domain/cubit/cubit.dart';
import 'package:todo_app/presentation/res/app_icons.dart';
import 'package:todo_app/presentation/res/colors_manager.dart';
import 'package:todo_app/presentation/res/fonts_manager.dart';
import 'package:todo_app/presentation/res/styles_manager.dart';
import 'package:todo_app/presentation/res/values_manager.dart';
import 'package:todo_app/presentation/widgets/custom_check_box.dart';
import 'package:todo_app/presentation/widgets/delete_dialog.dart';

class TodayTaskItem extends StatelessWidget {
  TodayTaskItem({Key? key, required this.task}) : super(key: key);
  final Map<dynamic, dynamic> task;
  String status = '';

  @override
  Widget build(BuildContext context) {
    // this statements helps to know task status easily
    if (task['status'] == 'done') {
      status = 'done';
    } else if (task['status'] == 'new') {
      status = 'new';
    } else if (task['status'] == 'archived') {
      status = 'archived';
    }

    // now we can manage task color depend on status and fav
    return InkWell(
      onLongPress: (){
        buildShowDialog(context : context , id: task['id']);
      },
      onDoubleTap: (){
        buildShowDialog(context : context , id: task['id']);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: AppMargin.m20, vertical: AppMargin.m3),
        padding: const EdgeInsets.all(AppPadding.p12),
        decoration: BoxDecoration(
          color: Color(task['color']),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomCheckBox(task: task, status: status, radius: 20.0, colorValue: 0xffffffff,checkColorValue: task['color'],),
            const SizedBox(
              width: 5,
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  task['time'],
                  style: getSemiBoldStyle(
                    color: ColorsManager.white,
                    fontSize: FontSizes.s16,
                  ),
                ),
                Text(
                  task['title'],
                  style: getRegularStyle(
                    color: ColorsManager.white,
                    fontSize: FontSizes.s18,
                  ),
                ),

              ],
            ),



            const Spacer(),
            IconButton(
              icon: task['fav'] == 'favorite'
                  ? AppIcons.whiteFavTaskIcons
                  : AppIcons.notFavTaskIcon,
              onPressed: () {
                if (task['fav'] == 'unFavorite') {
                  AppCubit.get(context)
                      .updateFav(fav: 'favorite', id: task['id']);
                } else {
                  AppCubit.get(context)
                      .updateFav(fav: 'unFavorite', id: task['id']);
                }
              },
            )
          ],
        ),
      ),
    );
  }


}