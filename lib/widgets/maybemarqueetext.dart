import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class MaybeMarqueeText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final double maxWidth;
  final TextAlign textAlign;

  const MaybeMarqueeText({
    super.key,
    required this.text,
    this.style,
    required this.maxWidth,
    this.textAlign = TextAlign.center,
  });

  bool isOverflowing(String text, TextStyle? style, double maxWidth) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);
    return tp.didExceedMaxLines;
  }

  @override
  Widget build(BuildContext context) {
    if (isOverflowing(text, style, maxWidth)) {
      return SizedBox(
        height: 18,
        width: maxWidth,
        child: Marquee(
          text: text,
          style: style,
          blankSpace: 20.0,
          velocity: 30.0,
          pauseAfterRound: const Duration(seconds: 1),
          startPadding: 0.0,
          scrollAxis: Axis.horizontal,
        ),
      );
    } else {
      return SizedBox(
        width: maxWidth,
        child: Text(
          text,
          style: style,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: textAlign,
        ),
      );
    }
  }
}
