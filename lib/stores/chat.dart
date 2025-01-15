import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

// 聊天数据管理
class Chat extends GetxController {
  final flutterTts = FlutterTts();

  // 聊天记录
  final list = <Map<String, String>>[].obs;

  // 发送问题
  send(String text) {
    list.insert(0, {"type": 'user', "text": text});
  }

  // 回答问题
  answer(String text) async {
    list.insert(0, {"type": 'ai', "text": text});

    await flutterTts.setLanguage('zh-CN');

    await flutterTts.setVolume(0.8);

    await flutterTts.setSpeechRate(0.5);

    await flutterTts.setPitch(1.0);

    await flutterTts.speak(text);
  }
}
