import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_game/auth/login.dart';
import 'package:tic_tac_game/auth/register.dart';
import 'package:tic_tac_game/screens/home_page.dart';
import 'package:tic_tac_game/provider/provider_info.dart';
import 'package:tic_tac_game/screens/splash_screen.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   SharedPreferences prefs = await SharedPreferences.getInstance();
 
  var  email = prefs.getString("email");
 
  print(email);
  runApp(
    MultiProvider(
       providers: [
        ChangeNotifierProvider(create: (context)=>MyProvider())
      ],
      child:Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
              Color(0xff1f005c),
              Color(0xff5b0060),
              Color(0xff870160),
              Color(0xffac255e),
              Color(0xffca485c),
              Color(0xffe16b5c),
              Color(0xfff39060),
              Color(0xffffb56b),
            ], // Gradient from https://learnui.design/tools/gradient-generator.html
            tileMode: TileMode.mirror,
          ),
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
          
            primarySwatch: Colors.blue,
          ),
          home:email ==null?  LoginScreen():  SplashScreen()
        ),
      ),
    ));
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//        providers: [
//         ChangeNotifierProvider(create: (context)=>MyProvider())
//       ],
//       child:MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Flutter Demo',
//         theme: ThemeData(
          
//           primarySwatch: Colors.blue,
//         ),
//         home: const RegisterScreen(),
//       ),
//     );
//   }
// }

