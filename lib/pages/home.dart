import 'dart:ui';

import 'package:flutter/material.dart';

// stateful cuz we are going to use data
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    //this is where we receive the arguments
    // ternary is needed cuz we below choose locaiton thingy after updating retriggers the build function and this resets it all
    data = data.isNotEmpty? data : ModalRoute.of(context)?.settings.arguments as Map;
    String bgImg = data['isDayTime']? 'day.jpg' : 'night.jpg';

    return Scaffold(

      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/$bgImg'), fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: [
                TextButton.icon(
                  onPressed: () async{
                    // the location page is pushed on top
                    // next step added later, assume the below is a big async funtion that gets some data
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'location': result['location'],
                        'flag': result['flag'],
                        'time': result['time'],
                        'isDayTime': result['isDayTime'],
                      };
                    });
                  },
                  icon: Icon(Icons.edit_location),
                  label: Text("Select location"),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['location'],
                      style: TextStyle(
                        fontSize: 28,
                        letterSpacing: 2,
                        color: data['isDayTime']? Colors.black : Colors.white,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Text(
                  data['time'],
                  style: TextStyle(
                    fontSize: 66.0,
                    color: data['isDayTime']? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}
