import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/Screen/Done.dart';
import 'package:gym/Screen/arcived.dart';
import 'package:gym/Screen/tasks.dart';
import 'package:gym/bloc/stute.dart';
import 'package:gym/componentes/components.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(appinitialsyatus());

  static AppCubit get(context) => BlocProvider.of(context);
  late int currentIndex = 0;
  late Database database;

  List<String>Titles=[
    "المهام الجديده",
    "الموجوده بالفعل ",
    "الارشيف",

  ];

  List<Widget> Screen =
  [
    TasksScreen(),
    doneScreen(),
    ArcivedScreen(),

  ];
//////
  void changeNavBar(int index) {
    currentIndex = index;
    emit(appchange_navbarstatus());
  }
  IconData iconData = Icons.edit;
  bool openShowMottom = false;

  void showbottomsheeat({
    required IconData icon,
    required bool isShow,
  }) {
    iconData = icon;
    openShowMottom = isShow;
    emit(Appchangiconstate());
  }

  //////
  List<Map> Newtaskss = [];
  List<Map> donetasks = [];
  List<Map> archivetasks = [];
//عمل كرييت لملف ال sqflite وعمل  creat لل Table
  void CreatDatabase() {
    openDatabase(
      'dataAAb.db',
      version: 1,
      onCreate: (database, version) async {
        print('database created');
        await database.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY,'
            ' title TEXT , data TEXT , time TEXT ,status TEXT )')
            .then((value) {
          print('Table created');
        }).catchError((error) {
          print('Table is error ${error.toString()}');
        });
      },
      onOpen: (database) {
       getdatafromdatabase(database);
        print('Opened database');
      },
    ).then((value) {
      database = value;
      emit(Appcreatdatabasestate());
    });
  }
/*  void insertToDB()
  {
    database.transaction((txn){
     return txn
          .rawInsert('INSERT INTO tasks(title ,data,time,status) VALUES("title" ,"data","time","new")')
          .then((value) {

        print('$value data inserted successful');
        //getdatafromdatabase(database);

      }).catchError((error) {
        print('data inserted error is ${error.toString()}');
      });

    });
  }*/

//حفظ المعلومات داخل الداتا بيز
   inserToDatabase({
    required String title,
    required String data,
    required String time,
  }) async {
   await database.transaction((txn)async
   {
         await txn.rawInsert('INSERT INTO tasks(title ,data,time,status) '
             'VALUES("$title" ,"$data","$time","new")')
          .then((value) {
        emit(Appinsertdatabasestate());
        print('$value data inserted successful');
        getdatafromdatabase(database);
        emit(Appgetdatabasestate());
      }).catchError((error) {
        print('data inserted error is ${error.toString()}');
      });
    });
  }

 void getdatafromdatabase(database)async {
    Newtaskss = [];
    donetasks = [];
    archivetasks = [];
   emit(AppgetdatabaseLoudingstate());
     database.rawQuery('SELECT * FROM tasks').then((value) {
     // Newtaskss=value;
      //print(value.toString());

      value.forEach((element) {
        if (element['status'] == 'new')
         Newtaskss.add(element);
        else if (element['status'] == 'done')
          donetasks.add(element);
        else
          archivetasks.add(element);
      });
      emit(Appgetdatabasestate());
    });
  }



  void updatedatabase({
    required String status,
    required int id,
  }) {
    database.rawUpdate('UPDATE tasks SET status = ?  WHERE id = ?',
        ['$status', id]).then((value) {
      getdatafromdatabase(database);
      emit(Appapdetdatabasestate());
    });
  }



  void deletdatabase({
    required int id,
  }) {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getdatafromdatabase(database);
      emit(AppDeletdatabasestate());
    }).then((value)
    {
      ShowToast(text: ' تم المسح بالفعل', stute: ToustStute.ERROR);
      emit(AppDeletdatabasestate());
    } );
  }
}
