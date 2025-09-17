import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smooth_sheets/smooth_sheets.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class HomePageController extends GetxController {
  late var channel;
  var socketText = <String>[
  ].obs;
  var isInitText = false;
  final scrollController = ScrollController();
  var isTouching = false;
  final SheetController sheetController = SheetController();
  final isListViewScrollable = false.obs;

  @override
  void onInit() {
    super.onInit();
    init();
    startWebSocket();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
    ever(socketText, (_) {
      // 確保滾動在 UI 渲染完成後執行
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // 使用 jumpTo() 方法，滾動到最大可滾動範圍
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
      });
    });

    sheetController.addListener(() {
      final double currentOffset = sheetController.value ?? 0.0;
      // print('bbbbb ${SheetOffset.absolute(currentOffset)}');
    });
  }

  void down() {
    isListViewScrollable.value = false;
    print('down');
  }

  void up() {
    isListViewScrollable.value = true;
    print('up');
  }

  @override
  void onClose() {
    super.onClose();
    channel.sink.close(status.goingAway);
  }

  void startWebSocket() async {
    final wsUrl = Uri.parse('wss://echo.websocket.org');
    channel = WebSocketChannel.connect(wsUrl);
    await channel.ready;

    channel.stream.listen((message) {
      // print('now $message');

      if (!isInitText) {
        isInitText = true;
        return;
      }
      socketText.add(message);
    });

    Timer.periodic(const Duration(seconds: 1), (timer) {
      repeatSet();
    });
  }

  void repeatSet() {
    DateTime now = DateTime.now();
    channel.sink.add('$now');
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
}
