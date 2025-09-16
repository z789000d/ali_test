import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_aliplayer/flutter_aliplayer.dart';
import 'package:flutter_aliplayer/flutter_aliplayer_factory.dart';
import 'package:flutter_livepush_plugin/base/live_base.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late var channel;

  @override
  void initState() {
    super.initState();
    init();
    test3();
  }

  test3() async {
    final wsUrl = Uri.parse('wss://echo.websocket.org');
    channel = WebSocketChannel.connect(wsUrl);
    await channel.ready;
    print('44444444');
    channel.stream.listen((message) {
      print('received $message');
      // channel.sink.add('received!');
      // channel.sink.close(status.goingAway);
    });

    Timer.periodic(const Duration(seconds: 1), (timer) {
      repeatSet();
    });
  }

  void repeatSet() {
    print('333333');
    channel.sink.add('received!');
  }

  void init() async {
    // AlivcLiveBase.registerSDK();

    // FlutterAliplayer fAliplayer = FlutterAliPlayerFactory.createAliPlayer();
    // fAliplayer.setOnPrepared((playerId) {});

    // /// 2.设置监听回调接口
    // AlivcLiveBase.setListener(AlivcLiveBaseListener(
    //   onLicenceCheck: (AlivcLiveLicenseCheckResultCode result, String reason) {
    //     if (result == AlivcLiveLicenseCheckResultCode.success) {
    //       /// 注册SDK成功
    //     }
    //   },
    // ));
    //
    // String sdkVersion = await AlivcLiveBase.getSdkVersion();
    // print('aaaaaa $sdkVersion');
    //
    // /// 启用控制台日志打印
    // AlivcLiveBase.setConsoleEnable(true);
    //
    // /// 设置log级别为Debug调试级别
    // AlivcLiveBase.setLogLevel(AlivcLivePushLogLevel.debug);
    //
    // /// 每个分片最大大小，最终日志总体积是最大分片大小的5倍
    // const int saveLogMaxPartFileSizeInKB = 100 * 1024 * 1024;
    //
    // /// 日志路径
    // String saveLogDir = "TODO";
    //
    // /// 设置日志路径及日志分片大小
    // AlivcLiveBase.setLogPath(saveLogDir, saveLogMaxPartFileSizeInKB);

    // print('7777777');
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
