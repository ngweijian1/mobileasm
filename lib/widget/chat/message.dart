

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/widget/chat/message_bubble.dart';
import 'package:flutter/material.dart';


class Messages extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: FirebaseFirestore.instance.collection('chat').orderBy('times', descending: true,).snapshots(),
    builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot){
       if (chatSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final chatdocuments = chatSnapshot.data!.docs;
                  return ListView.builder(
                    reverse: true,
                    itemCount: chatdocuments.length,
                    itemBuilder: (ctx, index) => MessageBubble(chatdocuments[index]['text']),
                  );
    },);
  }
}