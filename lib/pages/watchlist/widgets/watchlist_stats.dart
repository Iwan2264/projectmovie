import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WatchlistStats extends StatelessWidget {
  final int watched;
  final int planToWatch;
  final int rewatched;
  final int dropped;
  final int total;

  const WatchlistStats({
    Key? key,
    required this.watched,
    required this.planToWatch,
    required this.rewatched,
    required this.dropped,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      height: 155,
      child: Stack(
        children: [
          // Pie chart background (stylized, non-functional)
          Positioned(
            left: 165,
            top: 155,
            child: Container(
              transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
              width: 155,
              height: 155,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: Stack(
                children: [
                  Positioned(
                    left: 0.04,
                    top: 0.39,
                    child: Container(
                      width: 154.57,
                      height: 154.57,
                      decoration: const ShapeDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0.85, 0.00),
                          end: Alignment(-0.00, 0.83),
                          colors: [Color(0xFFACFFF7)],
                        ),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0.04,
                    top: 0.39,
                    child: Container(
                      width: 154.57,
                      height: 154.57,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFF723E),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0.04,
                    top: 0.39,
                    child: Container(
                      width: 154.57,
                      height: 154.57,
                      decoration: const ShapeDecoration(
                        color: Color(0xFF145C6E),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0.04,
                    top: 0.39,
                    child: Container(
                      width: 154.57,
                      height: 154.57,
                      decoration: const ShapeDecoration(
                        color: Color(0xFF39CEF3),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 102,
                    top: 88,
                    child: SizedBox(
                      width: 50,
                      height: 20,
                      child: Transform(
                        transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
                        child: Text(
                          '$total',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Watched clickable
          Positioned(
            left: 186,
            top: 35,
            child: Container(
              width: 10,
              height: 10,
              decoration: const ShapeDecoration(
                color: Color(0xFFACFFF7),
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            left: 200,
            top: 30,
            child: GestureDetector(
              onTap: () => Get.toNamed('/watched'),
              child: SizedBox(
                width: 100,
                height: 20,
                child: Text(
                  'Watched',
                  style: TextStyle(
                    color: Color(0xFF145C6E),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 300,
            top: 30,
            child: SizedBox(
              width: 40,
              height: 20,
              child: Text(
                '$watched',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          // Plan to Watch clickable
          Positioned(
            left: 186,
            top: 60,
            child: Container(
              width: 10,
              height: 10,
              decoration: const ShapeDecoration(
                color: Color(0xFF39CEF3),
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            left: 200,
            top: 55,
            child: GestureDetector(
              onTap: () => Get.toNamed('/plan_to_watch'),
              child: SizedBox(
                width: 100,
                height: 20,
                child: Text(
                  'Plan to Watch',
                  style: TextStyle(
                    color: Color(0xFF145C6E),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 300,
            top: 55,
            child: SizedBox(
              width: 50,
              height: 20,
              child: Text(
                '$planToWatch',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          // Rewatched clickable
          Positioned(
            left: 186,
            top: 85,
            child: Container(
              width: 10,
              height: 10,
              decoration: const ShapeDecoration(
                color: Color(0xFF145C6E),
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            left: 200,
            top: 80,
            child: GestureDetector(
              onTap: () => Get.toNamed('/rewatched'),
              child: SizedBox(
                width: 100,
                height: 20,
                child: Text(
                  'Rewatched',
                  style: TextStyle(
                    color: Color(0xFF145C6E),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 300,
            top: 80,
            child: SizedBox(
              width: 50,
              height: 20,
              child: Text(
                '$rewatched',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          // Dropped clickable
          Positioned(
            left: 186,
            top: 110,
            child: Container(
              width: 10,
              height: 10,
              decoration: const ShapeDecoration(
                color: Color(0xFFFF723E),
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            left: 200,
            top: 105,
            child: GestureDetector(
              onTap: () => Get.toNamed('/dropped'),
              child: SizedBox(
                width: 100,
                height: 20,
                child: Text(
                  'Dropped',
                  style: TextStyle(
                    color: Color(0xFF145C6E),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 300,
            top: 105,
            child: SizedBox(
              width: 50,
              height: 20,
              child: Text(
                '$dropped',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}