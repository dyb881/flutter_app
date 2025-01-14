import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class AiPage extends StatefulWidget {
  const AiPage({super.key});

  @override
  State<AiPage> createState() => _AiPageState();
}

class _AiPageState extends State<AiPage> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  int _lastWordsIndex = 0;
  String _showWords = '请说“小特小特”，唤醒语音助手';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      localeId: 'zh-CN',
    );
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    print(result.recognizedWords);
    setState(() {
      String lastWords = result.recognizedWords.substring(_lastWordsIndex);

      // 读取文本
      int index = lastWords.indexOf('小特小特');
      if (index > -1) {
        _lastWordsIndex += index + 4; // 下标后移
        _showWords = '请问有什么可以帮助你';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('小特语音唤醒'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _speechToText.isListening
                  ? Text(
                      _showWords,
                      style: TextStyle(fontSize: 18),
                    )
                  : Text(
                      _speechEnabled ? '轻触麦克风开始监听...' : '语音不可用',
                      style: TextStyle(fontSize: 18),
                    ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed:
              _speechToText.isNotListening ? _startListening : _stopListening,
          tooltip: 'Listen',
          shape: CircleBorder(),
          child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
          // mini: true
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
