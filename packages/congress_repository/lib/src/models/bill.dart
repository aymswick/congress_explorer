import 'package:equatable/equatable.dart';

/// A piece of legislation
class Bill extends Equatable {
  ///
  const Bill({required this.number, required this.title, required this.url});

  /// Bill No.
  final int number;

  /// Common name
  final String title;

  /// Web Resource locator
  final Uri url;

  @override
  List<Object?> get props => [number, title, url];
}
