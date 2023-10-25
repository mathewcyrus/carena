import 'package:carena/globals/colors.dart';
import 'package:carena/globals/data.dart';
import 'package:carena/messaging/widgets/chat_card.dart';
import 'package:carena/routes/routes.dart';
import 'package:flutter/material.dart';

class ChatHomePage extends StatelessWidget {
  const ChatHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkmodecolor,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 0.2, color: bordercolor),
            ),
          ),
        ),
        leading: IconButton(
          iconSize: 35.0,
          onPressed: () => Navigator.of(context).pushNamed(
            RouteManager.mainPage,
          ),
          icon: const Icon(Icons.home),
        ),
        title: const Text('Messages'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView.builder(
            reverse: true,
            itemCount: comments.length,
            itemBuilder: (context, index) {
              final comment = comments[index];

              return ChatWidget(
                chat: comment,
              );
            },
          ),
          const Positioned(
            bottom: 20.0,
            right: 10.0,
            child: CircleAvatar(
              radius: 45.0,
              backgroundColor: brandcolor,
              child: Stack(
                children: [
                  Icon(
                    Icons.chat,
                    size: 50.0,
                    color: Colors.white,
                  ),
                  Positioned(
                    right: 0.0,
                    top: 0.0,
                    child: CircleAvatar(
                      radius: 16.0,
                      backgroundColor: brandcolor,
                      child: Center(
                        child: Icon(
                          Icons.add,
                          size: 24.0,
                          color: complemtarybrandcolor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
