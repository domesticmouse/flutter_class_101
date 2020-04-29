// Copyright 2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chatlog with ChangeNotifier {
  final _chats = <String>['Some random content', 'goes here'];
  List<String> get chats => <String>[..._chats];

  void addChat(String chat) {
    _chats.add(chat);
    notifyListeners();
  }
}

void main() {
  runApp(
    MultiProvider(
      child: MyApp(),
      providers: [ChangeNotifierProvider(create: (_) => Chatlog())],
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chattr (Alpha!)',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key key,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final chatlog = Provider.of<Chatlog>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatterng away...'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                padding: EdgeInsets.all(8),
                itemBuilder: (context, index) =>
                    ChatMessage(chatlog.chats[index]),
                itemCount: chatlog.chats.length,
              ),
            ),
            Divider(height: 1),
            _buildTextComposer(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(
        color: Theme.of(context).accentColor,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: (content) => _handleSubmitted(context, content),
                decoration: InputDecoration.collapsed(hintText: 'Say hello!'),
                focusNode: _focusNode,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () =>
                    _handleSubmitted(context, _textController.text),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(BuildContext context, String content) {
    _textController.clear();
    _focusNode.requestFocus();
    if (content.length > 0) {
      Provider.of<Chatlog>(context, listen: false).addChat(content);
    }
  }
}

const String _name = 'Bob';

class ChatMessage extends StatelessWidget {
  const ChatMessage(this._text);
  final String _text;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(child: Text(_name[0])),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_name, style: Theme.of(context).textTheme.headline4),
              Container(
                margin: EdgeInsets.only(top: 5.0),
                child: Text(_text),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
