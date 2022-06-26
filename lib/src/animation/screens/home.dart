import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learn/src/animation/widgets/cat.dart';

class Home extends StatefulWidget {
  @override
  State createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  late Animation<double> catAnimation;
  late AnimationController catController;
  late Animation<double> boxAnimation;
  late AnimationController boxController;

  @override
  void initState() {
    super.initState();
    boxController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    boxAnimation = Tween(begin: pi * 0.6, end: pi * 0.65).animate(CurvedAnimation(
      parent: boxController,
      curve: Curves.easeInOut,
    ));
    boxController.forward();
    boxAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        boxController.forward();
      }
    });
    catController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    catAnimation = Tween(begin: -35.0, end: -82.0).animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation!'),
      ),
      body: GestureDetector(
        child: Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              buildCatAnimation(),
              buildLeftFlap(),
              buildRightFlap(),
              buildBox(),
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  @override
  void dispose() {
    boxController.dispose();
    catController.dispose();
    super.dispose();
  }

  void onTap() {
    if (catController.status == AnimationStatus.completed) {
      boxController.forward();
      catController.reverse();
    } else if (catController.status == AnimationStatus.dismissed) {
      boxController.stop();
      catController.forward();
    }
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
          child: child!,
          top: catAnimation.value,
          right: 0,
          left: 0,
        );
      },
      child: Cat(),
    );
  }

  Widget buildBox() {
    return Container(
      height: 200,
      width: 200,
      color: Colors.brown,
    );
  }

  Widget buildLeftFlap() {
    return Positioned(
        left: 3,
        child: AnimatedBuilder(
          animation: boxAnimation,
          child: Container(
            height: 10,
            width: 125,
            color: Colors.brown,
          ),
          builder: (context, child) {
            return Transform.rotate(
              alignment: Alignment.topLeft,
              angle: boxAnimation.value,
              child: child,
            );
          },
        ));
  }

  Widget buildRightFlap() {
    return Positioned(
        right: 3,
        child: AnimatedBuilder(
          animation: boxAnimation,
          child: Container(
            height: 10,
            width: 125,
            color: Colors.brown,
          ),
          builder: (context, child) {
            return Transform.rotate(
              alignment: Alignment.topRight,
              angle: -boxAnimation.value,
              child: child,
            );
          },
        ));
  }
}
