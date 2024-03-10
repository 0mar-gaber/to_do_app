import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/firestore.dart';
import 'package:to_do/model/user.dart' as MyUser;
import 'package:to_do/ui/dialog.dart';
import 'package:to_do/ui/editText.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constant.dart';
import 'home_screen.dart';


class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});
  static const String route = "createAccount";

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool obscure = true ;
  final _formKey = GlobalKey<FormState>();
  final emilController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();


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
          backgroundColor: Colors.transparent,
          title: Text("Create Account",style: TextStyle(fontSize:width*0.06,color: Theme.of(context).colorScheme.onInverseSurface,
          ),),
          toolbarHeight:height*0.15,
          iconTheme: IconThemeData(size: width*0.09, color: Theme.of(context).colorScheme.onInverseSurface,
          ),
        ),

        body:ListView(
          children:[ Container(

            margin: EdgeInsets.only(top: height*0.2,left: width*0.04,right:width*0.04 ),

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [


                Form(
                    key: _formKey,
                    child:Column(
                      children: [
                        EditText(
                          lapel: "Name",
                          obscureText: false,
                          keyboardType: TextInputType.name,
                          formKay: _formKey,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Name should n\'t be empty ';
                            }
                            return null;
                          },
                          controller: nameController,
                        ), // Name


                        SizedBox(height: height*0.05),

                        EditText(lapel: "E-mail Address",
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          formKay: _formKey ,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email shouldn\'t be empty ';
                            }else if(!RegExp(Constant.emailRegExp).hasMatch(value)){
                              return 'Enter valid email';
                            }else{
                              return null;
                            }
                          },
                          controller: emilController,
                        ), // email


                        SizedBox(height: height*0.05),


                        EditText(
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
                          keyboardType: TextInputType.text,
                          formKay: _formKey ,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'password should n\'t be empty ';
                            }
                            if(value.length<8){
                              return 'Password must have at least 8 characters';
                            }
                            return null;
                          },
                          controller: passwordController,
                        ), // password

                      ],
                )
                ),




                SizedBox(height: height*0.1),



                ElevatedButton(
                    onPressed: (){
                      createNewAccount();
                      // Navigator.pushNamedAndRemoveUntil(context, HomeScreen.route, (route) => false);
                    },
                    style: ElevatedButton.styleFrom(
                      disabledBackgroundColor:Colors.white ,
                      backgroundColor:  const Color.fromRGBO(53, 152, 219, 1.0),
                      fixedSize: Size(width, height*0.07),
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),

                    ),
                    child: Padding(
                      padding:  EdgeInsets.all(width*0.03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Create Account",style: TextStyle(color:Colors.white,fontSize: width*0.03,fontWeight: FontWeight.w400),),
                          Icon(Icons.arrow_forward,color:Colors.white,size: width*0.05,)
                        ],
                      ),
                    )
                ),



              ],
            ),
          ),
        ]) ,

      ),
    );
  }

  createNewAccount() async {



    if(_formKey.currentState!.validate()){
      DialogUti.showLoadingDialog(context);
      try {
        var userInfo = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email:emilController.text ,
          password: passwordController.text,
        );
        FireStore.addUser(emilController.text, nameController.text, userInfo.user!.uid);
        DialogUti.closeDialog(context);
        Navigator.pushNamedAndRemoveUntil(context, HomeScreen.route , (route) => false,);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          DialogUti.closeDialog(context);
          DialogUti.showMessageDialog(context: context,message: "Password is too weak");

        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          DialogUti.closeDialog(context);
          DialogUti.showMessageDialog(context: context,message: "Email is already used");
        }
      } catch (e) {
        print(e);
      }
    }
  }


}
