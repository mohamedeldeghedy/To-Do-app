import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/shared/cache_helper.dart';
import 'package:todo/layout/states.dart';
import '../modules/Archived.dart';
import '../modules/Done.dart';
import '../modules/New.dart';



class AppCubit extends Cubit<AppStates>
{
  AppCubit() :super (AppInitialState());
  static AppCubit get(context)=> BlocProvider.of(context);
  List<Map> newtasks=[];
  List<Map> donetasks=[];
  List<Map> archivedtasks=[];


  int currentIndex = 0;
  List<Widget> screens = [
    NewTasks(),
    DoneTasks(),
    ArchivedTasks(),


  ];
  List<String> titles =
  [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',


  ];
  void changeIndex(int index)
  {
    currentIndex =index;
    emit(AppChangeNavBarState());
  }
  late Database database;
  bool isButtonShown=false;
  IconData fabIcon =Icons.edit;

  void changeBottomSheetState({required bool isShow,required IconData icon})
  {
    isButtonShown=isShow;
    fabIcon=icon;
    emit(ChangeBottomSheetState());
  }

  void createDataBase()
  {
     openDatabase(
        'ToDo.db',
        version: 1,
        onCreate: (database, version) {
          print('database created');
          database.execute(
              'CREATE TABLE Tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXY,time TEXT,status TEXT)')
              .then((value) {
            print('table created');
          }).catchError((error) {
            print('error is${error.toString()}');
          });
        },
        onOpen: (database) {
          getDataFromDataBase(database);
          print('database opened');
        }


    ).then((value) {
      database=value;
      emit(CreateDatabaseState());
     });

  }

  Future insertToDataBase({required String title,required String date,required String time})
  async {
    await database.transaction((txn)
    async{
      txn.rawInsert(
        'INSERT INTO Tasks(title,date,time,status) VALUES("$title","$date","$time","New")',
      )
          .then((value) {
        print('$value Inserted successfully');
        emit(InsertDatabaseState());
        getDataFromDataBase(database);

      }).catchError((error)
      {
        print('error is ${error.toString()}');
      });
      return null;
    });
  }

void getDataFromDataBase(database) {
    newtasks=[];
    donetasks=[];
    archivedtasks=[];
     database.rawQuery('SELECT * FROM Tasks').then((value) {

      value.forEach((element)
      {
        if(element['status']=='New')
          newtasks.add(element);
        else if(element['status']=='done')
          donetasks.add(element);
        else archivedtasks.add(element);
      });
      emit(GetDatabaseState());

    });


  }

  void  deleteData({required int id})async
  {
    database.rawDelete(
        'DELETE FROM Tasks WHERE id = ?', [id])
        .then((value)
    {
      getDataFromDataBase(database);
      emit(AppDeleteDataState());

    });



  }
  void  updateData(
      { required String status,
        required int id})async
  {
     database.rawUpdate(
        'UPDATE Tasks SET status = ? WHERE id = ?',
        ['$status', id ]).then((value)
     {
       getDataFromDataBase(database);
       emit(AppUpdateDataState());

     });



  }
  bool isDark=false;
ThemeMode AppMode= ThemeMode.dark;
  void changeAppMode({required bool? fromShared})
  {
    if(fromShared != null)
     {
       isDark=fromShared as bool;
       emit(AppChangeNewsModeState());

     }
    else
      {isDark = !isDark;
    CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value){
      emit(AppChangeNewsModeState());
    });
      }
  }



}