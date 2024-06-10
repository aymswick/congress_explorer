part of 'feed_bloc.dart';

sealed class FeedEvent {}

class FeedRefreshed extends FeedEvent {}

class FeedItemExpanded extends FeedEvent {
  FeedItemExpanded(this.bill);
  final Bill bill;
}

class FiltersModified extends FeedEvent {
  FiltersModified(this.payload);

  final (String, bool) payload;
}
