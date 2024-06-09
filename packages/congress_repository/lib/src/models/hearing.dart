import 'package:equatable/equatable.dart';

///
class Hearing extends Equatable {
  ///
  const Hearing({
    required this.title,
    required this.chamber,
    required this.congress,
    required this.number,
    this.transcriptUrl,
    this.updateDate,
  });

  /// Hearing Topic
  final String title;

  /// House / Senate
  final String chamber;

  /// Ex. 116
  final int congress;

  ///
  final int number;

  /// URL to a text representation of the transcript
  final Uri? transcriptUrl;

  ///
  final DateTime? updateDate;

  @override
  List<Object?> get props =>
      [title, chamber, congress, number, transcriptUrl, updateDate];
}
