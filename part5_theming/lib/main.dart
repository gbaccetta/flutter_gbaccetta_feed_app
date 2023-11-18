import 'package:flutter/material.dart';
import 'package:flutter_gbaccetta_feed_app/core/locators/locator.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/providers/article_list.dart';
import 'package:flutter_gbaccetta_feed_app/domain/models/providers/user.dart';
import 'package:flutter_gbaccetta_feed_app/ui/routing/app_router.dart';
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
        ChangeNotifierProvider(create: (_) => ArticleListProvider())
      ],
      child: MaterialApp.router(
        title: 'GBAccetta Portfolio',
        // TODO app theming will be addressed in part 5 of this guide
        theme: ThemeData(primarySwatch: Colors.green),
        routerConfig: AppRouter.simpleRouter,
      ),
    );
  }
}
