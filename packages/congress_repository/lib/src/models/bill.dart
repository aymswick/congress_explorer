import 'package:equatable/equatable.dart';

/// A piece of legislation
class Bill extends Equatable {
  ///
  const Bill({
    required this.number,
    required this.title,
    required this.url,
    this.latestAction,
    this.relatedStories = const [],
  });

  /// Bill No.
  final int number;

  /// Common name
  final String title;

  /// Web Resource locator
  final Uri url;

  /// Reason the bill is appearing in this feed
  final (DateTime date, String summary)? latestAction;

  /// Related stories from around the web
  final List<Story> relatedStories;

  @override
  List<Object?> get props => [number, title, url];
}

/// Related stories from around the web
class Story {
  ///
  const Story({
    required this.url,
    required this.headline,
    required this.source,
    this.publishDate,
  });

  ///
  final Uri url;

  ///
  final String headline;

  ///
  final String source;

  ///
  final DateTime? publishDate;
}
