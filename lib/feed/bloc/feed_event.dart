part of 'feed_bloc.dart';

sealed class FeedEvent {}

class FeedRefreshed extends FeedEvent {}

class BillQueried extends FeedEvent {
  BillQueried(this.bill);
  final Bill bill;
}
