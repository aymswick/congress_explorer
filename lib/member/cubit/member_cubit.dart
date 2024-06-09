import 'package:bloc/bloc.dart';
import 'package:congress_repository/congress_repository.dart';
import 'package:equatable/equatable.dart';

part 'member_state.dart';

class MemberCubit extends Cubit<MemberState> {
  MemberCubit(this.repository) : super(const MemberState());

  Future<List<Member>> getMembers() async {
    return repository.getMembers();
  }

  final CongressRepository repository;
}
