import 'package:flutter/material.dart';
import './comment_child_widget.dart';
import './root_comment_widget.dart';
import './tree_theme_data.dart';
import 'package:provider/provider.dart';

typedef AvatarWidgetBuilder<T> = PreferredSize Function(
  BuildContext context,
  T value,
);
typedef ContentBuilder<T> = Widget Function(BuildContext context, T value);

class CommentTreeWidget<R, C> extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = 'CommentTreeWidget';

  final R root;
  final List<C> replies;
  final List<C>? repliesLevelTwo;
  // final List<C>? repliesLevelThree;
  // final List<C>? repliesLevelFour;

  final AvatarWidgetBuilder<R>? avatarRoot;
  final ContentBuilder<R>? contentRoot;

  final AvatarWidgetBuilder<C>? avatarChild;
  final ContentBuilder<C>? contentChild;

  final TreeThemeData treeThemeData;

  const CommentTreeWidget(
    this.root,
    this.replies, {
    this.repliesLevelTwo,
    this.treeThemeData = const TreeThemeData(lineWidth: 1),
    this.avatarRoot,
    this.contentRoot,
    this.avatarChild,
    this.contentChild,
    // this.repliesLevelThree,
    // this.repliesLevelFour
  });

  @override
  _CommentTreeWidgetState<R, C> createState() =>
      _CommentTreeWidgetState<R, C>();
}

class _CommentTreeWidgetState<R, C> extends State<CommentTreeWidget<R, C>> {
  @override
  Widget build(BuildContext context) {
    final PreferredSize avatarRoot = widget.avatarRoot!(context, widget.root);

    return Provider<TreeThemeData>.value(
      value: widget.treeThemeData,
      child: Column(
        children: [
          RootCommentWidget(
            avatarRoot,
            widget.contentRoot!(context, widget.root),
          ),
          ...widget.replies.map(
            (e) => CommentChildWidget(
              commentLevel: 1,
              isLast: widget.replies.indexOf(e) == (widget.replies.length - 1),
              avatar: widget.avatarChild!(context, e),
              avatarRoot: avatarRoot.preferredSize,
              content: widget.contentChild!(context, e),
              hasReplies: widget.repliesLevelTwo != null &&
                  widget.repliesLevelTwo!.isNotEmpty,
            ),
          ),
          if (widget.repliesLevelTwo != null &&
              widget.repliesLevelTwo!.isNotEmpty)
            ...widget.repliesLevelTwo!.map(
              (e) => CommentChildWidget(
                  commentLevel: 2,
                  isLast: widget.repliesLevelTwo!.indexOf(e) ==
                      (widget.repliesLevelTwo!.length - 1),
                  avatar: widget.avatarChild!(context, e),
                  avatarRoot: avatarRoot.preferredSize,
                  content: widget.contentChild!(context, e),
                  hasReplies: false),
            ),
          // if (widget.repliesLevelThree != null &&
          //     widget.repliesLevelThree!.isNotEmpty)
          //   ...widget.repliesLevelThree!.map(
          //     (e) => CommentChildWidget(
          //       commentLevel: 3,
          //       isLast: widget.repliesLevelThree!.indexOf(e) ==
          //           (widget.repliesLevelThree!.length - 1),
          //       avatar: widget.avatarChild!(context, e),
          //       avatarRoot: avatarRoot.preferredSize,
          //       content: widget.contentChild!(context, e),
          //       hasReplies: widget.repliesLevelFour != null &&
          //           widget.repliesLevelFour!.isNotEmpty,
          //     ),
          //   ),
          // if (widget.repliesLevelFour != null &&
          //     widget.repliesLevelFour!.isNotEmpty)
          //   ...widget.repliesLevelFour!.map(
          //     (e) => CommentChildWidget(
          //         commentLevel: 4,
          //         isLast: widget.repliesLevelFour!.indexOf(e) ==
          //             (widget.repliesLevelFour!.length - 1),
          //         avatar: widget.avatarChild!(context, e),
          //         avatarRoot: avatarRoot.preferredSize,
          //         content: widget.contentChild!(context, e),
          //         hasReplies: false),
          //   )
        ],
      ),
    );
  }
}
