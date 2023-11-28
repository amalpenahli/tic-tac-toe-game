



import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_game/functions/show_alert.dart';




  AppBar appBar (context){
return AppBar(
  flexibleSpace: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Colors.red, Colors.blue]),
    ),
  ),
  elevation: 0,
  title:  SingleChildScrollView(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Tic-tac-toe game",
          style:GoogleFonts.akronim(
          textStyle: const TextStyle(color: Colors.black, fontSize: 36,fontWeight: FontWeight.w500),
        ),
          
        ),
  
        IconButton(onPressed: (){
          
     showAlert(context);
        }, icon:const Icon(Icons.info))
      ],
    ),
  )
  );
  
}

 

 



AppBar appBarPoint = AppBar(
  flexibleSpace: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Colors.red, Colors.blue]),
    ),
  ),
  elevation: 0,
  title:  Text(
    "Players Point",
    style:GoogleFonts.akronim(
    textStyle: const TextStyle(color: Colors.black, fontSize: 45,fontWeight: FontWeight.w500),
  ),
  ),
);
