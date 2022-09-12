import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MaterialApp(
    home: MainPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ConnectivityResult? _connectivityResult;
  bool _connected = false;

  Future<void> _checkConnectivityState() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();

    setState(() {
      _connectivityResult = result;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkConnectivityState();
  }

  @override
  Widget build(BuildContext context) {
    _checkConnectivityState();
    if (_connectivityResult == ConnectivityResult.wifi ||
        _connectivityResult == ConnectivityResult.mobile) {
      return Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: const WebView(
            initialUrl: 'https://kvork.org/',
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
      );
    }
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Text(
            "Нет интернет соединения!",
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
