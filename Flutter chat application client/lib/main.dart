import 'package:chat_app/pages/loginPage.dart';
import 'package:chat_app/utils/appTheme.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:signalr_core/signalr_core.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat application',
      theme: ThemeData(
        fontFamily: AppTheme.firstFontName,
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

//
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:signalr_flutter/signalr_api.dart';
// import 'package:signalr_flutter/signalr_flutter.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   String signalRStatus = "disconnected";
//   late SignalR signalR;
//
//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//   }
//
//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initPlatformState() async {
//     // final String negotiateUrl =
//     //     "https://teamtracker-signalr-dev.service.signalr.net";
//     // final hubUrl =
//     //     'https://teamtracker-signalr-dev.service.signalr.net/client/?hub=chat';
//     // HubConnection? _connection;
//     //
//     // final response = await http.post(Uri.parse(negotiateUrl));
//     // print("Hello   ${response.body.toString()}");
//     // if (response.statusCode == 200) {
//     //   final data = jsonDecode(response.body);
//     //   final accessToken = data['accessToken'];
//     //   _connection = HubConnectionBuilder()
//     //       .withUrl(hubUrl, HttpConnectionOptions(
//     //     accessTokenFactory: () async => accessToken,
//     //   ))
//     //       .build();
//
//     //  _connection?.on('newMessage', _handleNewMessage);
//
//     //  await _connection?.start();
//     // } else {
//     //   throw Exception('Failed to negotiate connection');
//     // }
//     // }
//     signalR = SignalR(
//       "https://teamtracker-signalr-dev.service.signalr.net",
//       "chat",
//       queryString: "hub=chat",
//       headers: {
//         "AccessKey": "60aYyiGYGxqIeSzCI4O3+wh86lptVyBuOUcoMF9axHo=",
//       },
//       // hubMethods: ["SendMessage"],
//       // statusChangeCallback: _onStatusChange,
//       // hubCallback: _onNewMessage,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text("SignalR Plugin Example App"),
//         ),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               "Connection Status: $signalRStatus\n",
//               style: Theme.of(context).textTheme.titleLarge,
//               textAlign: TextAlign.center,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 20.0),
//               child: ElevatedButton(
//                 onPressed: _buttonTapped,
//                 child: const Text("Invoke Method"),
//               ),
//             )
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           child: const Icon(Icons.cast_connected),
//           onPressed: () async {
//             final isConnected = await signalR.isConnected();
//             if (!isConnected) {
//               final connId = await signalR.connect();
//               print("Connection ID: $connId");
//             } else {
//               signalR.stop();
//             }
//           },
//         ),
//       ),
//     );
//   }
//
//   void _onStatusChange(ConnectionStatus? status) {
//     if (mounted) {
//       setState(() {
//         signalRStatus = status?.name ?? ConnectionStatus.disconnected.name;
//       });
//     }
//   }
//
//   void _onNewMessage(String methodName, String message) {
//     print("MethodName = $methodName, Message = $message");
//   }
//
//   void _buttonTapped() async {
//     try {
//       final result = await signalR.invokeMethod(
//         "SendMessage",
//         arguments: ["Test", "Chat APP"],
//       );
//       print(result);
//     } catch (e) {
//       print(e);
//     }
//   }
// }
