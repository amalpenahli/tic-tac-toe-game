import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import '../provider/provider_info.dart';

void  initGame(context){
   Provider.of<MyProvider>(context, listen: false)
                  .confettiContanier = false;
              Provider.of<MyProvider>(context, listen: false).colorO =
                  Colors.red;
              Provider.of<MyProvider>(context, listen: false).colorX =
                  Colors.green;
              Provider.of<MyProvider>(context, listen: false).player1 = "";
              Provider.of<MyProvider>(context, listen: false).player2 = "";
              Provider.of<MyProvider>(context, listen: false)
                  .invisibleContainerInfo = false;
              Provider.of<MyProvider>(context, listen: false).invisible = false;
              Provider.of<MyProvider>(context, listen: false).invisibleName =
                  false;
              Provider.of<MyProvider>(context, listen: false).invisible = false;
              Provider.of<MyProvider>(context, listen: false)
                  .invisibleButtonSave = false;
              //Provider.of<MyProvider>(context, listen: false).playerPoint1 = 0;
              Provider.of<MyProvider>(context, listen: false).playerPoint2 = 0;
}