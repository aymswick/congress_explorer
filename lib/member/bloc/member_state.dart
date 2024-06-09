part of '../bloc/member_bloc.dart';

enum MemberStatus {
  initial,
  success,
  failure,
}

class MemberState extends Equatable {
  const MemberState({
    this.members = const [],
    this.status = MemberStatus.initial,
  });

  MemberState copyWith({MemberStatus? status, List<Member>? members}) =>
      MemberState(
        status: status ?? this.status,
        members: members ?? this.members,
      );

  final List<Member> members;
  final MemberStatus status;

  @override
  List<Object> get props => [members, status];
}
