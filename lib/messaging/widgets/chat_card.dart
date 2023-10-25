import 'package:carena/globals/colors.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  final dynamic chat;
  const ChatWidget({
    Key? key,
    this.chat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        tileColor: chat['new'] != null ? Colors.white10 : darkmodecolor,
        leading: CircleAvatar(
          radius: 30.0,
          backgroundImage: AssetImage(chat['url']),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              chat['username'],
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            if (chat['new'] != null)
              Text(
                "${chat?['new']} unread",
                style: const TextStyle(color: brandcolor),
              ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 25.0),
          child: Text(
            chat['comment'],
            overflow: TextOverflow.ellipsis,
            textScaleFactor: 1.15,
          ),
        ),
      ),
    );
  }
}
