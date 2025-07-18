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
    return Container(
      height: 60,
      color: Colors.teal[50],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Total Watch Time', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${watchTime.toStringAsFixed(1)} hrs'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Mean Score', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(meanScore > 0 ? meanScore.toStringAsFixed(1) : "-"),
            ],
          ),
        ],
      ),
    );
  }
}