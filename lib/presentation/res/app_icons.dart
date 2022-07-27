import 'package:flutter/material.dart';
import 'package:todo_app/presentation/res/colors_manager.dart';
class AppIcons {
  AppIcons._();

  static Widget scheduleIcon = const Icon(Icons.calendar_today_rounded, color: ColorsManager.green,);
  static Widget timeIcon = const Icon(Icons.access_time_rounded, color: ColorsManager.iconsColor,);
  static Widget deadlineIcon = const Icon(Icons.keyboard_arrow_down_rounded, color: ColorsManager.iconsColor,);
  static Widget remindIcon = const Icon(Icons.alarm, color: ColorsManager.iconsColor,);
  static Widget repeatIcon = const Icon(Icons.replay, color: ColorsManager.iconsColor,);
  static Widget notFavTaskIcon =  Icon(Icons.favorite_border, color: ColorsManager.iconsLightColor,);
  static Widget favTaskIcons = const Icon(Icons.favorite, color: ColorsManager.orange,);
  static Widget whiteFavTaskIcons = const Icon(Icons.favorite, color: ColorsManager.white,);
  static Widget backIcon = const Icon(Icons.arrow_back_ios, color: ColorsManager.black,size: 16,);

}