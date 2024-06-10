import 'dart:convert';

import 'package:congress_repository/congress_repository.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:recase/recase.dart';

/// Repository layer to handle interaction between client and api.congress.gov
class CongressRepository {
  /// {@macro congress_repository}
  CongressRepository({required this.congressKey, required this.relatedNewsKey})
      : client = http.Client(),
        logger = Logger(filter: ProductionFilter());

  /// Get a free congressional API key here: https://api.congress.gov/sign-up/
  final String congressKey;

  /// Search popular news across the web via newsapi.org
  final String relatedNewsKey;

  /// Handles web requests
  final http.Client client;

  /// Log info, debugs, errors
  final Logger logger;

  /// Returns a list of members sorted by date of latest action.
  Future<List<Hearing>> getHearings() async {
    final response = await client.get(
      Uri(
        host: 'api.congress.gov',
        path: '/v3/hearing',
        queryParameters: {'api_key': congressKey},
        scheme: 'https',
      ),
    );

    final decodedResponse = jsonDecode(response.body);

    /// Retrieve members feed from Congress.gov
    final hearings = <Hearing>[];
    for (final h in decodedResponse['hearings'] as List<dynamic>) {
      final response = await client.get(
        Uri(
          host: 'api.congress.gov',
          path:
              '/v3/hearing/${h['congress']}/${(h['chamber'] as String).toLowerCase()}/${h['jacketNumber']}',
          queryParameters: {'api_key': congressKey},
          scheme: 'https',
        ),
      );

      final decodedResponse2 = jsonDecode(response.body);
      final hearingDetail = decodedResponse2['hearing'] as Map<String, dynamic>;

      hearings.add(
        Hearing(
          title: (hearingDetail['title'] as String).toLowerCase().sentenceCase,
          transcriptUrl:
              Uri.parse(hearingDetail['formats'][0]['url'] as String),
          chamber: h['chamber'] as String,
          congress: h['congress'] as int,
          number: h['jacketNumber'] as int,
          updateDate: DateTime.parse(h['updateDate'] as String),
        ),
      );
    }

    return hearings;
  }

  /// Returns a list of members sorted by date of latest action.
  Future<List<Member>> getMembers() async {
    final members = <Member>[];

    /// There are 535 members of congress + senate, API page limit is 250
    for (var i = 0; i < 3; i++) {
      final response = await client.get(
        Uri(
          host: 'api.congress.gov',
          path: '/v3/member',
          queryParameters: {
            'api_key': congressKey,
            'currentMember': 'true',
            'offset': '${250 * i}',
            'limit': '250',
          },
          scheme: 'https',
        ),
      );

      final decodedResponse = jsonDecode(response.body);

      /// Retrieve members feed from Congress.gov
      for (final m in decodedResponse['members'] as List<dynamic>) {
        final depiction = m['depiction'] as Map<String, dynamic>?;

        members.add(
          Member(
            name: m['name'] as String,
            party: m['partyName'] as String,
            state: m['state'] as String,
            imageUrl: depiction != null
                ? Uri.parse(depiction['imageUrl'] as String)
                : null,
          ),
        );
      }
    }

    logger.d(members);

    return members;
  }

  /// Returns a list of treaties (includes only those with topics)
  Future<List<Treaty>> getTreaties() async {
    final treaties = <Treaty>[];

    final response = await client.get(
      Uri(
        host: 'api.congress.gov',
        path: '/v3/treaty',
        queryParameters: {
          'api_key': congressKey,
        },
        scheme: 'https',
      ),
    );

    final decodedResponse = jsonDecode(response.body);

    /// Retrieve members feed from Congress.gov
    for (final t in decodedResponse['treaties'] as List<dynamic>) {
      if (t['topic'] != null) {
        treaties.add(
          Treaty(
            topic: t['topic'] as String,
            updateDate: DateTime.parse(t['updateDate'] as String),
          ),
        );
      }
    }

    logger.d(treaties);

    return treaties;
  }

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

      bills.add(
        Bill(
          number: int.parse(b['number'] as String),
          title: b['title'] as String,
          url: Uri.parse('${b['url']}'),
          latestAction: (
            DateTime.parse(latestAction?['actionDate'] as String),
            latestAction?['text'] as String
          ),
        ),
      );
    }

    return bills;
  }

  /// Assemble related stories for each bill via newsapi.org
  Future<List<Story>> getRelatedStories(String billTitle) async {
    try {
      final storiesResponse = await client.get(
        Uri(
          host: 'api.thenewsapi.com',
          path: '/v1/news/all',
          queryParameters: {
            'api_token': relatedNewsKey,
            'search': billTitle,
          },
          scheme: 'https',
        ),
      );

      final decodedStoriesResponse = jsonDecode(storiesResponse.body);

      final articles = decodedStoriesResponse['data'] as List<dynamic>;

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
              source: '${article['source']}',
              url: Uri.parse(article['url'] as String),
            ),
          );
        }
      }

      return stories;
    } catch (err) {
      logger.e(err);
      return [
        Story(
          headline: 'Could not load stories',
          url: Uri.parse('https://example.com'),
          source: 'API Limit Reached',
        ),
      ];
    }
  }
}
