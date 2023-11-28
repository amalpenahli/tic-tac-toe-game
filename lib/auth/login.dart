import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tic_tac_game/auth/register.dart';
import 'package:tic_tac_game/button_style.dart';
import 'package:tic_tac_game/constants/text_style.dart';
import 'package:tic_tac_game/functions/snacbar_bottom.dart';
import 'package:tic_tac_game/main.dart';
import 'package:tic_tac_game/provider/provider_info.dart';

import 'package:tic_tac_game/screens/home_page.dart';
import 'package:tic_tac_game/widget/text_field.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final FirebaseFirestore _firestore;
  late final FirebaseAuth _firebaseAuth;
  late final CollectionReference usersCollection;
  late final User? currentUser;
  @override
  void initState() {
      if (Provider.of<MyProvider>(context, listen: false).isLoggedIn ==
        true) {
      getCurrentUser();
    }
    super.initState();
    _firestore = FirebaseFirestore.instance;
    _firebaseAuth = FirebaseAuth.instance;
    usersCollection = _firestore.collection("userInfo");
    emailController = TextEditingController();

    passwordController = TextEditingController();
    currentUser = _firebaseAuth.currentUser;
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();

    passwordController.dispose();
  }

  void getCurrentUser() {
    setState(() {
      if (FirebaseAuth.instance.currentUser?.uid != null) {
        Provider.of<MyProvider>(context, listen: false).userId =
            FirebaseAuth.instance.currentUser!.uid;
      }
      // Provider.of<ProviderProfile>(context, listen: false).userId =
      //     FirebaseAuth.instance.currentUser!.uid;
      //     print(FirebaseAuth.instance.currentUser!.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Container(
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
        child: Padding(
          padding: const EdgeInsets.only(left: 40.0, right: 40),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("TIC-TAC GAME",
                style: GoogleFonts.aldrich(
                  textStyle: textStyle7,
                )),
            const SizedBox(
              height: 20,
            ),
            Text("sign in and start playing", style: textStyle6),
            const SizedBox(height: 15),
            TextFieldContainer(text: "email", controller: emailController),
            TextFieldContainer(text: "password", controller: passwordController),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                style: ButtonStylee1.ssss,
                onPressed: () async {
                  signIn();
                  SharedPreferences pref = await SharedPreferences.getInstance();
                  pref.setString("email", emailController.text);
                },
                child: const Text("log in")),
            Row(
              children: [
               const Text("don't have an account?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()),
                      );
                    },
                    child: const Text("register"))
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Future signIn() async {
     Provider.of<MyProvider>(context, listen: false).isLogged();
    if (emailController.text == "" || passwordController.text == "") {
      showEmptyBox(context);
    } else if (!emailController.text.contains("@")) {
      showTrueEmail(context);
    } else if (emailController.text != currentUser!.email) {
      showNotEmail(context);
    }

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        )
        .then((value) => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            ));
    
    // } on FirebaseAuthException catch (e) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       backgroundColor: Colors.red,
    //       content: Text(e.toString()),
    //     ),
    //   );
    // }
     navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
