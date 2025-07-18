import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final double watchTime;
  final double meanScore;

  const TopBar({
    Key? key,
    required this.watchTime,
    required this.meanScore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 390,
          height: 80,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 45,
                child: Container(
                  width: 390,
                  height: 35,
                  decoration: const BoxDecoration(color: Color(0xFFD9D9D9)),
                ),
              ),
              Positioned(
                left: 5,
                top: 50,
                child: SizedBox(
                  width: 175,
                  height: 25,
                  child: Text(
                    'Watch Time : ${watchTime.toStringAsFixed(1)} Hr',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Roboto Condensed',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 210,
                top: 50,
                child: SizedBox(
                  width: 175,
                  height: 25,
                  child: Text(
                    'Mean Score: ${meanScore.toStringAsFixed(2)}',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Roboto Condensed',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 390,
                  height: 40,
                  decoration: const BoxDecoration(color: Color(0xFFD9D9D9)),
                ),
              ),
              Positioned(
                left: 5,
                top: 5,
                child: SizedBox(
                  width: 200,
                  height: 30,
                  child: Text(
                    'Movie Stats',
                    style: TextStyle(
                      color: Color(0xFF145C6E),
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}