import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'My App',
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return _scaffoldWidget();
  }

  Widget _scaffoldWidget() {
    return Scaffold(
      appBar: AppBar(
        title: Text('InApp'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.info_outline), onPressed: null),
        ],
      ),
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    return Column(
      children: [
        SizedBox(height: 16.0),
        ElevatedButton(
          child: Text('Browser'),
          onPressed: () {
            _launchInBrowser('https://google.com');
          },
        ),
        SizedBox(height: 16.0),
        Expanded(
          child: WebView(
            initialUrl: 'https://flutter.dev',
          ),
        ),
      ],
    );
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      // Map<String, String> _headers = {};
      // if (MemoryRepository.instance.token != null)
      //   _headers['Authorization'] =
      //       'Bearer ' + MemoryRepository.instance.token!;
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: true,
        // headers: _headers,
      );
    } else {
      // throw 'Could not launch $url';
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Не удалось открыть личный кабинет'),
        ),
      );
    }
  }
}
