import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'package:todo_app/domain/cubit/cubit.dart';
import 'package:todo_app/domain/states/states.dart';
import 'package:todo_app/presentation/res/app_icons.dart';
import 'package:todo_app/presentation/res/colors_manager.dart';
import 'package:todo_app/presentation/res/fonts_manager.dart';
import 'package:todo_app/presentation/res/strings_manager.dart';
import 'package:todo_app/presentation/res/styles_manager.dart';
import 'package:todo_app/presentation/res/values_manager.dart';
import 'package:todo_app/presentation/widgets/color_selector.dart';
import 'package:todo_app/presentation/widgets/custom_text_field.dart';
import 'package:todo_app/presentation/widgets/default_button.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({Key? key}) : super(key: key);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _deadLineController = TextEditingController();
  final TextEditingController _startTime = TextEditingController();
  final TextEditingController _endTime = TextEditingController();
  final TextEditingController _remind = TextEditingController();
  final TextEditingController _repeat = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String selectedRemind = '';
  String selectedRepeat = '';

  List<String> remindValues = [
    'at the time'
        '10',
    '15',
    '20',
    '30',
    '40',
    '45',
    '50',
    '60',
  ];

  List<String> repeatValues = [
    "Don't Repeat",
    'Weekly',
    'Monthly',
    'Yearly',
  ];
  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorsManager.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: ColorsManager.appBarBackground,
        elevation: 0.5,
        title: Text(
          AppStrings.addTask,
          style:
              getBoldStyle(color: ColorsManager.black, fontSize: FontSizes.s20),
        ),
        leading: IconButton(
          icon: AppIcons.backIcon,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(
            // this padding here cuz we have a bottomSheet that hide some content under
            bottom: MediaQuery.of(context).size.height / 7 - 20,
            top: AppPadding.p15,
            left: AppPadding.p15,
            right: AppPadding.p15),
        width: double.maxFinite,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  readOnly: false,
                  textFieldController: _titleController,
                  hint: 'Design team meeting',
                  label: 'Title',
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                CustomTextField(
                  textFieldController: _deadLineController,
                  hint: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                  suffixIcon: AppIcons.deadlineIcon,
                  label: 'Deadline',
                  onTap: () {
                    showDatePicker(
                      builder: (theme, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: ColorsManager
                                  .green, // header background color
                              onPrimary:
                                  ColorsManager.white, // header text color
                              onSurface: ColorsManager.black, // body text color
                            ),
                          ),
                          child: child!,
                        );
                      },
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.parse('2010-05-20'),
                      lastDate: DateTime.now(),
                    ).then((value) {
                      _deadLineController.text =
                          DateFormat('yyyy-MM-dd').format(value!);
                    });
                  },
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: deviceWidth * .45,
                      child: CustomTextField(
                        textFieldController: _startTime,
                        label: 'Start Time',
                        hint: TimeOfDay.now().format(context),
                        suffixIcon: AppIcons.timeIcon,
                        textInputType: TextInputType.datetime,
                        onTap: () async {
                          await showTimePicker(
                            builder: (theme, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: ColorsManager
                                        .green, // header background color
                                    onPrimary: ColorsManager
                                        .white, // header text color
                                    onSurface:
                                        ColorsManager.black, // body text color
                                  ),
                                ),
                                child: child!,
                              );
                            },
                            initialTime: TimeOfDay.now(),
                            context: context, //context of current state
                          ).then((value) {
                            if (value != null) {
                              _startTime.text = value.format(context);
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: deviceWidth * .45,
                      child: CustomTextField(
                        mandatory: false,
                        textFieldController: _endTime,
                        label: 'End Time',
                        hint: TimeOfDay.now().format(context),
                        suffixIcon: AppIcons.timeIcon,
                        textInputType: TextInputType.datetime,
                        onTap: () async {
                          await showTimePicker(
                            builder: (theme, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: ColorsManager
                                        .green, // header background color
                                    onPrimary: ColorsManager
                                        .white, // header text color
                                    onSurface:
                                        ColorsManager.black, // body text color
                                  ),
                                ),
                                child: child!,
                              );
                            },
                            initialTime: TimeOfDay.now(),
                            context: context, //context of current state
                          ).then((value) {
                            if (value != null) {
                              _endTime.text = value.format(context);
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                CustomTextField(
                  mandatory: false,
                  textFieldController: _remind,
                  hint: '10 minutes early',
                  suffixIcon: AppIcons.remindIcon,
                  label: 'Remind',
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (c) {
                          return AlertDialog(
                            title: Text(
                              'When Do You Want Remind?',
                              style: getMediumStyle(
                                  color: ColorsManager.black,
                                  fontSize: FontSizes.s16),
                            ),
                            content: SizedBox(
                              width: deviceWidth,
                              height: deviceHeight * .45,
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemCount: remindValues.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {
                                      _remind.text =
                                          '${remindValues[index]} minutes early';
                                      selectedRemind = remindValues[index];
                                      Navigator.pop(context);
                                    },
                                    title: Text(
                                        '${remindValues[index]} minutes early'),
                                  );
                                },
                                separatorBuilder: (c, i) => const Divider(
                                  height: 0,
                                ),
                              ),
                            ),
                          );
                        });
                  },
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                CustomTextField(
                  mandatory: false,
                  textFieldController: _repeat,
                  hint: 'Weekly',
                  suffixIcon: AppIcons.repeatIcon,
                  label: 'Repeat',
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (c) {
                          return AlertDialog(
                            title: Text(
                              'When Do You Want Repeat?',
                              style: getMediumStyle(
                                  color: ColorsManager.black,
                                  fontSize: FontSizes.s16),
                            ),
                            content: SizedBox(
                              width: deviceWidth,
                              height: deviceHeight * .45,
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemCount: repeatValues.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {
                                      _repeat.text = repeatValues[index];
                                      selectedRepeat = repeatValues[index];
                                      Navigator.pop(context);
                                    },
                                    title: Text(repeatValues[index]),
                                  );
                                },
                                separatorBuilder: (c, i) => const Divider(
                                  height: 0,
                                ),
                              ),
                            ),
                          );
                        });
                  },
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                const SelectColor(),
                const SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(25.0),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {
            if (state is DatabaseInsertState) {
              Navigator.pop(context);
              ToastContext().init(context);
              Toast.show("Task Added",
                  duration: Toast.lengthShort,
                  gravity: Toast.center,
                  backgroundColor: ColorsManager.green);
            }
          },
          builder: (context, state) {
            return state is InsetLoadingState
                ? const CircularProgressIndicator()
                : DefaultButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        AppCubit.get(context).insertToDatabase(
                            title: _titleController.text,
                            date: _deadLineController.text,
                            time: _startTime.text,
                            color: AppCubit.get(context).selectedColor,
                        );
                      }
                    },
                    label: AppStrings.createATask,
                    width: deviceWidth,
                  );
          },
        ),
      ),
    );
  }
}


