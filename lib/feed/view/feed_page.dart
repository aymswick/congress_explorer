import 'package:congress_explorer/feed/feed.dart';
import 'package:congress_repository/congress_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FeedBloc(repository: context.read<CongressRepository>())
        ..add(FeedRefreshed()),
      child: const FeedView(),
    );
  }
}

class FeedView extends StatelessWidget {
  const FeedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feed')),
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          return Skeletonizer(
            enabled: state.bills.isEmpty,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.bills.length,
                itemBuilder: (context, index) => FeedItem(state.bills[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}

class FeedItem extends StatelessWidget {
  const FeedItem(
    this.bill, {
    super.key,
  });

  final Bill bill;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(bill.title),
        subtitle: Text('No. ${bill.number}'),
      ),
    );
  }
}
