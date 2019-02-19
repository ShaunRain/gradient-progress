import 'package:flutter/material.dart';
import 'package:gradient_progress/gradient_progress.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  @override
  _ExampleHomePageState createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> with TickerProviderStateMixin{

  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
    new AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animationController.addListener(() => setState(() {}));
    _animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Center(
          child: GradientCircularProgressIndicator(
            gradientColors: [Colors.yellow, Colors.red],
            radius: 40,
            strokeWidth: 8.0,
            value: new Tween(begin: 0.0, end: 1.0)
                .animate(CurvedAnimation(
                parent: _animationController, curve: Curves.decelerate))
                .value,
          ),
        ),
      );
  }
}
