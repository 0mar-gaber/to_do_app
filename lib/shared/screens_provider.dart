import 'package:flutter/material.dart';
import 'package:to_do/firestore.dart';
import 'package:to_do/model/task.dart';

import '../ui/task_widget.dart';

class ScreenProvider extends ChangeNotifier{
  int currentIndex = 0 ;

  changeScreen(int index){
    currentIndex=index;
    notifyListeners();
  }



  DateTime focusDate = DateTime.now();

  changeDate(  DateTime newFocusDate ){
    focusDate = newFocusDate ;
    notifyListeners();

  }



  TimeOfDay selectedTime = TimeOfDay.now() ;

  changeTime(  TimeOfDay newSelectedTime ){
    selectedTime = newSelectedTime ;
    notifyListeners();

  }


  ThemeMode currentTheme = ThemeMode.light;
  changeAppTheme(ThemeMode newTheme){
    currentTheme=newTheme ;
    notifyListeners();
  }


  }






