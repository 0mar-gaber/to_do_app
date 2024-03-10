import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/firestore.dart';
import 'package:to_do/model/task.dart';
import 'package:to_do/shared/screens_provider.dart';
import 'package:to_do/ui/add_task_bottom_sheet.dart';
import 'package:to_do/ui/settings_scree.dart';
import 'package:to_do/ui/task_widget.dart';
import 'package:to_do/ui/tasks_screen.dart';

class HomeScreen extends StatefulWidget {
  static const route = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> pages = [
    const TasksScreen(),
    const SettingsScreen(),
  ];


   GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

   bool isBottomSheetIsOpen = false;


  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDetailsController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  GlobalKey<FormState> formKey = GlobalKey();



  @override
  Widget build(BuildContext context) {
    ScreenProvider provider = Provider.of<ScreenProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    provider.focusDate = DateTime(provider.focusDate.year, provider.focusDate.month, provider.focusDate.day);


    return Container(
      color:  Theme.of(context).colorScheme.background,
      child: Scaffold(

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            !isBottomSheetIsOpen?showBottomSheet(context):onAddPressed();
            print(provider.focusDate);

          },
          shape: StadiumBorder(
            side: BorderSide(width: width * 0.006, color: Theme.of(context).colorScheme.outlineVariant),
          ),
          child:  Icon(
            isBottomSheetIsOpen?Icons.check:Icons.add,
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),


        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).colorScheme.inversePrimary,
          shape: const CircularNotchedRectangle(),
          notchMargin: width * 0.015,
          elevation: 20,
          clipBehavior: Clip.antiAlias,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            child: BottomNavigationBar(
                currentIndex: provider.currentIndex,
                onTap: (value) {
                  provider.changeScreen(value);
                },
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.list, size: width * 0.08), label: ""),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.settings_outlined,
                        size: width * 0.08,
                      ),
                      label: ""),
                ]),
          ),
        ),


          body:Scaffold(
          key: scaffoldKey,
          body:pages[provider.currentIndex],
        )
      ),
    );
  }


  showBottomSheet(BuildContext context) {
    setState(() {
      isBottomSheetIsOpen = true;
      print("ok");

    });

    scaffoldKey.currentState!.showBottomSheet(
      (context) => AddTaskSheet(formKey: formKey,taskDetailsController: taskDetailsController,taskTitleController: taskTitleController,),
    ).closed.whenComplete(() {
      setState(() {
        isBottomSheetIsOpen = false;
        print("no");
      });
    });


  }

  onAddPressed(){
    ScreenProvider provider = Provider.of<ScreenProvider>(context,listen: false);
    if(formKey.currentState?.validate()??false){

      var taskTime =  provider.selectedTime.format(context) ;

      Task task = Task(taskTitle: taskTitleController.text, taskDetails: taskDetailsController.text,taskDate: provider.focusDate,taskTime: taskTime);
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      FireStore.addNewTask(userId!, task);
      // var date = provider.focusDate;
      // provider.addToTaskList(provider.focusDate,TaskWidget(task: Task(taskTitle: taskTitleController.text, taskDetails: taskDetailsController.text, taskDate: taskDate, taskTime: taskTime)));
      taskDetailsController.clear();
      taskTitleController.clear();
      Navigator.pop(context);
    }



  }


}
