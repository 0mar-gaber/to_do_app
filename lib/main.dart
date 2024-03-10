import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/app_theme/app_theme.dart';
import 'package:to_do/firebase_options.dart';
import 'package:to_do/shared/screens_provider.dart';
import 'package:to_do/ui/create_account_screen.dart';
import 'package:to_do/ui/home_screen.dart';
import 'package:to_do/ui/log_in_screen.dart';
import 'package:to_do/ui/update_task_widget.dart';

Future<void> main () async {
  WidgetsFlutterBinding.ensureInitialized();
  late bool isDark  ;
  late ThemeMode savedTheme ;
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if(prefs.containsKey("is dark")){
    isDark =  (prefs.getBool("is dark"))!;
  }else{
    isDark = false ;
  }
  if(isDark){
    savedTheme = ThemeMode.dark;
  }else{
    savedTheme = ThemeMode.light;

  }
  await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
    create:(context) => ScreenProvider()..changeAppTheme(savedTheme),
      child: const ToDoApp())
  );
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenProvider provider = Provider.of<ScreenProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.route: (context) => HomeScreen(),
        LogInScreen.route: (context) => const LogInScreen(),
        CreateAccountScreen.route: (context) => const CreateAccountScreen(),
        UpdateWidget.route: (context) => UpdateWidget(),
      },
      initialRoute:
      FirebaseAuth.instance.currentUser == null ? LogInScreen.route : HomeScreen.route,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: provider.currentTheme,
    );
  }
}
