import 'package:congress_explorer/feed/feed.dart';
import 'package:congress_repository/congress_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    const demoKey = String.fromEnvironment('CONGRESS_GOV_API_KEY');
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(),
        useMaterial3: true,
      ),
      home: RepositoryProvider(
        create: (context) => CongressRepository(apiKey: demoKey),
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
