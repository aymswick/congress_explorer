import 'dart:convert';

import 'package:congress_repository/src/models/bill.dart';
import 'package:http/http.dart' as http;

/// Repository layer to handle interaction between client and api.congress.gov
class CongressRepository {
  /// {@macro congress_repository}
  CongressRepository({required this.congressKey, required this.relatedNewsKey})
      : client = http.Client();

  /// Get a free congressional API key here: https://api.congress.gov/sign-up/
  final String congressKey;

  /// Search popular news across the web via newsapi.org
  final String relatedNewsKey;

  /// Handles web requests
  final http.Client client;

  /// Returns a list of bills sorted by date of latest action.
  Future<List<Bill>> getBills() async {
    final response = await client.get(
      Uri(
        host: 'api.congress.gov',
        path: '/v3/bill',
        queryParameters: {'api_key': congressKey},
        scheme: 'https',
      ),
    );

    final decodedResponse = jsonDecode(response.body);

    /// Retrieve bill feed from Congress.gov
    final bills = <Bill>[];
    for (final b in decodedResponse['bills'] as List<dynamic>) {
      final latestAction = b['latestAction'] as Map<String, dynamic>?;

      final storiesResponse = await client.get(
        Uri(
          host: 'newsapi.org',
          path: '/v2/everything',
          queryParameters: {
            'apiKey': relatedNewsKey,
            'q': b['title'],
          },
          scheme: 'https',
        ),
      );

      print(storiesResponse);

      final decodedStoriesResponse = jsonDecode(storiesResponse.body);

      final articles = decodedStoriesResponse['articles'] as List<dynamic>;

      final stories = <Story>[];

      for (final article in articles) {
        // Filter out duplicate headlines
        if (!stories
            .map(
              (e) => e.headline,
            )
            .contains(article['title'])) {
          stories.add(
            Story(
              headline: article['title'] as String,
              source: '${article['source']['name']}',
              url: Uri.parse(article['url'] as String),
            ),
          );
        }
      }

      bills.add(
        Bill(
          number: int.parse(b['number'] as String),
          title: b['title'] as String,
          url: Uri.parse('${b['url']}'),
          latestAction: (
            DateTime.parse(latestAction?['actionDate'] as String),
            latestAction?['text'] as String
          ),
          relatedStories: stories,
        ),
      );
    }

    /// Assemble related stories for each bill via newsapi.org
    /// key: 4870112ea27f43dba02242a9c0833e3a

    return bills.isNotEmpty
        ? bills
        : List.filled(
            10,
            Bill(
              number: 0,
              title: 'Test',
              url: Uri.parse('https://google.com'),
              latestAction: (DateTime.now(), 'Demo Action'),
            ),
          );
  }
}
