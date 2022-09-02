import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/bloc/cubit.dart';
import 'package:gym/bloc/stute.dart';
import 'package:gym/componentes/components.dart';

class doneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener:  (context, state) {},
      builder: (context, state) {
        var cubit =AppCubit.get(context).donetasks;
        return  AppCubit.get(context).donetasks.length==0?Center(
          child: Text("مفيش حاجه اضافت يا غالي ",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),

          ),
        ): ConditionalBuilder(

          condition:state is! AppgetdatabaseLoudingstate,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) {
            return  ListView.separated(itemBuilder: (context, index) => ItemCARD(cubit[index],context),
              separatorBuilder: (context, index) => SizedBox(height: 0,),
              itemCount: cubit.length,);
          } ,
        );
      },
    );
  }
}
