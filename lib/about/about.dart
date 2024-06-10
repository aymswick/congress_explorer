import 'package:download/download.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              'What is this?',
              style: theme.textTheme.headlineLarge,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          '''This is a multiplatform (Web, iOS, Android, macOS, Windows, and Linux) Flutter app to explore the Congressional API. It can currently display a feed of the latest Bill (as in, ''',
                      style: theme.textTheme.bodyLarge,
                    ),
                    TextSpan(
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: Colors.lightBlue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => launchUrl(
                              Uri.parse(
                                'https://www.youtube.com/watch?v=OgVKvqTItto',
                              ),
                            ),
                      text: '''"I'm just a" ''',
                    ),
                    TextSpan(
                      text:
                          ''') , updates along with a few related news stories from around the web, as well as hearings with their associated transcripts. It was built in roughly 5 hours on a weekend to showcase my ability to rapidly prototype user interfaces and create simple applications using publicly available data. I would thrive in a position at ProPublica wherein I was responsible for going out and creating whatever a journalist needed to enhance a story - this entire app itself is ''',
                      style: theme.textTheme.bodyLarge,
                    ),
                    TextSpan(
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: Colors.lightBlue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => launchUrl(
                              Uri.parse(
                                'https://docs.flutter.dev/deployment/web#embedding-a-flutter-app-into-an-html-page',
                              ),
                            ),
                      text: 'easily embeddable within a web page',
                    ),
                    TextSpan(
                      text:
                          ''' - because I believe the abilities of software engineers (people like me) have been grossly misallocated in our society, that we suffer for it greatly, and that I have a responsibility to correct it. I utilize an intense investigatve approach to my software development, able to expertly hunt down bugs and quirks even in unfamiliar territory due to my curiosity, persistence, and ability to wield ample respect for my peers and the ancestry of the computing industry as a whole. I certainly do not possess all the information I would wish, but I am confident that someone in the world has wisdom they are willing to share and that I can retrieve it when necessary.''',
                      style: theme.textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              'What could it be used for?',
              style: theme.textTheme.headlineLarge,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                '''It could be Congressional Glossary widget that provides contextual information about characters and details from a specific story. Small apps such as this one could be included within a story about any congressional person or event, and since Flutter apps support bi-directional data transfer, the HTML text of the story itself could feed relevant keywords in to the app, which would respond accordingly by filtering the glossary. Conversely, the app itself could direct users to relevant portions of the story by clicking on available keywords from the bank. Got a story about a congressional committee conspiring to harass the family of their political opponents? Readers would likely appreciate the ability to quickly sift through the aforementioned committee members and learn about their allegiances, tenure, etc. without ever having to leave the browser tab. This was made extremely quickly and I had no driving story to tell which would normally provide the necessary constraints for an excellent piece of software.''',
                style: theme.textTheme.bodyLarge,
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Who made it?',
              style: theme.textTheme.headlineLarge,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Me, ',
                      style: theme.textTheme.bodyLarge,
                    ),
                    TextSpan(
                      text: 'Anthony Symkowick',
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          ''' a software engineer with 8 years of experience building web and mobile experiences for people who deserve them. I have a tuned ''',
                      style: theme.textTheme.bodyLarge,
                    ),
                    TextSpan(
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: Colors.lightBlue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => launchUrl(
                              Uri.parse(
                                'https://symkowick.org/posts/open-web-rant/',
                              ),
                            ),
                      text: 'ethical compass',
                    ),
                    TextSpan(
                      text: ', ',
                      style: theme.textTheme.bodyLarge,
                    ),
                    TextSpan(
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: Colors.lightBlue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => launchUrl(
                              Uri.parse(
                                'https://highsobriety.bandcamp.com/album/raw-materials',
                              ),
                            ),
                      text: 'reliable creative outlets',
                    ),
                    TextSpan(
                      text: ', and ',
                      style: theme.textTheme.bodyLarge,
                    ),
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'many thoughts about our current information ',
                          style: theme.textTheme.bodyLarge,
                        ),
                        TextSpan(
                          text: 'hellscape',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        TextSpan(
                          text: ' landscape.',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
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
                    TextSpan(
                      text:
                          ' I currently work as a Software Developer and general technologist at Ecology Action, a wonderful non-profit located in Santa Cruz, California committed to carbon reduction and community outreach. The former is primarly achieved through commerical building energy-efficiency upgrades, and the latter through a team of empathetic, dedicated humans I feel lucky to be a part of. Unfortunately, the reality that they may not need full-fledged software engineering has presented itself, allowing me the privilege of reevaluating my career trajectory.',
                      style: theme.textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Why does _blank_ not work?',
              style: theme.textTheme.headlineLarge,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                r'''I'm so sorry if you encounter a bug - since speed of design, development, and deployment were of vital importance, I intentionally did not spend money on any of the APIs used in the app, and there are significant limitations that I am mostly working around. I was using a much better API for gathering related news, but I discovered a never-before-seen pricing model when I released the first version to production - free API requests from localhost, and a $500 demand the moment you upload your app to the public web. I found a truly free alternative and quickly swapped it in, and regrettably, the "related" story quality is significantly worse. In a real production environment, I love finding the best bang-for-your-buck integration options and advocating for using open source tools first, then adding paid/closed-source offerings as needed. With more time, I would likely bypass using a news search aggregator altogether and pipe queries directly to a search engine, but that's really not the reason I made this. My goal was to show I have the writing skills, engineering skills, and the necessary interest it takes to become a computational journalist. Because I tend to take the engineering part mostly for granted at this point in my career, I felt fine taking a few shortcuts such as not having a backend server, fetching all data on intial page load versus accumulating as necessary, and using a simple GovTrack http search because I could not easily find their API (if they have one). I would be excited to talk about all the things done for brevity that I would never allow in a true production environment - much like a writer may never feel like a piece is done and always wants one final edit, I love the revisionist nature of software development.''',
                style: theme.textTheme.bodyLarge,
              ),
            ),
          ),
          ListTile(
            title: Text(
              '''Can I contact you about hiring, collaboration, or just general inquiries?''',
              style: theme.textTheme.headlineLarge,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '''Yes, absolutely! Please reach out to me via ''',
                      style: theme.textTheme.bodyLarge,
                    ),
                    TextSpan(
                      text: 'email',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.lightBlue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => launchUrl(
                              Uri.parse(
                                'mailto:anthony@symkowick.org',
                              ),
                            ),
                    ),
                    TextSpan(
                      text: ''' or message me on ''',
                      style: theme.textTheme.bodyLarge,
                    ),
                    TextSpan(
                      text: 'mastodon / the fediverse',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.lightBlue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => launchUrl(
                              Uri.parse(
                                'https://social.extremelyoffline.org/@ant',
                              ),
                            ),
                    ),
                    TextSpan(
                      text:
                          ''' with any questions you have about me or my work. Feel free to grab a copy of my current resume below.''',
                      style: theme.textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(64),
            child: ElevatedButton.icon(
              label: const Text('Download My Resume'),
              icon: const Icon(Icons.download),
              onPressed: () async {
                final resumeBytes =
                    (await rootBundle.load('assets/resume_symkowick_2024.pdf'))
                        .buffer
                        .asUint8List();

                var filename = '';
                if (kIsWeb) {
                  filename = 'anthony_symkowick_resume.pdf';
                } else {
                  filename =
                      '${(await getApplicationDocumentsDirectory()).path}/anthony_symkowick_resume.pdf';
                }

                await download(
                  Stream.fromIterable(resumeBytes),
                  filename,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
