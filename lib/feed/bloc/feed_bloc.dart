import 'package:bloc/bloc.dart';
import 'package:congress_repository/congress_repository.dart';
import 'package:equatable/equatable.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc({required this.repository}) : super(const FeedState()) {
    on<FeedRefreshed>((event, emit) async {
      final bills = await repository.getBills();
      emit(state.copyWith(status: FeedStatus.success, bills: bills));
    });
  }

  final CongressRepository repository;
}
