import 'package:equatable/equatable.dart';

/// A member of congress
class Member extends Equatable {
  ///
  const Member({
    required this.name,
    required this.party,
    required this.state,
    this.imageUrl,
  });

  ///
  final String name;

  ///
  final String party;

  ///
  final String state;

  ///
  final Uri? imageUrl;

  @override
  List<Object?> get props => [name, party, state, imageUrl];
}
