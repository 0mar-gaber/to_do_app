import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do/model/task.dart';
import 'package:to_do/model/user.dart';

class FireStore{



  static CollectionReference<User> getUserCollection(){
    var reference =  FirebaseFirestore.instance.collection("User").withConverter(

      fromFirestore: (snapshot, options) {
        Map<String, dynamic>? data =  snapshot.data();
        return User.fromFireStore(data??{});
      },


      toFirestore: (user, options) {
        return user.toFireStore();
      },

    );


    return reference ;
  }




  static Future<void>addUser(String email , String name,String userId) async {

    var reference = getUserCollection();

    var doc = reference.doc(userId);

    await doc.set(
      User(
          name: name,
          email: email,
          id: userId
      )
    );

  }



  static Future<User?> getUser(String userId) async {

    var refrence = getUserCollection();

    var doc = refrence.doc(userId);

    var snapshot = await doc.get();

    User? user = snapshot.data();

    return user;
  }



  static CollectionReference<Task>getTaskCollection(String userId){

    var tasksCollection = getUserCollection().doc(userId).collection("Tasks").withConverter(
        fromFirestore: (snapshot, options) => Task.fromFireStore(snapshot.data()??{}),
        toFirestore: (task, options) => task.toFireStore(),
    );

    return tasksCollection ;
  }


  static Future<void> addNewTask(String userId,Task task) async {
    var ref = getTaskCollection(userId);
    var taskDoc = ref.doc();
    task.id=taskDoc.id;
    await taskDoc.set(task);
  }


  static Future<List<Task>> getAllTasks(String userId)async{
    var taskQuery = await getTaskCollection(userId).get();
    List<Task> tasksList = taskQuery.docs.map((snapshot) =>snapshot.data()).toList();
    return tasksList ;
  }


  static Stream<List<Task>> getTasksRealTime(String userId, DateTime date)async*{
    var taskQuaryStream = getTaskCollection(userId).where("task date",isEqualTo: date).snapshots();

   Stream<List<Task>> taskStream = taskQuaryStream.map((snapshot) => snapshot.docs.map((document) => document.data()).toList());



    yield* taskStream ;

  }


  static deleteTask(String userId , String taskId) async {
    var ref = getTaskCollection(userId);

    var taskDoc = ref.doc(taskId);

    await taskDoc.delete();

  }



  static Future<void> updateTask(String userId, String taskId, Task updatedTask) async {
    var ref = getTaskCollection(userId);
    var taskDoc = ref.doc(taskId);
    await taskDoc.update(updatedTask.toFireStore());
  }



}