import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/cubit/cubit.dart';
import 'package:todo_app/domain/states/states.dart';
import 'package:todo_app/presentation/widgets/no_data.dart';
import 'package:todo_app/presentation/widgets/task_item.dart';


class Favorite extends StatelessWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, AppStates state) {},
        builder: (context, AppStates state) {
          // here we reverse the list of tasks to display new tasks on the top
          var tasks = List.from(AppCubit.get(context).favTasks.reversed);
          return tasks.isEmpty
              ? const NoData(
            title: 'No Favorite Tasks',
          )
              : Padding(
            padding: EdgeInsets.only(
              // this padding here cuz we have a bottomSheet that hide some content under
                bottom: MediaQuery.of(context).size.height / 7 - 20),
            child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: tasks.length,
                itemBuilder: (BuildContext context, index) {
                  return TaskItem(
                    task: tasks[index],
                  );
                }),
          );
        });
  }
}
