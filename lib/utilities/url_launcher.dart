import 'package:url_launcher/url_launcher.dart';

void urllauncher(String contact, String type) {
  final channel = contact;
  if (type == "phone") {
    final Uri phoneUri = Uri.parse("tel:$channel");
    launchUrl(phoneUri);
  } else {
    final Uri emailUri = Uri.parse("mailto:$channel");
    launchUrl(emailUri);
  }
}
