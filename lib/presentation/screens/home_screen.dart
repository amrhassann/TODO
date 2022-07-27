import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
import 'package:todo_app/domain/cubit/cubit.dart';
import 'package:todo_app/domain/states/states.dart';
import 'package:todo_app/presentation/res/app_icons.dart';
import 'package:todo_app/presentation/res/colors_manager.dart';
import 'package:todo_app/presentation/res/fonts_manager.dart';
import 'package:todo_app/presentation/res/statusbar.dart';
import 'package:todo_app/presentation/res/strings_manager.dart';
import 'package:todo_app/presentation/res/styles_manager.dart';
import 'package:todo_app/presentation/screens/add_task.dart';
import 'package:todo_app/presentation/screens/all.dart';
import 'package:todo_app/presentation/screens/completed.dart';
import 'package:todo_app/presentation/screens/favorite.dart';
import 'package:todo_app/presentation/screens/schedule.dart';
import 'package:todo_app/presentation/screens/uncompleted.dart';
import 'package:todo_app/presentation/widgets/default_button.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    ToastContext().init(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is DeleteTaskState){
          Toast.show("Task Deleted", duration: Toast.lengthShort, gravity:  Toast.center,backgroundColor: ColorsManager.red);
        }
        if(state is UpdateTaskState){
          Toast.show("Task Updated", duration: Toast.lengthShort, gravity:  Toast.center,backgroundColor: ColorsManager.gray);
        }
      },
      builder: (context, state) {
        defaultStatusBar();
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            backgroundColor: ColorsManager.scaffoldBackground,
            appBar: AppBar(
              backgroundColor: ColorsManager.appBarBackground,
              elevation: 0.5,
              title: Text(
                AppStrings.appbarTitle,
                style: getBoldStyle(
                    color: ColorsManager.black, fontSize: FontSizes.s20),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (C)=>Schedule()));
                    },
                    icon: AppIcons.scheduleIcon)
              ],
              bottom: TabBar(
                unselectedLabelColor: ColorsManager.lightGray4,
                labelColor: ColorsManager.darkGray2,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: ColorsManager.black,
                tabs: const [
                  Tab(
                    text: AppStrings.all,
                  ),
                  Tab(
                    text: AppStrings.completed,
                  ),
                  Tab(
                    text: AppStrings.unCompleted,
                  ),
                  Tab(
                    text: AppStrings.favorite,
                  ),
                ],
              ),
            ),
            body: const TabBarView(
              physics: BouncingScrollPhysics(),
              children: [
                All(),
                Completed(),
                UnCompleted(),
                Favorite(),
              ],
            ),
            bottomSheet: Padding(
              padding: const EdgeInsets.all(25.0),
              child: DefaultButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (c)=>AddTaskScreen()));
                },
                label: AppStrings.addATask,
                width: deviceWidth,
              ),
            ),
          ),
        );
      },
    );
  }
}
