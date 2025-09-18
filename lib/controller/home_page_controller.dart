import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_aliplayer/flutter_aliplayer.dart';
import 'package:flutter_aliplayer/flutter_aliplayer_factory.dart';
import 'package:get/get.dart';
import 'package:sdpify/sdpify.dart';
import 'package:smooth_sheets/smooth_sheets.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class HomePageController extends GetxController {
  late var channel;
  var socketText = <String>[].obs;
  var isInitText = false;
  final scrollController = ScrollController();
  var isTouching = false;
  final SheetController sheetController = SheetController();
  final isListViewScrollable = true.obs;
  FlutterAliplayer? fAliplayer;
  Timer? time;

  @override
  void onInit() {
    super.onInit();
    init();
    _setLandscape();
    _startWebSocket();
    _listenSocketTextJumpToBottom();
    _sheetControllerListener();
    // _initPlayer();
    // start();
  }

  void _setLandscape() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void _setAllOrientations() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  void _sheetControllerListener() {
    sheetController.addListener(() {
      final double currentOffset = sheetController.value ?? 0.0;
      // print('bbbbb ${SheetOffset.absolute(currentOffset)}');
    });
  }

  void _listenSocketTextJumpToBottom() {
    ever(socketText, (_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        print(
            'size ${scrollController.offset} ${scrollController.position.minScrollExtent}');

        if (scrollController.offset >
            scrollController.position.minScrollExtent + 200.sdp) {
          return;
        }

        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.minScrollExtent);
        }
      });
    });
  }

  void start() async {
    await fAliplayer?.prepare();
    await fAliplayer?.play();
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
    channel.sink.close(status.normalClosure);
    _setAllOrientations();
    time?.cancel();
  }

  void _startWebSocket() async {
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
      socketText.value = socketText.reversed.toList();
    });

    time = Timer.periodic(const Duration(seconds: 1), (timer) {
      _repeatSet();
    });
  }

  void _repeatSet() {
    DateTime now = DateTime.now();
    channel.sink.add('$now');
  }

  void _initPlayer() {
    fAliplayer = FlutterAliPlayerFactory.createAliPlayer();
  }

  void onViewPlayerCreated(viewId) async {
    ///将 渲染 View 设置给播放器
    fAliplayer?.setPlayerView(viewId);
    //设置播放源
    FlutterAliplayer.createVidPlayerConfigGenerator();
    // 设置预览时间

    String playConfig = await FlutterAliplayer.generatePlayerConfig();

    // fAliplayer?.setUrl(_dataSourceMap[DataSourceRelated.URL_KEY]);
  }

  void init() async {
    // AlivcLiveBase.registerSDK();

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
