import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:untitled2/page/home_page.dart';

import '../controller/first_page_controller.dart';

class FirstPage extends GetView<FirstPageController> {
  FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(FirstPageController());
    return Scaffold(
        body: SafeArea(
            child: Container(
      child: GestureDetector(
          onTap: () {
            Get.to(() => HomePage());
          },
          child: Text('點擊切換')),
    )));
  }
}
