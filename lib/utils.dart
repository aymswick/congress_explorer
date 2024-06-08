import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart';
import 'package:url_launcher/url_launcher.dart';

extension FriendlyTime on DateTime {
  String get timeAgo => format(this);

  String get localDate => DateFormat.yMMMd().format(this);
}

Future<void> openUrl(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
