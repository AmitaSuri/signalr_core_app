import 'package:chat_app/pages/loginPage.dart';
import 'package:chat_app/utils/appTheme.dart';
import 'package:flutter/material.dart';

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

// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:signalr_flutter/signalr_api.dart';
// import 'package:signalr_flutter/signalr_flutter.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   String signalRStatus = "disconnected";
//   late SignalR signalR;

//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//   }

//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initPlatformState() async {
//     signalR = SignalR(
//       "https://teamtracker-signalr-dev.service.signalr.net",
//       // "http://10.0.0.103:5000",
//       // "http://0.0.0.0:5000",
//       "60aYyiGYGxqIeSzCI4O3+wh86lptVyBuOUcoMF9axHo",
//       //hubMethods: ["SendMessage"],
//       // statusChangeCallback: _onStatusChange,
//       // hubCallback: _onNewMessage,
//     );
//   }

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

//   void _onStatusChange(ConnectionStatus? status) {
//     if (mounted) {
//       setState(() {
//         signalRStatus = status?.name ?? ConnectionStatus.disconnected.name;
//       });
//     }
//   }

//   void _onNewMessage(String methodName, String message) {
//     print("MethodName = $methodName, Message = $message");
//   }

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
