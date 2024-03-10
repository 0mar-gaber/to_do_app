import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/constant.dart';
import 'package:to_do/firestore.dart';
import 'package:to_do/model/user.dart' as MyUser;
import 'package:to_do/ui/create_account_screen.dart';
import 'package:to_do/ui/editText.dart';
import 'package:to_do/ui/home_screen.dart';
import 'package:to_do/ui/dialog.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});
  static const String route = "logIn";

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool obscure = true ;
  GlobalKey<FormState>formKey = GlobalKey<FormState>();
  final emilController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {


    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(

      decoration:  BoxDecoration(
          color: Theme.of(context).colorScheme.onInverseSurface,
          image: DecorationImage(image: AssetImage("assets/images/login_bg.png"),fit: BoxFit.fill)),

      child: Scaffold(

        appBar: AppBar(
          centerTitle: true,
          title: Text("Login",style: TextStyle(fontSize:width*0.06),),
            toolbarHeight:height*0.15,

        ),

        body:ListView(
          children:[ Container(

            margin: EdgeInsets.only(top: height*0.2,left: width*0.04,right:width*0.04 ),

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text("Welcome back!",style: TextStyle(fontSize: width*0.07,fontWeight: FontWeight.w600,color : Theme.of(context).colorScheme.onSurface)),

                SizedBox(height: height*0.02),

                Form(
                  key: formKey,
                    child:Column(
                      children: [
                        EditText(
                          lapel: "Email",
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          formKay: formKey,
                          validate:  (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email shouldn\'t be empty ';
                          }else if(!RegExp(Constant.emailRegExp).hasMatch(value)){
                              return 'Enter valid email';
                            }else{
                            return null;
                          }
                        },
                          controller: emilController,
                        ),


                        SizedBox(height: height*0.05),

                        EditText(
                          validate:  (value) {
                            if (value == null || value.isEmpty) {
                              return 'password should n\'t be empty ';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          lapel: "Password",
                          obscureText: obscure,
                          iconButton: IconButton(
                              onPressed: (){
                                setState(() {
                                  obscure= !obscure;
                                });
                              },
                              icon:obscure?const Icon(Icons.visibility_off,color: Color.fromRGBO(53, 152, 219, 1.0)):const Icon(Icons.visibility,color: Color.fromRGBO(53, 152, 219, 1.0))
                          ),
                          formKay: formKey,
                          controller: passwordController,
                        ), // password
                      ],
                    )

                ),


                SizedBox(height: height*0.05),



                ElevatedButton(
                  onPressed: () {
                    logIn();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(53, 152, 219, 1.0),
                    fixedSize: Size(width, height*0.07),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),

                  ),
                  child: Padding(
                    padding:  EdgeInsets.all(width*0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Login",style: TextStyle(color: Colors.white,fontSize: width*0.03,fontWeight: FontWeight.w400),),
                        Icon(Icons.arrow_forward,color: Colors.white,size: width*0.05,)
                      ],
                    ),
                  )
                ),

                SizedBox(height: height*0.05),

                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, CreateAccountScreen.route);
                    },
                    child: Container(
                        height: height*0.06,
                        alignment: AlignmentDirectional.centerStart,
                        child: Text("Create New Account..?",style: TextStyle(fontSize: width*0.03,fontWeight: FontWeight.w400,color : Theme.of(context).colorScheme.onSurface)))),


              ],
            ),
          ),
        ]) ,

      ),
    );
  }

  logIn() async {



    if(formKey.currentState!.validate()){
      DialogUti.showLoadingDialog(context);
      try {
        UserCredential userInfo =  await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emilController.text,
            password: passwordController.text
        );
        MyUser.User? user = await FireStore.getUser(userInfo.user!.uid);
        print(user!.name);
        Navigator.pop(context);
        Navigator.pushNamedAndRemoveUntil(context, HomeScreen.route, (route) => false);

      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          Navigator.pop(context);
          DialogUti.showMessageDialog(context: context,message: "User not found");

        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          Navigator.pop(context);
          DialogUti.showMessageDialog(context: context,message: "Wrong Password");


        }
      }
    }
  }

}
