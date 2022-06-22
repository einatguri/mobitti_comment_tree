import './tree_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RootCommentWidget extends StatelessWidget {
  final PreferredSizeWidget avatar;
  final Widget content;
  final int commentLevel;
  final int totalNumberOfComments;
  final bool isLast;

  const RootCommentWidget(this.avatar, this.content,
      {required this.commentLevel,
      required this.totalNumberOfComments,
      required this.isLast});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RootPainter(
          avatar.preferredSize,
          context.watch<TreeThemeData>().lineColor,
          context.watch<TreeThemeData>().lineWidth,
          Directionality.of(context),
          commentLevel: commentLevel,
          totalNumberOfComments: totalNumberOfComments,
          isLast: isLast),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          avatar,
          const SizedBox(
            width: 4,
          ),
          Expanded(
            child: content,
          )
        ],
      ),
    );
  }
}

class RootPainter extends CustomPainter {
  Size? avatar;
  late Paint _paint;
  Color? pathColor;
  double? strokeWidth;
  int totalNumberOfComments;
  int commentLevel;
  bool isLast;
  final TextDirection textDecoration;
  RootPainter(
      this.avatar, this.pathColor, this.strokeWidth, this.textDecoration,
      {required this.commentLevel,
      required this.totalNumberOfComments,
      required this.isLast}) {
    _paint = Paint()
      ..color = pathColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth!
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (textDecoration == TextDirection.rtl) canvas.translate(size.width, 0);
    double dx = avatar!.width / 2;
    if (textDecoration == TextDirection.rtl) dx *= -1;
    canvas.drawLine(
      Offset(dx, avatar!.height),
      commentLevel == 0 && !isLast
          ? Offset(dx,
              size.height * (totalNumberOfComments + 20) - avatar!.height - 20)
          : Offset(dx, size.height),
      _paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
