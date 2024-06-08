import 'package:congress_explorer/feed/feed.dart';
import 'package:congress_repository/congress_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    const congressKey = String.fromEnvironment('CONGRESS_GOV_API_KEY');
    const newsKey = String.fromEnvironment('RELATED_NEWS_API_KEY');

    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.lightBlue,
        ),
        appBarTheme: const AppBarTheme(),
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: RepositoryProvider(
        create: (context) => CongressRepository(
          congressKey: congressKey,
          relatedNewsKey: newsKey,
        ),
        child: Scaffold(
          body: const FeedPage(),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(label: 'Feed', icon: Icon(Icons.feed)),
              BottomNavigationBarItem(
                label: 'Other',
                icon: Icon(Icons.question_answer),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
