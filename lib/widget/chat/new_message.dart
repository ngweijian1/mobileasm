import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {

  final _controller = new TextEditingController(); 

var _enteredMessage = ' ';

void _sendMessage() async {

  final user = await FirebaseAuth.instance.currentUser!;
  FocusScope.of(context).unfocus();
  FirebaseFirestore.instance.collection('chat').add({
    'text': _enteredMessage,
    'times': Timestamp.now(),
    'userid': user.uid,
  });
  _controller.clear();
}


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Send message...'),
            onChanged: (value){
              setState(() {
                _enteredMessage = value;
              });
            },
            ),
          ),
          IconButton(color: Theme.of(context).primaryColor, 
          icon: Icon(
            Icons.send
            ), 
          onPressed: _enteredMessage.trim().isEmpty ? null : 
                _sendMessage,
          )
        ],
      ),
    );
  }
}