import 'package:flutter/material.dart';

class AppWidgets{

  TextStyle titleText(double size){
    return TextStyle(color: Color(0xFF333333), fontSize: size, fontFamily: 'Montserrat');
  }

  TextStyle boldText(double size){
    return TextStyle(color: Color(0xFF333333), fontSize: size, fontFamily: 'Montserrat', fontWeight: FontWeight.w600);
  }

  Container centerLoading(){
    return new Container(child: Center(child: CircularProgressIndicator()));
  }

  Container imageContainer(String url, double size){
    return Container(
      height: size, width: size,
      decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(url), fit: BoxFit.fill)
      ),
    );
  }

}