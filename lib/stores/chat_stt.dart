import 'package:flutter_app/stores/chat.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

// 聊天音转文
class ChatStt extends GetxController {
  // 音转文工具
  final speechToText = SpeechToText();

  // 麦克风启动
  var speechEnabled = false.obs;

  // 语音是否在监听
  var isListening = false.obs;

  // 语音监听初始化
  init() async {
    if (speechEnabled.value) return;
    speechEnabled.value = await speechToText.initialize();
  }

  // 开始录音
  start() async {
    await init();
    if (!speechEnabled.value) return;
    await speechToText.listen(onResult: onResult, localeId: 'zh-CN');
    isListening.value = speechToText.isListening;
  }

  // 停止录音
  stop() async {
    await speechToText.stop();
    isListening.value = speechToText.isListening;
  }

  // 当前对话下标
  var lastWordsIndex = 0;

  // 说话中
  var talking = false.obs;

  // 等待指令
  var waitInstructions = false.obs;

  // 录音回调
  onResult(SpeechRecognitionResult result) {
    talking.value = true;
    print(result.recognizedWords);
    String lastWords = result.recognizedWords.substring(lastWordsIndex);

    lastWords = lastWords.replaceAll('小偷', '小特').replaceAll('小兔', '小特');

    debounce(() {
      lastWordsIndex = result.recognizedWords.length;
      talking.value = false;

      final Chat c = Get.find();

      if (waitInstructions.value) {
        c.send(lastWords);

        if (lastWords.contains('打开车门')) {
          c.answer('车门已打开！');
        } else {
          c.answer('请说出正确的操作指令');
        }

        waitInstructions.value = false;
      } else if (lastWords.contains('小特小特')) {
        c.send('小特小特');
        c.answer('请问有什么可以帮助你？');
        waitInstructions.value = true;
      }

      print(lastWords);
    });
  }

  final debounce = Debouncer(delay: Duration(milliseconds: 2000));
}
