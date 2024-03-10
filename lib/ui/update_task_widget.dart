import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do/firestore.dart';
import 'package:to_do/model/task.dart';
import 'package:to_do/ui/editText.dart';
import 'package:to_do/ui/home_screen.dart';

import '../shared/screens_provider.dart';

class UpdateWidget extends StatelessWidget {
  static const String route = "update";

  UpdateWidget({Key? key}) : super(key: key);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final taskTitleController = TextEditingController();
  final taskDetailsController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    ScreenProvider provider = Provider.of<ScreenProvider>(context);

    final task = ModalRoute.of(context)!.settings.arguments as Task;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    provider.focusDate = DateTime(provider.focusDate.year, provider.focusDate.month, provider.focusDate.day);

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,

          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            automaticallyImplyLeading: false,
            titleSpacing: width * 0.09,
            centerTitle: false,
            title: Container(
              margin: EdgeInsets.only(bottom: height * 0.07),
              child: Text(
                "To Do List",
                style: TextStyle(fontSize: width * 0.05),
              ),
            ),
            toolbarHeight: height * 0.2,
          ),
        ),
        Scaffold(
          resizeToAvoidBottomInset: false,

          body: Center(
            child: Container(
              margin: EdgeInsets.only(top: height * 0.06),
              height: height * 0.7,
              width: width * 0.8,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onInverseSurface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(width * 0.07),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back,size: width*0.05,color: Theme.of(context).colorScheme.onSurface,)

                        ),

                        Text(
                          "Edit Task",
                          style: TextStyle(
                              fontSize: width * 0.047,
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: width*0.04,)
                      ],
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Form(
                      key: formKey,
                      child: EditText(
                        validate:(value) {
                          if(value==""||value==null){
                            return "add task title";
                          }
                          return null ;
                        },
                          lapel: "this is title",
                          obscureText: false,
                          keyboardType: TextInputType.text,
                          formKay: formKey,
                          controller: taskTitleController,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    EditText(
                      lapel: "this is details",
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      formKay: formKey,
                      controller: taskDetailsController,
                    ),
                    SizedBox(
                      height: height * 0.07,
                    ),
                    InkWell(
                      onTap: () {
                        showTimePicker(
                          context: context,
                          initialTime: provider.selectedTime,
                        ).then((pickedTime) {
                          if (pickedTime != null) {
                            provider.changeTime(pickedTime);
                            task.taskTime = provider.selectedTime.format(context);
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Select Time:",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.onSurface,
                                  fontSize: width * 0.04)),
                          Text(
                            task.taskTime ??
                                provider.selectedTime.format(context),
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: width * 0.04),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.06,
                    ),
                    InkWell(
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: provider.focusDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                        ).then((pickedDate) {
                          if (pickedDate != null) {
                            print("Selected Date: $pickedDate");
                            provider.changeDate(pickedDate);
                            task.taskDate = provider.focusDate;
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Select Date:",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.onSurface,
                                  fontSize: width * 0.04)),
                          Text(
                            DateFormat('yyyy-MM-dd')
                                .format(task.taskDate ??
                                provider.focusDate),
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: width * 0.04),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.1,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if(formKey.currentState!.validate()){
                          var userId =FirebaseAuth.instance.currentUser!.uid;
                          task.id = task.id;
                          task.taskTitle = taskTitleController.text;
                          task.taskDetails = taskDetailsController.text;
                          var taskTime = provider.selectedTime.format(context);
                          task.taskDate = provider.focusDate ;

                          Task updatedTask =Task(taskTitle: task.taskTitle, taskDetails: task.taskDetails, taskDate: task.taskDate, taskTime: taskTime ,id: task.id);
                          print("task date == ${task.taskDate}");
                          print("provider task date == ${task.taskDate}");

                          FireStore.updateTask(userId, task.id!, updatedTask);
                          Navigator.pop(context);
                        }

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        const Color.fromRGBO(53, 152, 219, 1.0),
                        fixedSize: Size(width * 0.5, height * 0.06),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(30))),
                      ),
                      child: Text(
                        "Save Changes",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
