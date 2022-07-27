import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/cubit/cubit.dart';
import 'package:todo_app/domain/states/states.dart';
import 'package:todo_app/presentation/res/colors_manager.dart';
import 'package:todo_app/presentation/res/fonts_manager.dart';
import 'package:todo_app/presentation/res/styles_manager.dart';
import 'package:todo_app/presentation/res/values_manager.dart';

class SelectColor extends StatelessWidget {
  const SelectColor({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Color',
            style: getSemiBoldStyle(
                color: ColorsManager.black,
                fontSize: FontSizes.s16),
          ),
          const SizedBox(
            height: AppSize.s8,
          ),
          BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return SizedBox(
                height: 30,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: AppCubit.get(context).colors.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        AppCubit.get(context).selectColor(index);
                      },
                      child: Container(
                        height: AppCubit.get(context)
                            .selectedColor ==
                            AppCubit.get(context).colors[index]
                            ? 50
                            : 30,
                        width: AppCubit.get(context)
                            .selectedColor ==
                            AppCubit.get(context).colors[index]
                            ? 50
                            : 30,
                        decoration: BoxDecoration(
                          color: Color(
                              AppCubit.get(context).colors[index]),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (c, i) => const SizedBox(
                    width: 10,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}