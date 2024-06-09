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
  });

  final FeedStatus status;
  final List<Bill> bills;
  final List<Hearing> hearings;

  FeedState copyWith({
    FeedStatus? status,
    List<Bill>? bills,
    List<Hearing>? hearings,
  }) {
    return FeedState(
      status: status ?? this.status,
      bills: bills ?? this.bills,
      hearings: hearings ?? this.hearings,
    );
  }

  @override
  List<Object?> get props => [status, bills, hearings];
}
