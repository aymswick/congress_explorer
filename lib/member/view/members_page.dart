import 'package:cached_network_image/cached_network_image.dart';
import 'package:congress_explorer/member/bloc/member_bloc.dart';
import 'package:congress_repository/congress_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MembersPage extends StatelessWidget {
  const MembersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MemberBloc(context.read<CongressRepository>())
        ..add(MembersRefreshed()),
      child: BlocBuilder<MemberBloc, MemberState>(
        builder: (context, state) {
          final members = state.status == MemberStatus.initial
              ? List.filled(
                  10,
                  const Member(
                    name: 'John Q Sample',
                    party: 'Independent',
                    state: 'California',
                  ),
                )
              : state.members;
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Members',
              ),
            ),
            body: Skeletonizer(
              enabled: state.status == MemberStatus.initial,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: members.length,
                itemBuilder: (context, index) {
                  final member = members[index];
                  return ListTile(
                    title: Text(member.name),
                    subtitle: Text('${member.party} - ${member.state}'),
                    leading: CachedNetworkImage(
                      imageUrl: member.imageUrl?.toString() ?? '',
                      placeholder: (context, url) =>
                          const CircularProgressIndicator.adaptive(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.person),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
