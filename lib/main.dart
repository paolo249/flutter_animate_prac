import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animate_prac/explicit_animate_crc.dart';

const _duration = Duration(milliseconds: 400);
// void main() => runApp(const MaterialApp(home: ExplicitAnimateCircle()));
void main() => runApp(const MaterialApp(home: FlutterAnimateCircle()));

// Create Canvas
// Holds all created circles (list of circles)
// Add and position each circle within stack
// Stack should be whole width and height of screen (leave 110px row out for button)
class FlutterAnimateCircle extends StatefulWidget {
  const FlutterAnimateCircle({super.key});

  @override
  State<FlutterAnimateCircle> createState() => _FlutterAnimateCircleState();
}

class _FlutterAnimateCircleState extends State<FlutterAnimateCircle> {
  // Holds all created circles (list of circles)
  List<Circle> circleList = [];
  // Properties of the circle (color and diameter)
  late Color randomColor;
  late double randomDiameter;

  // Properties of the stack (length and width)
  late double randomHeight;
  late double randomWidth;

  // Property of the screen size (Overall)
  late Size screenSize = MediaQuery.of(context).size;

  void randomCircleAttributes() {
    int red = Random().nextInt(254) + 1;
    int blue = Random().nextInt(254) + 1;
    int green = Random().nextInt(254) + 1;
    // Properties of the circle (color and diameter)
    randomColor = Color.fromARGB(100, red, green, blue);
    randomDiameter = 50 + Random().nextDouble() * 200;
    // Properties of the stack (length and width)
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

// Create button (button triggers creation of circle)
// Place button in bottom 100 px and it take up whole width of screen
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

class _CircleState extends State<Circle> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: widget.randomHeight,
        left: widget.randomWidth,
        child: Container(
          width: widget.randomDiameter,
          height: widget.randomDiameter,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: widget.randomColor),
        )
        .animate()
        .fade(duration: 1000.ms),
      );
  }
}

// Create Circle class widget
// Takes random size, random x,y position and random color as a property
// Has animation for making circles appear
