import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/components.dart';
import 'package:todo/layout/states.dart';

import '../layout/cubit.dart';




class ArchivedTasks extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>
      (
        listener: (context,state){},
        builder:(context,state) {
          var tasks = AppCubit
              .get(context)
              .archivedtasks;
          if (tasks.isEmpty) {
            return Center(child: Text('Archived Tasks',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),));
          }
          else
            {
              return ListView.separated(itemBuilder: (context,
              index)=> buildTaskItem(tasks[index],context),
              separatorBuilder:(context,index)=>Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(width: double.infinity,color: Colors.grey[300],height: 1),
              ),
              itemCount: tasks.length);}
        }
    );
  }
}
