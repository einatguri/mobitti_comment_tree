import './tree_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'root_comment_widget.dart';

class CommentChildWidget extends StatelessWidget {
  final PreferredSizeWidget? avatar;
  final Widget? content;
  final bool? isLast;
  final Size? avatarRoot;
  final int commentLevel;
  final int numberOfReplies;

  const CommentChildWidget(
      {required this.isLast,
      required this.avatar,
      required this.content,
      required this.avatarRoot,
      required this.commentLevel,
      required this.numberOfReplies,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isRTL = Directionality.of(context) == TextDirection.rtl;
    final horizontalPadding = commentLevel == 1
        ? (avatarRoot!.width + 6.0) * commentLevel
        : avatarRoot!.width * commentLevel;

    final EdgeInsets padding = EdgeInsets.only(
        left: isRTL ? 0 : horizontalPadding,
        bottom: 8.0,
        top: 8.0,
        right: isRTL ? horizontalPadding : 0);

    return CustomPaint(
        painter: _Painter(
          isLast: isLast!,
          padding: padding,
          textDirection: Directionality.of(context),
          avatarRoot: commentLevel > 1
              ? Size(avatarRoot!.width * (commentLevel + 1), avatarRoot!.height)
              : avatarRoot,
          avatarChild: avatar!.preferredSize,
          pathColor: context.watch<TreeThemeData>().lineColor,
          strokeWidth: context.watch<TreeThemeData>().lineWidth,
        ),
        child: numberOfReplies > 0
            ? CustomPaint(
                painter: RootPainter(
                    Size(avatarRoot!.width * (commentLevel + 2),
                        avatarRoot!.height),
                    context.watch<TreeThemeData>().lineColor,
                    context.watch<TreeThemeData>().lineWidth,
                    Directionality.of(context),
                    commentLevel: commentLevel,
                    totalNumberOfComments: 0,
                    isLast: isLast!,
                    directReplyCount: numberOfReplies),
                child: contentWidget(padding))
            : contentWidget(padding));
  }

  Widget contentWidget(EdgeInsets padding) => Container(
        padding: padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            avatar!,
            const SizedBox(
              width: 4,
            ),
            Expanded(child: content!),
          ],
        ),
      );
}

class _Painter extends CustomPainter {
  bool isLast = false;

  EdgeInsets? padding;
  final TextDirection textDirection;
  Size? avatarRoot;
  Size? avatarChild;
  Color? pathColor;
  double? strokeWidth;

  _Painter({
    required this.isLast,
    required this.textDirection,
    this.padding,
    this.avatarRoot,
    this.avatarChild,
    this.pathColor,
    this.strokeWidth,
  }) {
    _paint = Paint()
      ..color = pathColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth!
      ..strokeCap = StrokeCap.round;
  }

  late Paint _paint;

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();
    if (textDirection == TextDirection.rtl) canvas.translate(size.width, 0);
    double rootDx = avatarRoot!.width / 2;
    if (textDirection == TextDirection.rtl) rootDx *= -1;
    path.moveTo(rootDx, 0);
    path.cubicTo(
      rootDx,
      0,
      rootDx,
      padding!.top + avatarChild!.height / 2,
      textDirection == TextDirection.rtl ? rootDx - 20 : rootDx + 20,
      padding!.top + avatarChild!.height / 2,
    );
    canvas.drawPath(path, _paint);

    if (!isLast) {
      canvas.drawLine(
        Offset(rootDx, 0),
        Offset(rootDx, size.height),
        _paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
