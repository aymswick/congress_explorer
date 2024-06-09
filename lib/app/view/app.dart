import 'package:congress_explorer/about/about.dart';
import 'package:congress_explorer/feed/feed.dart';
import 'package:congress_explorer/member/view/members_page.dart';
import 'package:congress_repository/congress_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

final logger = Logger(filter: ProductionFilter());

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;

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
          body: switch (_selectedIndex) {
            0 => const FeedPage(),
            1 => const MembersPage(),
            2 => const AboutPage(),
            _ => const FeedPage()
          },
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) => setState(() => _selectedIndex = index),
            currentIndex: _selectedIndex,
            items: const [
              BottomNavigationBarItem(label: 'Feed', icon: Icon(Icons.feed)),
              BottomNavigationBarItem(
                label: 'People',
                icon: Icon(Icons.people_alt),
              ),
              BottomNavigationBarItem(
                label: 'About',
                icon: Icon(Icons.question_mark),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
