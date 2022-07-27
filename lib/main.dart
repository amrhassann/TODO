import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/bloc_observer.dart';
import 'package:todo_app/domain/cubit/cubit.dart';
import 'package:todo_app/presentation/res/colors_manager.dart';
import 'package:todo_app/presentation/screens/home_screen.dart';


void main() {
  BlocOverrides.runZoned(
        () => runApp(const MyApp()),
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDataBase(),
      child: MaterialApp(
        theme: ThemeData(
          bottomSheetTheme: const BottomSheetThemeData(
              backgroundColor: ColorsManager.scaffoldBackground),
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}
