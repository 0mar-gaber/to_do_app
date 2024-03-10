import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do/firestore.dart';

import '../model/task.dart';

class TaskWidget extends StatefulWidget {
  Task task ;
  TaskWidget({super.key,required this.task});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Center(
      child: Container(
        margin: EdgeInsets.all(width*0.07),
        height: height*0.15,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(15)
        ),
        width: width,
        child: Slidable(
          startActionPane: ActionPane(
              motion: BehindMotion(),
              extentRatio: 0.3,
              children: [
                SlidableAction(
                  onPressed: (context){
                    FireStore.deleteTask(FirebaseAuth.instance.currentUser!.uid, widget.task.id??"");
                  },
                  backgroundColor: Colors.redAccent,
                  label: "Delete",
                  icon: Icons.delete,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(10),
                  ),
                )
              ]
          ),
          child: Padding(
            padding:  EdgeInsets.all(width*0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(width: width*0.01, color: widget.task.isDone? Theme.of(context).colorScheme.errorContainer:Theme.of(context).colorScheme.primary,height: height*0.08,),
                Container(
                  margin: EdgeInsets.only(top: height*0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.task.taskTitle??"",style: TextStyle(color: widget.task.isDone? Theme.of(context).colorScheme.errorContainer:Theme.of(context).colorScheme.primary,fontWeight: FontWeight.w800,fontSize: width*0.04),),
                      SizedBox(height: height*0.015,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.access_time,size: height*0.02,color:Theme.of(context).colorScheme.primaryContainer),
                          SizedBox(width: width*0.01,),
                          Text(widget.task.taskTime??"",style: TextStyle(fontWeight: FontWeight.w400,fontSize: height*0.02,color:Theme.of(context).colorScheme.primaryContainer ),),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: width*0.03,),
                !widget.task.isDone?ElevatedButton(
                  onPressed: (){
                    setState(() {
                      var userId = FirebaseAuth.instance.currentUser!.uid;
                      widget.task.isDone=true;
                      print("after : ${widget.task.id}") ;
                      var taskID= widget.task.id;
                      Task updatedTask = Task(taskTitle: widget.task.taskTitle, taskDetails: widget.task.taskDetails, taskDate: widget.task.taskDate, taskTime: widget.task.taskTime,isDone: true,id: taskID);
                      FireStore.updateTask(userId, widget.task.id!, updatedTask);
                      print("before : ${widget.task.id}") ;

                      // color: !widget.task.isDone? Theme.of(context).colorScheme.errorContainer:Theme.of(context).colorScheme.primary
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(width*0.13, height*0.04),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                  ),
                  child: Center(child: Icon(Icons.check,size: width*0.06,color: Colors.white,)),
                ):Text("Done!  ",style: TextStyle(color : Theme.of(context).colorScheme.errorContainer,fontWeight: FontWeight.w700,fontSize: width*0.06)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
