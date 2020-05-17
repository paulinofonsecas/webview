import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {

  Completer<WebViewController> _controller = Completer<WebViewController>();
  TextEditingController _c;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _c = TextEditingController();
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _c,
                    decoration: InputDecoration(
                      hintText: "url",
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(90),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(90),
                    ),
                    child: RaisedButton(
                      onPressed: () async {
                        _controller.future.then((value) async {
                          await value.loadUrl('http://${_c.text}');
                        });
                      },
                      child: Icon(Icons.search),
                    ),
                  ),
                )
              ],
            ),
          ),
          body: WebView(
            initialUrl: "http://www.google.com",
            onWebViewCreated: (controller) {
              _controller.complete(controller);
              //a
            },
            onPageStarted: (s){
              print('msg->$s');
            },
          ),
        ),
      );
  }
}