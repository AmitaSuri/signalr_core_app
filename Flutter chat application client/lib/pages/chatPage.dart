import 'dart:convert';
import 'dart:math';

import 'package:chat_app/models/messageModel.dart';
import 'package:chat_app/utils/removeMessageExtraChar.dart';
import 'package:chat_app/widgets/chatAppbarWidget.dart';
import 'package:chat_app/widgets/chatMessageListWidget.dart';
import 'package:chat_app/widgets/chatTypeMessageWidget.dart';
import 'package:flutter/material.dart';
import 'package:signalr_core/signalr_core.dart';

class ChatPage extends StatefulWidget {
  final String userName;
  ChatPage(this.userName, {Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // //set url and configs
  HubConnection connection = new HubConnectionBuilder()
      .withUrl(
          //'http://0.0.0.0:5000/chatHub',
          'http://10.0.0.102/chatHub',
          // 'https://teamtracker-signalr-dev.service.signalr.net',
          HttpConnectionOptions(
            logging: (level, message) => print(message),
            // skipNegotiation: true,
            // transport: HttpTransportType.webSockets
          ))
      .build();

  @override
  void initState() {
    super.initState();
    openSignalRConnection();
    createRandomId();
    Future.delayed(const Duration(milliseconds: 500), () {});
  }

  int currentUserId = 0;
  //generate random user id
  createRandomId() {
    Random random = Random();
    currentUserId = random.nextInt(999999);
  }

  Future<void> start() async {
    await connection.start();
  }

  ScrollController chatListScrollController = new ScrollController();
  TextEditingController messageTextController = TextEditingController();
  submitMessageFunction() async {
    var messageText = removeMessageExtraChar(messageTextController.text);
    if (connection != null && connection.state == 'Disconnected') {
      await connection.start();
      await connection.invoke('SendMessage',
          args: [widget.userName, currentUserId, messageText]);
      messageTextController.text = "";
      Future.delayed(const Duration(milliseconds: 500), () {
        chatListScrollController.animateTo(
            chatListScrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 500),
            curve: Curves.ease);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            chatAppbarWidget(size, context),
            chatMessageWidget(
                chatListScrollController, messageModel, currentUserId),
            // FutureBuilder<void>(
            //     future: start(),
            //     builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            //       if (snapshot.connectionState == 'done') {
            //         return chatTypeMessageWidget(
            //             messageTextController, submitMessageFunction);
            //       } else if (snapshot.hasError) {
            //         return Text('Error', style: TextStyle(color: Colors.red));
            //       }
            //       return CircularProgressIndicator();
            //     })
            chatTypeMessageWidget(messageTextController, submitMessageFunction)
          ],
        ),
      ),
    );
  }

  //connect to signalR
  Future<void> openSignalRConnection() async {
    try {
      await connection.start();
      connection.on('ReceiveMessage', (message) {
        _handleIncommingDriverLocation(message);
      });
      await connection
          .invoke('JoinUSer', args: [widget.userName, currentUserId]);
    } catch (e) {
      print('Error starting SignalR connection: $e');
    }
  }

  //get messages
  List<MessageModel> messageModel = [];
  Future<void> _handleIncommingDriverLocation(List<dynamic>? args) async {
    if (args != null) {
      var jsonResponse = json.decode(json.encode(args[0]));
      MessageModel data = MessageModel.fromJson(jsonResponse);
      setState(() {
        messageModel.add(data);
      });
    }
  }
}
