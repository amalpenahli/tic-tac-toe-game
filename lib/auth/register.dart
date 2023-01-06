import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_game/auth/login.dart';
import 'package:tic_tac_game/button_style.dart';
import 'package:tic_tac_game/constants/text_style.dart';
import 'package:tic_tac_game/functions/snacbar_bottom.dart';
import 'package:tic_tac_game/widget/text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final FirebaseFirestore _firestore;
  late final FirebaseAuth _firebaseAuth;
  late final CollectionReference usersCollection;
  late final User? currentUser;
  @override
  void initState() {
    super.initState();
    _firestore = FirebaseFirestore.instance;
    _firebaseAuth = FirebaseAuth.instance;
    usersCollection = _firestore.collection("userInfo");
    emailController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    currentUser = _firebaseAuth.currentUser;
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
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
            Text("register and start playing", style: textStyle6),
            const SizedBox(height: 15),
            TextFieldContainer(text: "name", controller: nameController),
            TextFieldContainer(text: "email", controller: emailController),
            TextFieldContainer(text: "password", controller: passwordController),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                style: ButtonStylee1.ssss,
                onPressed: () {
                  setState(() {
                    signUp();
                  });
                },
                child: const Text("register")),
            Row(
              children: [
                const Text("do you have registration??"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    child:const  Text("log in"))
              ],
            )
          ]),
        ),
      ),
    );
  }

  Future signUp() async {
    {
      if (emailController.text == currentUser!.email) {
        showRegisterEmail(context);
      }
      await _firebaseAuth
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      )
          .then((userCredential) async {
        addToFirestore(userCredential.user!);
      }).whenComplete(() => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              ));
    }
  }

  addToFirestore(User user) async {
    Map<String, dynamic> addedUserInfo = <String, dynamic>{};
    addedUserInfo['name'] = nameController.text;
    addedUserInfo['email'] = emailController.text;
    addedUserInfo['userId'] = user.uid;

    await usersCollection
        .doc(user.uid)
        .set(addedUserInfo, SetOptions(merge: true));
  }
  // verifyPhone() async {
  //   String phone = "+$countryCode${phoneController.text}";
  //   print(phone);
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: phone,
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       print('completed');
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       print(e.message.toString());
  //     },
  //     codeSent: (verificationID, resendToken) {
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => VerificationPage(phone: phone,verificationId:_verificationCode)));
  //     },
  //     codeAutoRetrievalTimeout: (String verificationID) {
  //       _verificationCode = verificationID;
  //     },
  //     timeout: const Duration(seconds: 60),
  //   );
  // }
}
