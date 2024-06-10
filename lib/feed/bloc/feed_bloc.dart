import 'package:bloc/bloc.dart';
import 'package:congress_repository/congress_repository.dart';
import 'package:equatable/equatable.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc({required this.repository}) : super(const FeedState()) {
    on<FeedRefreshed>((event, emit) async {
      final bills = await repository.getBills();
      final hearings = await repository.getHearings();
      final treaties = await repository.getTreaties();

      emit(
        state.copyWith(
          status: FeedStatus.success,
          bills: bills,
          hearings: hearings,
          treaties: treaties,
        ),
      );
    });

    on<FeedItemExpanded>((event, emit) async {
      final index = state.bills.indexOf(event.bill);

      emit(state.copyWith(status: FeedStatus.loading));

      final stories = await repository.getRelatedStories(event.bill.title);

      emit(
        state.copyWith(
          status: FeedStatus.success,
          bills: List.of(state.bills)
            ..removeAt(
              index,
            )
            ..insert(
              index,
              event.bill.copyWith(relatedStories: stories),
            ),
        ),
      );
    });

    on<FiltersModified>((event, emit) async {
      emit(
        state.copyWith(
          status: FeedStatus.success,
          filter: event.payload,
        ),
      );
    });
  }

  final CongressRepository repository;
}
