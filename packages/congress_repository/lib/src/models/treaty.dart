import 'package:equatable/equatable.dart';

///
class Treaty extends Equatable {
  ///
  const Treaty({
    required this.topic,
    required this.updateDate,
  });

  ///
  final String topic;

  ///
  final DateTime? updateDate;

  @override
  List<Object?> get props => [topic, updateDate];
}
