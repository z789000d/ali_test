import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_aliplayer/flutter_aliplayer.dart';
import 'package:flutter_aliplayer/flutter_aliplayer_factory.dart';
import 'package:flutter_livepush_plugin/base/live_base.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:untitled2/page/first_page.dart';
import 'package:untitled2/page/home_page.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 點擊空白處時，關閉鍵盤
        FocusManager.instance.primaryFocus?.unfocus();
      },
      // 這確保即使點擊透明區域，也能觸發事件
      behavior: HitTestBehavior.translucent,
      child: GetMaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          getPages: [
            GetPage(
              name: '/',
              page: () => FirstPage(),
            ),
            GetPage(
              name: '/HomePage',
              page: () => HomePage(),
            ),
          ]),
    );
  }
}
