part of 'feed_bloc.dart';

enum FeedStatus {
  initial,
  success,
  loading,
  failure,
}

class FeedState extends Equatable {
  const FeedState({
    this.status = FeedStatus.initial,
    this.bills = const [],
    this.hearings = const [],
    this.filter,
  });

  final FeedStatus status;
  final List<Bill> bills;
  final List<Hearing> hearings;
  final (String, bool)? filter;

  FeedState copyWith({
    FeedStatus? status,
    List<Bill>? bills,
    List<Hearing>? hearings,
    (String, bool)? filter,
  }) {
    return FeedState(
      status: status ?? this.status,
      bills: bills ?? this.bills,
      hearings: hearings ?? this.hearings,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object?> get props => [status, bills, hearings, filter];
}
