

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:pinput/pinput.dart';
// import 'package:tic_tac_game/auth/login.dart';


// class VerificationPage extends StatefulWidget {
//   final String? phone;
//   final String? verificationId;
//   const VerificationPage({
//     Key? key,
//     required this.phone,
//    required this.verificationId,
//   }) : super(key: key);

//   @override
//   State<VerificationPage> createState() => _VerificationPageState();
// }

// class _VerificationPageState extends State<VerificationPage> {
//   final TextEditingController _pinPutController = TextEditingController();

//   @override
//   void initState() {

//     super.initState();
//   }

//   //late String _verificationCode;
 
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SingleChildScrollView(
//       child: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 "assets/icons/logo.png",
//                 width: 350,
//                 height: 350,
//               ),
//               Container(
//                   alignment: Alignment.bottomLeft,
//                   child: const Text(
//                     "Verification",
//                     style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//                   )),
//               const SizedBox(
//                 height: 15,
//               ),
//               Container(
//                   alignment: Alignment.bottomLeft,
//                   child: Text("Enter the OTP send to number ${widget.phone}")),
//               const SizedBox(
//                 height: 15,
//               ),
//               Pinput(
//                 length: 6,
//                 controller: _pinPutController,
//                 defaultPinTheme: defaultPinTheme,
//                 focusedPinTheme: PinTheme(
//                   width: 56,
//                   height: 56,
//                   textStyle: const TextStyle(
//                       fontSize: 20,
//                       color: Color.fromRGBO(30, 60, 87, 1),
//                       fontWeight: FontWeight.w600),
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                         color: const Color.fromRGBO(114, 178, 238, 1)),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 submittedPinTheme: const PinTheme(
//                   width: 56,
//                   height: 56,
//                   textStyle: TextStyle(
//                       fontSize: 20,
//                       color: Color.fromRGBO(30, 60, 87, 1),
//                       fontWeight: FontWeight.w600),
//                   decoration: BoxDecoration(
//                     color: Color.fromRGBO(234, 239, 243, 1),
//                   ),
//                 ),
//                 pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
//                 showCursor: true,
//                 onSubmitted: (pin) async {
//                   // await FirebaseAuth.instance
//                   //     .signInWithCredential(PhoneAuthProvider.credential(
//                   //         verificationId: _verificationCode, smsCode: pin))
//                   //     .then((value) async {
//                   //   if (value.user != null) {
//                   //     print("go home");
//                   //   }
//                   // });
//                 },
//               ),
//               const SizedBox(
//                 height: 50,
//               ),
//               Container(
//                   padding: const EdgeInsets.only(
//                       left: 80, right: 80, top: 9, bottom: 9),
//                   decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 13, 15, 69),
//                     borderRadius: BorderRadius.circular(36),
//                   ),
//                   child: TextButton(
//                       onPressed: () {
//                         // confirmVertificationCode().then((value) async {
//                         //   SharedPreferences sharedPreferences =
//                         //       await SharedPreferences.getInstance();
//                         //   sharedPreferences.setBool('isLogin', true);

//                         // ignore: unrelated_type_equality_checks
//                         if(_pinPutController ==widget.verificationId ){
//                                Navigator.push(
//                               context,
//                                MaterialPageRoute(
//                                  builder: (context) => LoginScreen()));
//                         }else{
//                           print("sehv");
//                         }
                          
                      
//                       },
                         
//                          child: Text("Submit!",
//                          )
//                          ))
//             ],
//           ),
//         ),
//       ),
//     ));
//   }

//   final defaultPinTheme = PinTheme(
//     width: 56,
//     height: 56,
//     textStyle: const TextStyle(
//         fontSize: 20,
//         color: Color.fromRGBO(30, 60, 87, 1),
//         fontWeight: FontWeight.w600),
//     decoration: BoxDecoration(
//       border: Border.all(color: Colors.black, width: 1),
//       borderRadius: BorderRadius.circular(20),
//     ),
//   );

//   Future confirmVertificationCode() async {
//     FirebaseAuth auth = FirebaseAuth.instance;
//     String smsCode = _pinPutController.text.trim();

//     PhoneAuthCredential _credential = PhoneAuthProvider.credential(
//         verificationId: widget.verificationId!, smsCode: smsCode);
//     await auth.signInWithCredential(_credential).then((value) {
      
//     });
//   }
// }
