import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Animation<double> animation;
  AnimationController animationController;

  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));
    animation = Tween(begin: 30.0, end: 0.0).animate(animationController)
      ..addListener(() {
        setState(() {});
      });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: Center(
        child: Container(

          width: MediaQuery.of(context).size.width - 100,
          height: 300,
          child: Card(
            color: Colors.blueAccent,
            elevation: animation.value,
          ),
        ),
      ),
    );
  }
}
