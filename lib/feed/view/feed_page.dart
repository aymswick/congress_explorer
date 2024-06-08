import 'package:congress_explorer/feed/feed.dart';
import 'package:congress_explorer/utils.dart';
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

class FeedItem extends StatefulWidget {
  const FeedItem(
    this.bill, {
    super.key,
  });

  final Bill bill;

  @override
  State<FeedItem> createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {
  bool _isRelative = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(widget.bill.title),
        subtitle: Text('No. ${widget.bill.number}'),
        leading: const Icon(Icons.document_scanner),
        trailing: TextButton(
          onPressed: () => setState(
            () => _isRelative = !_isRelative,
          ),
          child: Text(
            '''${_isRelative ? widget.bill.latestAction?.$1.timeAgo : widget.bill.latestAction?.$1.localDate}''',
          ),
        ),
        children: [
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final story = widget.bill.relatedStories[index];
              return ListTile(
                title: Text(story.headline),
                subtitle: Text(story.source),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.arrow_forward,
                  ),
                  onPressed: () => openUrl(story.url),
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: widget.bill.relatedStories.length,
          ),
        ],
      ),
    );
  }
}
