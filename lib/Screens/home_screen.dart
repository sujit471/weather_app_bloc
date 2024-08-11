import 'dart:ui';

import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:weather_app_bloc/Constants/space.dart';
import 'package:weather_app_bloc/constants/custom_text.dart';
import 'package:weather_app_bloc/widgets/items_in_row.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle:  const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark
          ),
        ),
      ),
      body:  Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2*kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child:  Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1.2),
                child: Container(
                  height: 300,
                  width: 500,
                  decoration: const BoxDecoration(
                    color: Colors.orangeAccent,
                  ),
                ),
              ),
              BackdropFilter(filter: ImageFilter.blur(sigmaX : 100.0,sigmaY:100),
                child: Container(
                  decoration: BoxDecoration(color: Colors.transparent),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height : MediaQuery.of(context).size.height ,
           child:  Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               const Text('Align - province',style : TextStyle(
                 color: Colors.white,
                 fontWeight: FontWeight.w300,
               )),
               Height(10),
               Text('Good Morning',style: CustomText.header()),
               Height(10),
               Image.asset(
                 height: 200,
                 'assets/1.png'
               ),
               Center(child: Text('Thunderstorm',style: CustomText.header())),
               Height(10),
               Center(child: Text('Friday 16 - 10 am ',style: CustomText.header())),
               Height(20),
               const Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   ItemsInRow(text:'Sunrise' ,image: 'assets/2.png',time: '5.42',),
                   ItemsInRow(text:'Sunset' ,image: 'assets/4.png',time: '6.00',),
                 ],
               ),
               Height(20),
               const Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   ItemsInRow(text:'Temperature' ,image: 'assets/8.png'),
                   ItemsInRow(text:'Humidity' ,image: 'assets/11.png'),
                 ],
               ),

             ],

           ),
              ),
            ],
          ),
        ),
      ) ,
    );
  }
}
