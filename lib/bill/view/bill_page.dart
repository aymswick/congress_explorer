import 'package:congress_explorer/utils.dart';
import 'package:congress_repository/congress_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BillPage extends StatelessWidget {
  const BillPage({required this.bill, super.key});

  final Bill bill;

  @override
  Widget build(BuildContext context) {
    final repository = context.read<CongressRepository>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News for ${bill.title}',
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context)..pop(),
            icon: const Icon(Icons.arrow_back),
          ),
        ],
      ),
      body: FutureBuilder(
        future: repository.getRelatedStories(bill.title),
        builder: (context, snapshot) {
          final stories = !snapshot.hasData
              ? List.filled(
                  3,
                  Story(
                    headline: 'Example Headline',
                    url: Uri.parse('https://google.com'),
                    source: 'Website',
                  ),
                )
              : snapshot.data!;

          return Skeletonizer(
            enabled: !snapshot.hasData,
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
          );
        },
      ),
    );
  }
}
