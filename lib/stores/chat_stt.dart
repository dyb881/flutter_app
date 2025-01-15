import 'package:get/get.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

// 聊天音转文
class ChatStt extends GetxController {
  // 音转文工具
  final speechToText = SpeechToText();

  // 麦克风启动
  var speechEnabled = true.obs;

  // 语音是否在监听
  var isListening = false.obs;

  // 语音监听初始化
  init() async {
    if (speechEnabled.value) return;
    speechEnabled.value = await speechToText.initialize();
  }

  // 开始录音
  start() async {
    await init(); // 自动初始化

    if (!speechEnabled.value) return; // 初始化失败

    await speechToText.listen(
        onResult: onResult,
        localeId: 'zh-CN',
        listenOptions: SpeechListenOptions(partialResults: true));
    isListening.value = speechToText.isListening;
  }

  // 停止录音
  stop() async {
    await speechToText.stop();
    isListening.value = speechToText.isListening;
  }

  // 录音回调
  onResult(SpeechRecognitionResult result) {
    print(result.recognizedWords);
    // setState(() {
    //   String lastWords = result.recognizedWords.substring(_lastWordsIndex);

    //   debounce(() {
    //     print(lastWords);
    //     _lastWordsIndex = result.recognizedWords.length;
    //   });
    // });
  }

  // final debounce = Debouncer(delay: Duration(milliseconds: 2000));
}
