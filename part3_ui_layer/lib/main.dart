import 'package:flutter/material.dart';
import 'package:flutter_gbaccetta_feed_app/core/locators/locator.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/article_list/article_list_view.dart';

void main() {
  serviceLocatorInitialization();
  runApp(const GBAccettaApp());
}

class GBAccettaApp extends StatelessWidget {
  const GBAccettaApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GBAccetta Portfolio',
      // TODO app theming will be addressed in part 5 of this guide
      theme: ThemeData(primarySwatch: Colors.green),
      // TODO proper navigation will be addressed in part 4 of this guide
      home: const ArticleListView(),
    );
  }
}
