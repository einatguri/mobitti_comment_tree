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
  final List<Map<C, List<C>?>> replies;

  final AvatarWidgetBuilder<R>? avatarRoot;
  final ContentBuilder<R>? contentRoot;

  final AvatarWidgetBuilder<C>? avatarChild;
  final ContentBuilder<C>? contentChild;

  final TreeThemeData treeThemeData;

  const CommentTreeWidget(
    this.root,
    this.replies, {
    this.treeThemeData = const TreeThemeData(lineWidth: 1),
    this.avatarRoot,
    this.contentRoot,
    this.avatarChild,
    this.contentChild,
  });

  @override
  _CommentTreeWidgetState<R, C> createState() =>
      _CommentTreeWidgetState<R, C>();
}

class _CommentTreeWidgetState<R, C> extends State<CommentTreeWidget<R, C>> {
  @override
  Widget build(BuildContext context) {
    int totalNumberOfComments = widget.replies.length;

    for (final reply in widget.replies) {
      reply.forEach((key, value) {
        if (value != null) {
          totalNumberOfComments += value.length;
        }
      });
    }

    final PreferredSize avatarRoot = widget.avatarRoot!(context, widget.root);

    return Provider<TreeThemeData>.value(
      value: widget.treeThemeData,
      child: Column(
        children: [
          RootCommentWidget(
            avatarRoot,
            widget.contentRoot!(context, widget.root),
            commentLevel: 0,
            totalNumberOfComments:
                totalNumberOfComments - widget.replies.length,
          ),
          ..._buildReplies(avatarRoot)
        ],
      ),
    );
  }

  List<Widget> _buildReplies(PreferredSize avatarRoot) {
    final List<Widget> _replies = [];
    for (final reply in widget.replies) {
      reply.forEach((key, value) {
        _replies.add(Column(
          children: [
            CommentChildWidget(
                commentLevel: 1,
                isLast: widget.replies.indexOf(reply) ==
                    (widget.replies.length - 1),
                avatar: widget.avatarChild!(context, key),
                avatarRoot: avatarRoot.preferredSize,
                content: widget.contentChild!(context, key),
                numberOfReplies: value?.length ?? 0),
            if (value != null && value.isNotEmpty)
              ...value.map(
                (e) => Column(
                  children: [
                    CommentChildWidget(
                        commentLevel: 2,
                        isLast: value.indexOf(e) == (value.length - 1),
                        avatar: widget.avatarChild!(context, e),
                        avatarRoot: avatarRoot.preferredSize,
                        content: widget.contentChild!(context, e),
                        numberOfReplies: 0),
                  ],
                ),
              ),
          ],
        ));
      });
    }
    return _replies;
  }
}
