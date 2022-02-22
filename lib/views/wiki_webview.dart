import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Wiki extends StatefulWidget {
  const Wiki({Key? key, required this.wikiUrl}) : super(key: key);
  final String wikiUrl;

  @override
  State<Wiki> createState() => _WikiState();
}

class _WikiState extends State<Wiki> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: widget.wikiUrl,
          zoomEnabled: false,
        ),
      ),
    );
  }
}
