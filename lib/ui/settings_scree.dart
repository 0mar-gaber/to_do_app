import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/ui/dialog.dart';
import 'package:to_do/ui/log_in_screen.dart';

import '../shared/screens_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? selectedTheme = "Light";
  String? selectedLang = "English";

  @override
  Widget build(BuildContext context) {
    ScreenProvider provider = Provider.of<ScreenProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;



    return Scaffold(
      appBar: AppBar(
        titleSpacing: width*0.09,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        centerTitle: false,
        title: Container(
            margin: EdgeInsets.only(bottom: height*0.07),
            child: Text("Settings",style: TextStyle(fontSize: width*0.05),)),

        toolbarHeight: height*0.2,
      ),
      body: Padding(
        padding:  EdgeInsets.all(width*0.07),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          

            Text("Mode",style: TextStyle(fontWeight: FontWeight.w700,fontSize: width*0.05,color: Theme.of(context).colorScheme.onTertiary),),
            Container(
              margin: EdgeInsets.all(width*0.06),
              decoration:BoxDecoration(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  border: Border.all(color: Theme.of(context).colorScheme.onTertiaryContainer)
              ) ,
              width:width ,
              child: DropdownButton(
                items: ["Light", "Dark"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (value) async {
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  provider.changeAppTheme(value == "Light" ? ThemeMode.light : ThemeMode.dark);
                  if(provider.currentTheme==ThemeMode.dark){
                    await prefs.setBool('is dark', true);

                  }else {

                    await prefs.setBool('is dark', false);

                  }

                },
                value: provider.currentTheme == ThemeMode.light ? "Light" : "Dark",
                alignment: AlignmentDirectional.topStart,
                isExpanded: true,
                padding: const EdgeInsets.all(12),
                dropdownColor: Theme.of(context).colorScheme.onSurfaceVariant,
                underline: const SizedBox(),
                iconDisabledColor: Theme.of(context).colorScheme.onTertiaryContainer,
                iconEnabledColor: Theme.of(context).colorScheme.onTertiaryContainer,
                icon: Icon(Icons.keyboard_arrow_down_sharp, size: width * 0.04),
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: width * 0.05, color: Theme.of(context).colorScheme.onTertiaryContainer),
              ),


            ),

            SizedBox(height: height*0.02,),

            Container(
              margin: EdgeInsets.all(width*0.06),
              child: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    DialogUti.showLoadingDialog(context);
                    try {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pop(context);
                      DialogUti.showMessageDialog(context: context,message: "logged out successfully");
                      Navigator.pushNamedAndRemoveUntil(context, LogInScreen.route,(route) => false,);


                    } catch (e) {
                      print('Error: $e');}
                    },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    const Color.fromRGBO(53, 152, 219, 1.0),
                    fixedSize: Size(width , height * 0.06),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Leave Account",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w700),
                      ),
                      Icon(Icons.logout_outlined,color: Colors.white,)
                    ],
                  ),
                ),
              ),
            )


          ],
        ),
      ),
    );
  }
}
