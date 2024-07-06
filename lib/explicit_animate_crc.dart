import 'package:flutter/material.dart';
import 'dart:math';

const _duration = Duration(milliseconds: 400);

class ExplicitAnimateCircle extends StatefulWidget {
  const ExplicitAnimateCircle({super.key});
  @override
  State<ExplicitAnimateCircle> createState() => _ExplicitAnimateCircleState();
}

class _ExplicitAnimateCircleState extends State<ExplicitAnimateCircle> {
  // Create state variables for borderRadius & margin
  List<Circle> circleList = [];
  late Color randomColor;
  late double randomDiameter;
  late double randomHeight;
  late double randomWidth;
  late Size screenSize = MediaQuery.of(context).size;
  void randomCircleAttributes() {
    int red = Random().nextInt(254) + 1;
    int blue = Random().nextInt(254) + 1;
    int green = Random().nextInt(254) + 1;
    randomColor = Color.fromARGB(100, red, green, blue);
    randomDiameter = 50 + Random().nextDouble() * 200;
    randomHeight =
        Random().nextDouble() * (screenSize.height - 100 - randomDiameter);
    randomWidth = Random().nextDouble() * (screenSize.width - randomDiameter);
    setState(() {
      var newCircle = Circle(
        randomColor: randomColor,
        randomDiameter: randomDiameter,
        randomHeight: randomHeight,
        randomWidth: randomWidth,
      );
      circleList.add(newCircle);
    });
  }

  @override
  Widget build(BuildContext context) {
    // screenSize = MediaQuery.of(context).size;
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height - 100,
            width: MediaQuery.sizeOf(context).width,
            child: Stack(
              children: circleList,
            ),
          ),
          ElevatedButton(
            onPressed: randomCircleAttributes,
            child: const Text('Button'),
          )
        ]);
  }
}

class Circle extends StatefulWidget {
  final Color randomColor;
  final double randomDiameter;
  final double randomHeight;
  final double randomWidth;
  const Circle(
      {super.key,
      required this.randomColor,
      required this.randomDiameter,
      required this.randomHeight,
      required this.randomWidth});
  @override
  State<Circle> createState() => _CircleState();
}

class _CircleState extends State<Circle> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  // init function
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      // cascade operator
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  // dispose function
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.randomHeight,
      left: widget.randomWidth,
      child: Opacity(
        opacity: _animation.value,
        child: Container(
          width: widget.randomDiameter,
          height: widget.randomDiameter,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: widget.randomColor),
        ),
      ),
    );
  }
}
