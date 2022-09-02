import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym/bloc/cubit.dart';

Widget ItemCARD(Map model, context) => Dismissible(

  key: Key(model["id"].toString()),
  child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            child: Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(
                horizontal: 8,
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 18,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${model["title"]}',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${model["time"]}',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${model["data"]}',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      AppCubit.get(context).updatedatabase(
                                          status: "done", id: model["id"]);
                                    },
                                    icon: Icon(
                                      Icons.check_circle,
                                      size: 27,
                                      color: Colors.green,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      AppCubit.get(context).updatedatabase(
                                          status: "archive", id: model["id"]);
                                    },
                                    icon: Icon(
                                      size: 27,
                                      Icons.archive,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
  onDismissed: (direction) {
  AppCubit.get(context).deletdatabase(id: model["id"],);
},);

void ShowToast({required String text, required ToustStute stute}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: ChoseToustColor(stute),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToustStute { SUCCESS, ERROR, WORNNING }

Color ChoseToustColor(ToustStute stute) {
  Color color;
  switch (stute) {
    case ToustStute.SUCCESS:
      color = Colors.green;
      break;
    case ToustStute.ERROR:
      color = Colors.red;
      break;
    case ToustStute.WORNNING:
      color = Colors.amber;
      break;
  }
  return color;
}

/*Widget buildtaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text(
                '${model['time']}',
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${model['title']}',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      )),
                  Text('${model['data']}',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey,
                      )),
                ],
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            IconButton(
              onPressed: () {
                bloc
                    .get(context)
                    .updatedatabase(status: 'done', id: model['id']);
              },
              icon: Icon(
                Icons.done,
                color: Colors.green,
              ),
            ),
            IconButton(
              onPressed: () {
                bloc
                    .get(context)
                    .updatedatabase(status: 'archive', id: model['id']);
              },
              icon: Icon(
                Icons.archive,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        bloc.get(context).deletdatabase(id: model['id']);
      },
    );

Widget buildTaskItem({cubit}) => ConditionalBuilder(
      condition: cubit.length > 0,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) => buildtaskItem(cubit[index], context),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsetsDirectional.only(start: 20.0),
          child: Container(
            height: 1.0,
            width: double.infinity,
            color: Colors.grey,
          ),
        ),
        itemCount: cubit.length,
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              size: 100.0,
              color: Colors.grey,
            ),
            Text(
              'No task yet , Please add some tasks',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );*/
