part of 'feed_bloc.dart';

enum FeedStatus {
  initial,
  success,
  loading,
  failure,
}

class FeedState extends Equatable {
  const FeedState({this.status = FeedStatus.initial, this.bills = const []});

  final FeedStatus status;
  final List<Bill> bills;

  FeedState copyWith({FeedStatus? status, List<Bill>? bills}) {
    return FeedState(status: status ?? this.status, bills: bills ?? this.bills);
  }

  @override
  List<Object?> get props => [status, bills];
}
