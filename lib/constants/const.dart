import 'package:flutter/material.dart';

InputDecoration decor1 = InputDecoration(
  
  hintText: "player1",
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10)
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10)
  ),
);

InputDecoration decor2 = InputDecoration(
  
  hintText: "rəqibin adını daxil edin",
  focusedBorder: OutlineInputBorder(
    
    borderRadius: BorderRadius.circular(10)
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10)
  ),
);


BoxDecoration boxDecoration = const BoxDecoration(

            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue,
                Colors.red,
              ],
            )
         
);

BoxDecoration boxDecoration1 =  BoxDecoration(
           color: Colors.yellow,
          borderRadius: BorderRadius.circular(30)
            
         
);

BoxDecoration boxDecoration2 = const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.green,
                Colors.yellow,
                Colors.red,
               
                
                 Colors.blue,
              ],
            )
         
);
// InputDecoration decor3 = InputDecoration(
  
//   hintText: "name",
//   focusedBorder: OutlineInputBorder(
    
//     borderRadius: BorderRadius.circular(10)
//   ),
//   enabledBorder: OutlineInputBorder(
//     borderRadius: BorderRadius.circular(10)
//   ),
// );

// InputDecoration decor4 = InputDecoration(
  
//   hintText: "email",
//   focusedBorder: OutlineInputBorder(
    
//     borderRadius: BorderRadius.circular(10)
//   ),
//   enabledBorder: OutlineInputBorder(
//     borderRadius: BorderRadius.circular(10)
//   ),
// );

// InputDecoration decor5= InputDecoration(
  
//   hintText: "password",
//   focusedBorder: OutlineInputBorder(
    
//     borderRadius: BorderRadius.circular(10)
//   ),
//   enabledBorder: OutlineInputBorder(
//     borderRadius: BorderRadius.circular(10)
//   ),
// );