import 'package:get/get.dart';

// 聊天数据管理
class Chat extends GetxController {
  // 聊天记录
  final list = <Map<String, String>>[].obs;

  // 发送问题
  send(String text) {
    list.insert(0, {"type": 'user', "text": text});
  }

  // 回答问题
  answer(String text) {
    list.insert(0, {"type": 'ai', "text": text});
  }
}
