import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled2/controller/home_page_controller.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class HomePage extends GetView<HomePageController> {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageController());
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // 背景內容（例如：主頁面）
            const Center(
              child: Text('主頁面內容'),
            ),
            SheetViewport(
              child: Sheet(
                initialOffset: SheetOffset(0.1),
                decoration: MaterialSheetDecoration(
                  size: SheetSize.stretch,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  elevation: 4,
                ),
                snapGrid: const SheetSnapGrid(
                  snaps: [SheetOffset(0.1), SheetOffset(0.8)],
                ),
                scrollConfiguration: const SheetScrollConfiguration(),
                controller: controller.sheetController,
                child: Obx(
                  () => Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 25, left: 20, right: 20),
                        child: ListView.builder(
                          physics: controller.isListViewScrollable.value
                              ? const ClampingScrollPhysics() // 允許滾動
                              : const NeverScrollableScrollPhysics(),
                          // 禁止滾動
                          controller: controller.scrollController,
                          itemCount: controller.socketText.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(controller.socketText[index]),
                            );
                          },
                        ),
                      ),
                      Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(
                                50,
                              ),
                            ),
                            margin: EdgeInsets.only(top: 10),
                            width: 30,
                            height: 10,
                          )),
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
                            padding: EdgeInsets.only(top: 10),
                            width: Get.width,
                            height: 80,
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
