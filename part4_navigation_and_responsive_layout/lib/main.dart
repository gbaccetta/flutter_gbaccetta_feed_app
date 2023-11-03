import 'package:flutter/material.dart';
import 'package:flutter_gbaccetta_feed_app/core/locators/locator.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/article.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/providers/article_list.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/providers/user.dart';
import 'package:flutter_gbaccetta_feed_app/ui/routing/router.dart';
import 'package:flutter_gbaccetta_feed_app/ui/screens/article_list/article_list_view.dart';
import 'package:provider/provider.dart';

void main() {
  serviceLocatorInitialization();
  runApp(const GBAccettaApp());
}

class GBAccettaApp extends StatelessWidget {
  const GBAccettaApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => User(id: 'id', name: 'name')),
        ChangeNotifierProvider(create: (_) => ArticleList())
      ],
      child: MaterialApp.router(
        color: Colors.white,
        title: 'GBAccetta Portfolio',
        // TODO app theming will be addressed in part 5 of this guide
        theme: ThemeData(primarySwatch: Colors.green),
        // TODO proper navigation will be addressed in part 4 of this guide
        routerConfig: AppRouter.simpleRouter,
      ),
    );
  }
}
