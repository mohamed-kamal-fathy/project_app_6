import 'package:flutter/material.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'dart:async';

//  ---------main function ------  /
void main() {
  runApp(PROXIMITY_APP());
}

class PROXIMITY_APP extends StatefulWidget {

  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<PROXIMITY_APP> {
  bool _close = false;
 
  late StreamSubscription<dynamic> _streamSubscription;

//  ---------  initialize the state of the widget ------  /

  void initState() {
    super.initState(); //This is required to ensure that the parent class can perform any necessary initialization.
    _listenSensor();   //method is called to start listening to the proximity sensor.
  }
  
//  ---------function for the events stream of the ProximitySensor object is listened to and start listening to sensor events------  /
 void _listenSensor() {
    _streamSubscription = ProximitySensor.events.listen((int e) {
      //method is called to update the state of the widget with the new value of _close
      setState(() {
        _close = (e > 0) ? true : false;
      });
    });
  }

 // ----- dispose function for the _streamSubscription is canceled to stop listening to sensor events.
 // ------to clean up any resources that were set up in initState()
  @override
  void dispose() {
    super.dispose(); //This is required to ensure that the parent class can perform any necessary cleanup.
    _streamSubscription.cancel();  //This is necessary to stop listening to the sensor events and prevent any memory leaks or performance issues.
  }

  
  //responsible for building the widget tree that represents the current state of the widget.
  @override
  Widget build(BuildContext context) {
   // basic structure for the app
    return MaterialApp(
      debugShowCheckedModeBanner: false, //hide the debug banner
      //the main content of the app
      home: Scaffold(
        //to display a title at the top of the screen
        appBar: AppBar(
          title: const Text('Proximity Sensor Project (6)'),
          backgroundColor: Colors.black,
        ),
        //to display the body of the app and set to a Container widget that is centered on the screen
        body: Center(
          child: Container(
            width: 250.0,
            height: 250.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _close ? Colors.green : Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}