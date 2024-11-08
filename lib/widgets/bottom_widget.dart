import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class BottomWidget extends StatefulWidget {
  final double percent;
  const BottomWidget({
    super.key,
    required this.percent,
  });

  @override
  State<BottomWidget> createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.shade300,
          blurRadius: 10,
          spreadRadius: 5,
        )
      ]),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 30, left: 25),
            // color: Colors.amber,
            width: double.infinity,
            child: const Text(
              'Tu progreso',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: LinearPercentIndicator(
              animation: true,
              animationDuration: 1000,
              percent: widget.percent,
              backgroundColor: Colors.deepPurple.shade100,
              progressColor: Colors.deepPurpleAccent,
              lineHeight: 10,
              barRadius: const Radius.circular(30),
            ),
          ),
        ],
      ),
    );
  }
}