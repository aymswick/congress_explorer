import 'package:bloc/bloc.dart';
import 'package:congress_repository/congress_repository.dart';
import 'package:equatable/equatable.dart';

part 'member_event.dart';
part 'member_state.dart';

class MemberBloc extends Bloc<MemberEvent, MemberState> {
  MemberBloc(this.repository) : super(const MemberState()) {
    on<MembersRefreshed>((event, emit) async {
      final members = await repository.getMembers();

      emit(state.copyWith(members: members, status: MemberStatus.success));
    });
  }

  final CongressRepository repository;
}
