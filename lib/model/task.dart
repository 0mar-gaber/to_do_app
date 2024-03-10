import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Task{
  String? id;
  String? taskTitle;
  String? taskDetails;
  String? taskTime;
  DateTime? taskDate;
  bool isDone =false;

  Task({required this.taskTitle, this.id ,required this.taskDetails,required this.taskDate,required this.taskTime,this.isDone=false});

  Task.fromFireStore(Map<String, dynamic> data) {
    id = data["task id"];
    taskTitle = data["task title"];
    taskDetails = data["task details"];
    taskTime = data["task time"];

    // Convert Timestamp to DateTime
    Timestamp? timestamp = data["task date"];
    taskDate = timestamp?.toDate();

    isDone = data["is done"];
  }

  Map<String,dynamic> toFireStore(){

    Map<String,dynamic> data =
        {
          "task id":id,
          "task title":taskTitle,
          "task details":taskDetails,
          "task time":taskTime,
          "task date":taskDate,
          "is done":isDone
        };
    return data;
  }

}