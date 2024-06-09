part of 'member_cubit.dart';

class MemberState extends Equatable {
  const MemberState({this.members = const []});

  final List<Member> members;

  @override
  List<Object> get props => [members];
}
