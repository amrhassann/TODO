import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/domain/cubit/cubit.dart';
import 'package:todo_app/domain/states/states.dart';
import 'package:todo_app/presentation/res/app_icons.dart';
import 'package:todo_app/presentation/res/colors_manager.dart';
import 'package:todo_app/presentation/res/fonts_manager.dart';
import 'package:todo_app/presentation/res/strings_manager.dart';
import 'package:todo_app/presentation/res/styles_manager.dart';
import 'package:todo_app/presentation/res/values_manager.dart';
import 'package:todo_app/presentation/widgets/no_data.dart';
import 'package:todo_app/presentation/widgets/schedule_item.dart';

class Schedule extends StatelessWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return Scaffold(
      backgroundColor: ColorsManager.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: ColorsManager.appBarBackground,
        elevation: 0.5,
        title: Text(
          AppStrings.schedule,
          style:
              getBoldStyle(color: ColorsManager.black, fontSize: FontSizes.s20),
        ),
        leading: IconButton(
          icon: AppIcons.backIcon,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var tasks = List.from(AppCubit.get(context).dayTasks.reversed);
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p15, vertical: AppPadding.p12),
                child: DatePicker(
                  DateTime.now(),
                  onDateChange: (date) => cubit.changeSelectedDate(date),
                  height: 80,
                  width: 55,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: ColorsManager.green,
                  selectedTextColor: ColorsManager.white,
                  daysCount: 360,
                  dateTextStyle: getMediumStyle(color: ColorsManager.gray, fontSize: FontSizes.s18),
                  dayTextStyle:  getMediumStyle(color: ColorsManager.gray, fontSize: FontSizes.s12),
                  monthTextStyle:  getMediumStyle(color: ColorsManager.gray, fontSize: FontSizes.s12),
                ),
              ),
              const Divider(
                color: ColorsManager.gray,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p20, vertical: AppPadding.p12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('EEEE').format(cubit.selectedDate).toString(),
                      style: getBoldStyle(
                          color: ColorsManager.black, fontSize: FontSizes.s16),
                    ),
                    Text(
                      DateFormat('dd MMMM, yyyy')
                          .format(cubit.selectedDate)
                          .toString(),
                      style: getRegularStyle(
                          color: ColorsManager.black, fontSize: FontSizes.s14),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: tasks.isEmpty
                    ? const NoData(title: 'No Tasks')
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: tasks.length,
                        itemBuilder: (context, index) =>
                            TodayTaskItem(task: tasks[index]),
                        separatorBuilder: (c, i) => const Divider(),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
