import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:to_do/firestore.dart';
import 'package:to_do/shared/screens_provider.dart';
import 'package:to_do/ui/task_widget.dart';
import 'package:to_do/ui/update_task_widget.dart';

import '../model/task.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {

  @override
  Widget build(BuildContext context) {

    ScreenProvider provider = Provider.of<ScreenProvider>(context);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    provider.focusDate = DateTime(provider.focusDate.year, provider.focusDate.month, provider.focusDate.day);
    print(provider.focusDate);
    return Stack(
      children: [
        Scaffold(
        appBar: AppBar(
          titleSpacing: width*0.09,
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).colorScheme.tertiary,


          centerTitle: false,
          title: Container(
              margin: EdgeInsets.only(bottom: height*0.07),
              child: Text("To Do List",style: TextStyle(fontSize: width*0.05),)),

          toolbarHeight: height*0.2,
        ),
      ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: height*0.17),

              child:  EasyInfiniteDateTimeLine(

                firstDate: DateTime(DateTime.now().year),

                focusDate: provider.focusDate,

                lastDate: DateTime(DateTime.now().year, 12, 31),

                onDateChange: (selectedDate) async {
                  provider.changeDate(selectedDate);
                  },


                showTimelineHeader: false,

                timeLineProps: EasyTimeLineProps(
                  separatorPadding: width*0.07,
                ),

                dayProps:  EasyDayProps(

                    todayStyle:  DayStyle(
                        dayNumStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontWeight: FontWeight.w600,
                            fontSize: width*0.06
                        ),


                        dayStrStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                        ),

                        monthStrStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),

                        decoration:  BoxDecoration(
                            color: Theme.of(context).colorScheme.onPrimary,
                            borderRadius: BorderRadius.all(Radius.circular(6))

                        )
                    ),

                    activeDayStyle: DayStyle(
                        dayNumStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onErrorContainer,
                            fontWeight: FontWeight.w600,
                            fontSize: width*0.06
                        ),


                        dayStrStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),

                        monthStrStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),

                        decoration:  BoxDecoration(
                            color: Theme.of(context).colorScheme.onBackground,
                            borderRadius: BorderRadius.all(Radius.circular(6))

                        )
                    ),
                    inactiveDayStyle: DayStyle(
                        dayNumStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontWeight: FontWeight.w600,
                            fontSize: width*0.06
                        ),


                        dayStrStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),

                        monthStrStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),

                        decoration:  BoxDecoration(
                            color: Theme.of(context).colorScheme.onBackground,
                            borderRadius: BorderRadius.all(Radius.circular(6))

                        )
                    ),
                ),
              ),




            ),
            SizedBox(height: height*0.01,),
            Expanded(
              child: StreamBuilder(
                  stream: FireStore.getTasksRealTime(FirebaseAuth.instance.currentUser!.uid,provider.focusDate),


                  builder: (context, snapshot) {
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.white,
                          size: 200,);
                    } // loading

                    if(snapshot.hasError){
                      return const Text("some thing went wrong");
                    } //success

                    List<Task> allTask = snapshot.data??[];



                    return ListView.builder(
                        itemBuilder: (context, index)=>InkWell(
                            onLongPress: () {
                              Navigator.pushNamed(context, UpdateWidget.route,arguments:allTask[index] );
                            },
                            child: TaskWidget(task: allTask[index])),
                      itemCount: allTask.length,
                    );

                  },
              ),
            )
          ],
        )
      ]);
  }
}
