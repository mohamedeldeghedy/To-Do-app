import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/shared/components.dart';
import 'package:todo/layout/states.dart';
import 'cubit.dart';


class HomeLayout extends StatelessWidget {

  var titleController=TextEditingController();
  var dateController=TextEditingController();
  var timeController=TextEditingController();

  var scaffoldKey= GlobalKey<ScaffoldState>();
  var formKey= GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) =>AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit ,AppStates>(
        listener:(context,state){
          if(state is InsertDatabaseState)
          {
            Navigator.pop(context);
          }
        } ,
        builder:(context,state) {
          AppCubit cubit =AppCubit.get(context);//عملنا اوبجكت عشان نسختدمه ف الاسكرين دي بسهوله


          return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title:
            Text(cubit.titles[cubit.currentIndex]),

          ),
          body: AppCubit.get(context).newtasks.length<0?Center(child: CircularProgressIndicator()):  cubit.screens[cubit.currentIndex],

          floatingActionButton:
          FloatingActionButton(
            onPressed: () {

              if(cubit.isButtonShown)
              {
                if(formKey.currentState!.validate())
                {
                  cubit.insertToDataBase(
                      title:titleController.text ,
                      date: dateController.text,
                      time: timeController.text);
                  // ).then((value)
                  // {
                  //   cubit.getDataFromDataBase(cubit.database).then((value) {
                  //     cubit.tasks=value;
                  //       print(cubit.tasks);
                  //     cubit.changeBottomSheetState(
                  //         isShow:false,
                  //         icon: Icons.edit
                  //     );
                  //
                  //   });
                  //
                  // });
                }
              }else
              {


                scaffoldKey.currentState!.showBottomSheet((context) =>
                    Container(
                      color:Colors.grey[100] ,
                      padding: const EdgeInsets.all(20),

                      child: Form(
                        key: formKey,
                        child: Column(mainAxisSize: MainAxisSize.min,
                          children: [
                            defaultFormField(raduis: 15,

                                validate: (value)
                                {
                                  if(value.isEmpty)
                                  {
                                    return 'Title must not be empty';
                                  }
                                  return null;
                                },
                                prefix:Icons.title ,
                                label:'Title' ,

                                controller: titleController,
                                type:TextInputType.text, prefixIcon: null, onFieldSubmitted: (value) {  },

                            ),
                            const SizedBox(height: 10),
                            defaultFormField(raduis: 15,
                                onTap: ()
                                {
                                  showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.parse('2030-05-30')).then((value)
                                  {
                                    print(DateFormat.yMMMd().format(value!));
                                    dateController.text=DateFormat.yMMMd().format(value);
                                  });
                                },

                                validate: (value)
                                {
                                  if(value.isEmpty)
                                  {
                                    return 'Date must not be empty';
                                  }
                                  return null;
                                },
                                prefix:Icons.calendar_month_outlined ,
                                label:'Date' ,

                                controller: dateController,
                                type:TextInputType.datetime, onFieldSubmitted: (value) {  },

                            ),
                            const SizedBox(height: 10,),
                            defaultFormField(
                              raduis: 15,
                                onTap: ()
                                {
                                  showTimePicker(context: context, initialTime:TimeOfDay.now()).then((value)
                                  {
                                    print(value?.format(context));
                                    timeController.text=value!.format(context);
                                  });
                                },

                                validate: (value)
                                {
                                  if(value.isEmpty)
                                  {
                                    return 'Time must not be empty';
                                  }
                                  return null;
                                },
                                prefix:Icons.watch_later_outlined ,
                                label:'Time' ,

                                controller: timeController,
                                type:TextInputType.datetime, prefixIcon: Icons.timeline,

                            ),



                          ],


                        ),
                      ),
                    )
                ).closed.then((value)
                {
                  cubit.changeBottomSheetState(
                      isShow:false,
                      icon: Icons.edit
                  );

                });

                cubit.changeBottomSheetState(
                    isShow:true,
                    icon: Icons.add
                );




              }
            },
            child: Icon(cubit.fabIcon),

          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex:cubit.currentIndex,
            onTap: (index) //عدد الitems اللي عندي[0,1,2]
            {
              cubit.changeIndex(index);

            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: 'Tasks',

              ), //[0]
              BottomNavigationBarItem(
                icon: Icon(Icons.check_circle_outline),
                label: 'Done',

              ), //[1]
              BottomNavigationBarItem(
                icon: Icon(Icons.archive_outlined),
                label: 'Archived',

              ), //[2]


            ],
          ),
        );
        },
      ),
    );
  }





}




