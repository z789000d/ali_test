import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aliplayer/flutter_aliplayer.dart';
import 'package:get/get.dart';
import 'package:sdpify/sdpify.dart';
import 'package:untitled2/controller/home_page_controller.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class HomePage extends GetView<HomePageController> {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageController());

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            titleBar(),
            Expanded(
              child: Stack(
                children: [
                  aliPlayerView(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        color: Colors.transparent,
                        height: Get.height * 0.6,
                        child: sheetView()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget titleBar() {
    return GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Text('back'));
  }

  Widget aliPlayerView() {
    return Center(
      child: AliPlayerView(
          onCreated: controller.onViewPlayerCreated,
          x: 0,
          y: 0,
          width: Get.width,
          height: Get.height),
    );
  }

  Widget sheetView() {
    return SheetViewport(
      child: Sheet(
          initialOffset: SheetOffset(0.1),
          snapGrid: const SheetSnapGrid(
            snaps: [SheetOffset(0.1), SheetOffset(1)],
          ),
          decoration: MaterialSheetDecoration(
            size: SheetSize.stretch,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            color: Theme.of(Get.context!).colorScheme.secondaryContainer,
            elevation: 4,
          ),
          scrollConfiguration: const SheetScrollConfiguration(),
          controller: controller.sheetController,
          child: Container(
            child: Obx(
              () => Stack(
                children: [
                  Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(
                            50.sdp,
                          ),
                        ),
                        margin: EdgeInsets.only(top: 10.sdp),
                        width: 30.sdp,
                        height: 10.sdp,
                      )),
                  Container(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Divider(
                          thickness: 1,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            // 輸入框的提示文字，通常會顯示 "輸入訊息..."
                            hintText: '輸入訊息...',
                            // 圓角邊框
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.sdp),
                                  topRight: Radius.circular(10.sdp)),
                              borderSide: BorderSide.none, // 移除邊框線
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                            // 內邊距，讓文字不會緊貼邊框
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.sdp, vertical: 12.sdp),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 30.sdp,
                        left: 20.sdp,
                        right: 20.sdp,
                        bottom: 60.sdp),
                    padding: EdgeInsets.only(bottom: 10.sdp),
                    child: ListView.builder(
                      physics: controller.isListViewScrollable.value
                          ? const ClampingScrollPhysics() // 允許滾動
                          : const NeverScrollableScrollPhysics(),
                      // 禁止滾動
                      controller: controller.scrollController,
                      itemCount: controller.socketText.length,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(controller.socketText[index]),
                        );
                      },
                    ),
                  ),
                  Listener(
                    onPointerMove: (PointerMoveEvent event) {
                      controller.down();
                    },
                    onPointerUp: (PointerUpEvent event) {
                      controller.up();
                    },
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: EdgeInsets.only(top: 10.sdp),
                        width: Get.width,
                        height: 80.sdp,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
