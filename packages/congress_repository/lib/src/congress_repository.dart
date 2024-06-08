import 'dart:convert';

import 'package:congress_repository/src/models/bill.dart';
import 'package:http/http.dart' as http;

/// Repository layer to handle interaction between client and api.congress.gov
class CongressRepository {
  /// {@macro congress_repository}
  CongressRepository({required this.apiKey}) : client = http.Client();

  /// Get a free congressional API key here: https://api.congress.gov/sign-up/
  final String apiKey;

  /// Handles web requests
  final http.Client client;

  /// Returns a list of bills sorted by date of latest action.
  Future<List<Bill>> getBills() async {
    print(apiKey);
    final response = await client.get(
      Uri(
        host: 'api.congress.gov',
        path: '/v3/bill',
        queryParameters: {'api_key': apiKey},
        scheme: 'https',
      ),
    );

    final decodedResponse = jsonDecode(response.body);
    print(decodedResponse);
    final bills = (decodedResponse['bills'] as List<dynamic>).map((b) {
      print(b);
      return Bill(
        number: int.parse(b['number'] as String),
        title: b['title'] as String,
        url: Uri.parse('${b['url']}'),
      );
    }).toList();

    print(bills);

    return bills.isNotEmpty
        ? bills
        : [
            Bill(
              number: 0,
              title: 'Test',
              url: Uri.parse('https://google.com'),
            ),
          ];
  }
}
