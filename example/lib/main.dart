import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('he'),
      ],
      locale: const Locale('he'),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: CommentTreeWidget<Comment, Comment>(
          Comment(
              avatar: 'null',
              userName: 'null',
              content: 'felangel made felangel/cubit_and_beyond public '),
          [
            {
              Comment(
                  avatar: 'null',
                  userName: 'null',
                  content: 'replies level 1'): [
                Comment(
                    avatar: 'null', userName: 'null', content: 'Reply level 2'),
                Comment(
                    avatar: 'null', userName: 'null', content: 'Reply level 2'),
                Comment(
                    avatar: 'null', userName: 'null', content: 'Reply level 2'),
                Comment(
                    avatar: 'null', userName: 'null', content: 'Reply level 2'),
              ]
            },
            {
              Comment(
                  avatar: 'null',
                  userName: 'null',
                  content: 'replies level 1'): [
                Comment(
                    avatar: 'null', userName: 'null', content: 'Reply level 2'),
                Comment(
                    avatar: 'null', userName: 'null', content: 'Reply level 2'),
                Comment(
                    avatar: 'null', userName: 'null', content: 'Reply level 2'),
                Comment(
                    avatar: 'null', userName: 'null', content: 'Reply level 2'),
                Comment(
                    avatar: 'null', userName: 'null', content: 'Reply level 2'),
                Comment(
                    avatar: 'null', userName: 'null', content: 'Reply level 2'),
                Comment(
                    avatar: 'null', userName: 'null', content: 'Reply level 2'),
              ]
            },
            {
              Comment(
                  avatar: 'null',
                  userName: 'null',
                  content: 'replies level 1'): [
                Comment(
                    avatar: 'null', userName: 'null', content: 'Reply level 2'),
                Comment(
                    avatar: 'null', userName: 'null', content: 'Reply level 2'),
                Comment(
                    avatar: 'null', userName: 'null', content: 'Reply level 2'),
              ]
            },
          ],
          isLast: true,
          treeThemeData: TreeThemeData(
              lineColor: Theme.of(context).primaryColor, lineWidth: 1),
          avatarRoot: (context, data) => PreferredSize(
            child: Icon(Icons.account_circle,
                size: 42, color: Theme.of(context).primaryColor),
            preferredSize: const Size.fromRadius(21),
          ),
          avatarChild: (context, data) {
            return PreferredSize(
              child: Icon(Icons.account_circle,
                  size: 32, color: Theme.of(context).primaryColor),
              preferredSize: const Size.fromRadius(18),
            );
          },
          contentChild: (context, data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _commentCell(
                  context,
                  data,
                ),
                _commentActionsWidget(context),
              ],
            );
          },
          contentRoot: (context, data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _commentCell(context, data),
                _commentActionsWidget(context)
              ],
            );
          },
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
    );
  }

  Widget _commentCell(
    BuildContext context,
    Comment comment,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(comment.userName ?? '',
                  style: Theme.of(context).textTheme.caption?.copyWith(
                      fontWeight: FontWeight.w600, color: Colors.black),
                  textAlign: TextAlign.start),
              const Spacer(),
              Text('12/12/12, 12:12',
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(color: Colors.black)),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Text('${comment.content}',
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(fontWeight: FontWeight.w300, color: Colors.black),
              textAlign: TextAlign.start),
        ],
      ),
    );
  }

  Widget _commentActionsWidget(
    BuildContext context,
  ) {
    return DefaultTextStyle(
      style: Theme.of(context)
          .textTheme
          .caption!
          .copyWith(color: Colors.grey[700], fontWeight: FontWeight.bold),
      child: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Row(
          children: [
            const SizedBox(
              width: 8,
            ),
            Text('Like'),
            const SizedBox(
              width: 24,
            ),
            Text('Comment'),
            const Spacer(),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text('2',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(fontSize: 12)),
                ),
                ClipOval(
                  child: Container(
                      height: 20,
                      width: 20,
                      color: Theme.of(context).primaryColor,
                      child: const Center(
                          child: Icon(Icons.thumb_up,
                              color: Colors.white, size: 10))),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
