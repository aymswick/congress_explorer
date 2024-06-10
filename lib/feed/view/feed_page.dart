import 'package:congress_explorer/app/app.dart';
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
      appBar: AppBar(title: const Text('Congressional Feed')),
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          final bills = state.status == FeedStatus.initial
              ? List.filled(
                  10,
                  Bill(
                    number: 0,
                    title: 'Test',
                    url: Uri.parse('https://google.com'),
                    latestAction: (DateTime.now(), 'Demo Action'),
                  ),
                )
              : state.bills;

          final hearings = state.status == FeedStatus.initial
              ? List.filled(
                  10,
                  const Hearing(
                    title: 'Demo',
                    chamber: 'House',
                    congress: 0,
                    number: 4,
                  ),
                )
              : state.hearings;

          final treaties = state.status == FeedStatus.initial
              ? List.filled(
                  10,
                  Treaty(
                    topic: 'Demo',
                    updateDate: DateTime.now(),
                  ),
                )
              : state.treaties;

          final bloc = context.read<FeedBloc>();

          logger.d(state.filter);

          final items = switch (state.filter) {
            (('hearings', true)) => hearings,
            (('bills', true)) => bills,
            (('treaties', true)) => treaties,
            (_) => [...hearings, ...bills, ...treaties],
          };

          return Skeletonizer(
            enabled: state.bills.isEmpty ||
                state.hearings.isEmpty ||
                state.treaties.isEmpty,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            avatar: const Icon(
                              Icons.gavel,
                              color: Colors.amber,
                            ),
                            label: const Text('Hearings'),
                            selected: state.filter == ('hearings', true),
                            onSelected: (value) {
                              bloc.add(FiltersModified(('hearings', value)));
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            avatar: const Icon(
                              Icons.document_scanner,
                              color: Colors.white,
                            ),
                            label: const Text('Bills'),
                            selected: state.filter == ('bills', true),
                            onSelected: (value) {
                              bloc.add(FiltersModified(('bills', value)));
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            avatar: const Icon(
                              Icons.handshake,
                              color: Colors.red,
                            ),
                            label: const Text('Treaties'),
                            selected: state.filter == ('treaties', true),
                            onSelected: (value) {
                              bloc.add(FiltersModified(('treaties', value)));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) =>
                          FeedItem(items[index], state.status),
                    ),
                  ),
                ],
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
    this.item,
    this.status, {
    super.key,
  });

  final dynamic item;

  final FeedStatus status;

  @override
  State<FeedItem> createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {
  bool _isRelative = true;

  @override
  Widget build(BuildContext context) {
    if (widget.item is Bill) {
      final bill = widget.item as Bill;

      final stories = widget.status == FeedStatus.loading
          ? List.filled(
              3,
              Story(
                headline: 'Example Headline',
                url: Uri.parse('https://google.com'),
                source: 'Website',
              ),
            )
          : bill.relatedStories;

      return Card(
        child: ExpansionTile(
          title: Text(bill.title),
          subtitle: Text('No. ${bill.number}'),
          leading: const Icon(Icons.document_scanner, color: Colors.white),
          trailing: TextButton(
            onPressed: () => setState(
              () => _isRelative = !_isRelative,
            ),
            child: Text(
              '''${_isRelative ? bill.latestAction?.$1.timeAgo : bill.latestAction?.$1.localDate}''',
            ),
          ),
          onExpansionChanged: (value) {
            if (value == true) {
              context.read<FeedBloc>().add(FeedItemExpanded(bill));
            }
          },
          children: [
            Skeletonizer(
              enabled: widget.status == FeedStatus.loading,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: stories.length,
                itemBuilder: (context, index) {
                  final story = stories[index];
                  return ListTile(
                    onTap: () => openUrl(story.url),
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
              ),
            ),
          ],
        ),
      );
    } else if (widget.item is Hearing) {
      final hearing = widget.item as Hearing;
      return Card(
        child: ListTile(
          leading: const Icon(Icons.gavel, color: Colors.amber),
          title: Text(hearing.title),
          trailing: TextButton(
            onPressed: () => setState(
              () => _isRelative = !_isRelative,
            ),
            child: Text(
              '''${_isRelative ? hearing.updateDate?.timeAgo : hearing.updateDate?.localDate}''',
            ),
          ),
          onTap: () => openUrl(hearing.transcriptUrl!),
        ),
      );
    } else if (widget.item is Treaty) {
      final treaty = widget.item as Treaty;
      return Card(
        child: ListTile(
          leading: const Icon(Icons.handshake, color: Colors.red),
          title: Text(treaty.topic),
          trailing: TextButton(
            onPressed: () => setState(
              () => _isRelative = !_isRelative,
            ),
            child: Text(
              '''${_isRelative ? treaty.updateDate?.timeAgo : treaty.updateDate?.localDate}''',
            ),
          ),
        ),
      );
    } else {
      return const Divider();
    }
  }
}
