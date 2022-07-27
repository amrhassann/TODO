import 'package:flutter/services.dart';
import 'package:todo_app/presentation/res/colors_manager.dart';

defaultStatusBar(){
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: ColorsManager.white,
      statusBarIconBrightness: Brightness.light,
    ),
  );
}