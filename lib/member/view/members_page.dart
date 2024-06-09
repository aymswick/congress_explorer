import 'package:congress_explorer/member/cubit/member_cubit.dart';
import 'package:congress_repository/congress_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MembersPage extends StatelessWidget {
  const MembersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MemberCubit(context.read<CongressRepository>())..getMembers(),
      child: Builder(
        builder: (context) {
          final cubit = context.watch<MemberCubit>();
          final state = cubit.state;
          return FutureBuilder(
            future: cubit.getMembers(),
            builder: (context, snapshot) {
              return Skeletonizer(
                enabled: !snapshot.hasData,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    final member = snapshot.data![index];
                    return ListTile(
                      title: Text(member.name),
                      subtitle: Text('${member.party} - ${member.state}'),
                      leading: member.imageUrl != null
                          ? CircleAvatar(
                              child: Image.network(member.imageUrl.toString()),
                            )
                          : const CircleAvatar(child: Icon(Icons.person)),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
