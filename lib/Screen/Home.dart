import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/bloc/cubit.dart';
import 'package:gym/bloc/stute.dart';
import 'package:gym/componentes/components.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class MyHomePage extends StatelessWidget {
  var titlecontrolar = TextEditingController();
  var datecontrolar = TextEditingController();
  var Timecontrolar = TextEditingController();
  var Scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => AppCubit()..CreatDatabase(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {
          if(state is Appinsertdatabasestate){
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          var cubit=AppCubit.get(context);
          return  Scaffold(
            backgroundColor: Colors.grey[200],
            key: Scaffoldkey,
            appBar: AppBar(
              title: Text(cubit.Titles[cubit.currentIndex]),

            ),
            body:cubit.Screen[cubit.currentIndex],
            bottomNavigationBar: CurvedNavigationBar(
              index: cubit.currentIndex,
              height: 60,
              animationDuration:Duration(
                milliseconds: 400,
              ) ,
              backgroundColor: Colors.deepOrangeAccent,
              items: [
                Icon(Icons.table_rows_sharp),
                Icon(Icons.done, ),
                Icon(Icons.archive_outlined, ),

              ],
              onTap: (index)
              {
               cubit.changeNavBar(index);
              },
            ),
            /*floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.openShowMottom) {
                  if (Scaffoldkey.currentState != null &&
                      formkey.currentState != null &&
                      formkey.currentState!.validate()) {
                    cubit.inserToDatabase(
                        title: titlecontrolar.text,
                        data: datecontrolar.text,
                        time: Timecontrolar.text);
                  }
                } else {
                  //فتح ال bottom Sheet وعرض العناصر بداخلها
                 // cubit.openShowMottom = true;
                  Scaffoldkey.currentState!.showBottomSheet(
                        (context) => Container(
                      color: Colors.white,
                      child: Form(
                        key: formkey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: defulteditTextx(
                                ontab: ()
                                {


                                },

                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Tasks Must be not  empty';
                                  }
                                  return null;
                                },
                                onchanged: (value) {
                                  print(value);
                                },
                                onfiled: (s) {
                                  print(s);
                                },
                                Controlar: titlecontrolar,
                                keyboardType: TextInputType.text,
                                Lable: 'Tasks title',
                                prefix: Icons.title,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: defulteditTextx(
                                ///edit text time
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Time Must be not empty';
                                  }
                                  return null;
                                },
                                Controlar: Timecontrolar,
                                keyboardType: TextInputType.datetime,
                                Lable: 'Time',
                                prefix: Icons.watch_later_outlined,
                                ontab: () {

                                }, //ontap
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),

                              ///edit text date
                              child: defulteditTextx(
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Date must be not empty';
                                  }
                                  return null;
                                },
                                Controlar: datecontrolar,
                                keyboardType: TextInputType.datetime,
                                Lable: 'Date',
                                prefix: Icons.date_range,
                                ontab: () {
                                  showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate:
                                      DateTime.parse('2222-01-01'))
                                      .then((value) => {
                                    datecontrolar.text =
                                        DateFormat.yMMMd()
                                            .format(value!),
                                  });
                                },
                              ),
                            ),
                            /////
                          ],
                        ),
                      ),
                    ),
                  ).closed.then((value) {
                    cubit.showbottomsheeat(icon: Icons.edit, isShow: false);
                  });
                  cubit.showbottomsheeat(icon: Icons.add, isShow: true);
                }
              }, ////

              child: Icon(
                cubit.iconData,
              ),
            ),*/

            floatingActionButton: FloatingActionButton(
              onPressed: ()
              {
                if (cubit.openShowMottom)
              {
                if(formkey.currentState!.validate())
                {
                  cubit.inserToDatabase(
                      title: titlecontrolar.text,
                    data: datecontrolar.text, time: Timecontrolar.text);

                  ShowToast(text: 'اضافه بالفعل يغالي', stute: ToustStute.SUCCESS);
                }
              } else{
                  Scaffoldkey.currentState!.showBottomSheet((context) =>
                      Container(
                        height: 250,
                        width: double.infinity,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            key: formkey,
                            child: Column(
                              children: [
                            TextFormField(
                              controller: titlecontrolar,
                              keyboardType: TextInputType.text,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Tasks Must be not  empty';
                                }
                                return null;
                              },
                                decoration: InputDecoration(
                                  labelText: "Text",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.edit,
                                  ),
                                ),
                            ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  controller: Timecontrolar,
                                  keyboardType: TextInputType.number,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'time Must be not  empty';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Time",


                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),

                                    prefixIcon: Icon(
                                      Icons.watch_later,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  controller: datecontrolar,
                                  keyboardType: TextInputType.number,
                                  onTap: (){
                                    showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate:
                                        DateTime.parse('2222-01-01'))
                                        .then((value) => {
                                      datecontrolar.text =
                                          DateFormat.yMMMd()
                                              .format(value!),
                                    });
                                  },
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'date Must be not  empty';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "date",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.calendar_today,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      ),
                  ).closed.then((value) {
                    cubit.showbottomsheeat(icon: Icons.edit,isShow: false);
                  });
                 cubit.showbottomsheeat(icon: Icons.add,isShow: true);
                }
              },
              child: Icon(cubit.iconData),
            ),
          );
        },
      ),

    );
  }
}
