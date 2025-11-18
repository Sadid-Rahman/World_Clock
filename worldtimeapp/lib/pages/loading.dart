import 'package:flutter/material.dart';
import 'package:worldtimeapp/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  void setup() async{
    WorldTime inst = WorldTime(location: "Berlin", flag: 'germany.png', url: 'Europe/Berlin');
    await inst.getTime();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': inst.location,
      'flag': inst.flag,
      'time': inst.time,
      'isDayTime' : inst.isDayTime,
    });
   
  }
  // variable initialiser 
  @override
  void initState() {
    super.initState();
    setup();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: SpinKitCubeGrid(
          color: Colors.white,
          size: 80.0,
        )
      ),
    );
  }
}