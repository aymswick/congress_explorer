import 'package:download/download.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: const Text('What is this?'),
                  subtitle: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text:
                              '''This app is a Congressional API Explorer that can currently display a feed of the latest Bill (as in, ''',
                        ),
                        TextSpan(
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.lightBlue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => launchUrl(
                                  Uri.parse(
                                    'https://www.youtube.com/watch?v=OgVKvqTItto',
                                  ),
                                ),
                          text: '''"I'm just a" ''',
                        ),
                        const TextSpan(
                          text:
                              ''') updates along with a few related news stories from around the web. It was built in roughly 5 hours on a weekend to showcase my ability to rapidly prototype user interfaces and create simple applications using publicly available data. I would thrive in a position at ProPublica wherein I was responsible for going out and creating whatever a journalist needed to enhance a story - this entire app itself is ''',
                        ),
                        TextSpan(
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.lightBlue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => launchUrl(
                                  Uri.parse(
                                    'https://docs.flutter.dev/deployment/web#embedding-a-flutter-app-into-an-html-page',
                                  ),
                                ),
                          text: 'easily embeddable within a web page',
                        ),
                        const TextSpan(
                          text:
                              ''' - because I believe the abilities of software engineers (people like me) have been grossly misallocated in our society, that we suffer for it greatly, and that I have a responsibility to correct it.''',
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('Who made it?'),
                  subtitle: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Me, ',
                        ),
                        TextSpan(
                          text: 'Anthony Symkowick',
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text:
                              ''' a software engineer with 8 years of experience building web and mobile experiences for people who deserve them. I have a tuned ''',
                        ),
                        TextSpan(
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.lightBlue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => launchUrl(
                                  Uri.parse(
                                    'https://symkowick.org/posts/open-web-rant/',
                                  ),
                                ),
                          text: 'ethical compass',
                        ),
                        const TextSpan(text: ', '),
                        TextSpan(
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.lightBlue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => launchUrl(
                                  Uri.parse(
                                    'https://highsobriety.bandcamp.com/album/raw-materials',
                                  ),
                                ),
                          text: 'reliable creative outlets',
                        ),
                        const TextSpan(text: ', and '),
                        TextSpan(
                          children: [
                            const TextSpan(
                              text:
                                  'many thoughts about our current information ',
                            ),
                            TextSpan(
                              text: 'hellscape',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            TextSpan(
                              text: ' landscape.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.lightBlue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => launchUrl(
                                      Uri.parse(
                                        'https://symkowick.org/posts/public-university-or-corporate-intellect-farm/',
                                      ),
                                    ),
                            ),
                          ],
                        ),
                        const TextSpan(
                          text:
                              ' I currently work as a Software Developer and general technologist at Ecology Action, a wonderful non-profit located in Santa Cruz, California committed to carbon reduction and community outreach. The former is primarly achieved through commerical building energy-efficiency upgrades, and the latter through a team of empathetic, dedicated humans I feel lucky to be a part of. Unfortunately, the reality that they may not need full-fledged software engineering has presented itself, allowing me the privilege of reevaluating my career trajectory.',
                        ),
                      ],
                    ),
                  ),
                ),
                const ListTile(
                  title: Text('Why does _blank_ not work?'),
                  subtitle: Text(
                    r'''I'm so sorry if you encounter a bug - since speed of design, development, and deployment were of vital importance, I intentionally did not spend money on any of the APIs used in the app, and there are significant limitations that I am mostly working around. I was using a much better API for gathering related news, but I discovered a never-before-seen pricing model when I released the first version to production - free API requests from localhost, and $500 the moment you upload your app to the public web. I found a truly free alternative which offers a worse service and quickly swapped it in. In a real production environment, I love finding the best bang-for-your-buck integration options and advocating for using open source tools first, then adding paid/closed-source offerings as needed. With more time, I would likely bypass using a news search aggregator altogether and pipe queries directly to a search engine, but that's really not the reason I made this.''',
                  ),
                ),
                ListTile(
                  title: const Text(
                    '''Can I contact you about hiring, collaboration, or just general inquiries?''',
                  ),
                  subtitle: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text:
                              '''Yes, absolutely! Please reach out to me via ''',
                        ),
                        TextSpan(
                          text: 'email',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.lightBlue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => launchUrl(
                                  Uri.parse(
                                    'mailto:anthony@symkowick.org',
                                  ),
                                ),
                        ),
                        const TextSpan(
                          text: ''' or message me on ''',
                        ),
                        TextSpan(
                          text: 'mastodon / the fediverse',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.lightBlue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => launchUrl(
                                  Uri.parse(
                                    'https://social.extremelyoffline.org/@ant',
                                  ),
                                ),
                        ),
                        const TextSpan(
                          text:
                              ''' with any questions you have about me or my work. Feel free to grab a copy of my current resume below.''',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            label: const Text('Download My Resume'),
            icon: const Icon(Icons.download),
            onPressed: () async {
              final resumeBytes =
                  (await rootBundle.load('assets/resume_symkowick_2024.pdf'))
                      .buffer
                      .asUint8List();

              return download(
                Stream.fromIterable(resumeBytes),
                'anthony_symkowick_resume.pdf',
              );
            },
          ),
        ],
      ),
    );
  }
}
