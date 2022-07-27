import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/domain/states/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  late Database dataBase;
  List<Map> allTasks = [];
  List<Map> unCompletedTasks = [];
  List<Map> completedTasks = [];
  List<Map> favTasks = [];
  // this list "day tasks will hold daily tasks and it will update when user select a day from schedule"
  List<Map> dayTasks = [];

  String test = 'test';
  //start creating database
  void createDataBase() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) {
      database
          .execute(
              'create table tasks (id integer PRIMARY KEY , title TEXT , date TEXT , time TEXT , status TEXT , fav Text , color integer)')
          .then((value) => () {
                log('table created');
              })
          .catchError((theError) {
        log('creating table error => ${theError.toString()}');
      });
    },

      onOpen: (dataBase) {
      getDataFromDb(dataBase);
      log('data base opened');
    }).then((value) {
      dataBase = value;
      emit(DatabaseCreateState());
    });
  }
//end creating database

//start database insert
  void insertToDatabase({
    required String title,
    required String date,
    required String time,
    required int color
  }) async {
    emit(InsetLoadingState());
    await dataBase.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO tasks (title , date , time , status , fav , color) VALUES("$title","$date","$time","new","unFavorite", "$color")')
          .then((value) {
        log("inserting to table done");
        emit(DatabaseInsertState());
        getDataFromDb(dataBase);
      }).catchError((error) {
        log('inserting to table error => ${error.toString()}');
      });
    });
  }
//end database insert

//start get data from database
  getDataFromDb(dataBase) {
    dayTasks = [];
    unCompletedTasks = [];
    completedTasks = [];
    favTasks = [];
    allTasks = [];
    emit(GetDataFromDatabaseState());
    dataBase.rawQuery('SELECT * FROM tasks').then((value) {
      log('getting data done successfully');
      allTasks.addAll(value);

      value.forEach((element) {
        if (element['fav'] == 'favorite') {
          favTasks.add(element);
        }
        log(element['fav']);
        if (element['status'] == 'new') {
          unCompletedTasks.add(element);
        } else if (element['status'] == 'done') {
          completedTasks.add(element);
        }
        if(element['date'] == DateFormat('yyyy-MM-dd').format(selectedDate)){
          dayTasks.add(element);
        }
      });
      emit(GetDataFromDatabaseState());
    });
  }
//end get data from database

//start get from database by date

  getDataFromDbByDate(dataBase) {
    dayTasks = [];
    dataBase.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['date'] == DateFormat('yyyy-MM-dd').format(selectedDate)) {
          dayTasks.add(element);
        }
        print(dayTasks);
      });
      emit(GetDataByDateFromDatabaseState());
    });
  }
//end get from database by date

//start update status
  void updateStatus({required String status, required int id}) {
    dataBase.rawUpdate('UPDATE tasks SET status = ? WHERE id = ? ',
        ['$status', id]).then((value) {
      getDataFromDb(dataBase);
      emit(UpdateTaskState(change: status));
    });
  }
//end update status

//start update fav
  void updateFav({required String fav, required int id}) {
    dataBase.rawUpdate(
        'UPDATE tasks SET fav = ? WHERE id = ? ', ['$fav', id]).then((value) {
      getDataFromDb(dataBase);
      emit(UpdateTaskState(change: fav));
    });
  }
//end update fav

//start delete from database
  void deleteTask({required int id}) {
    dataBase.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDb(dataBase);
      emit(DeleteTaskState());
    });
  }
//end delete from database

//start set date into selectedDate
  DateTime selectedDate = DateTime.now();
  changeSelectedDate(DateTime date) {
    selectedDate = date;
    getDataFromDbByDate(dataBase);
    emit(SelectDateState());
  }
//end set date into selectedDate



//start select task color
  int selectedColor = 0xFF4c9dfd;

  List<int> colors = [
    0xFF4c9dfd,
    0xFFfdae4c,
    0xFFfdce4c,
    0xff22bf52,
  ];

  double colorSelectorSize = 30;
  selectColor(index){
  selectedColor = colors[index];
  emit(SelectedColorState());
}
//end select task color


}
