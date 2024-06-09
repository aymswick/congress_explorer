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

  Bill copyWith({
    int? number,
    String? title,
    Uri? url,
    (DateTime date, String summary)? latestAction,
    List<Story>? relatedStories,
  }) =>
      Bill(
        number: number ?? this.number,
        title: title ?? this.title,
        url: url ?? this.url,
        latestAction: latestAction ?? this.latestAction,
        relatedStories: relatedStories ?? this.relatedStories,
      );

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
  List<Object?> get props => [number, title, url, latestAction, relatedStories];
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
