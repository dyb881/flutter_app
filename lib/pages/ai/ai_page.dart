import 'package:flutter/material.dart';
import 'package:flutter_app/stores/chat.dart';
import 'package:flutter_app/stores/chat_stt.dart';
import 'package:get/get.dart';

class AiPage extends StatefulWidget {
  const AiPage({super.key});

  @override
  State<AiPage> createState() => _AiPageState();
}

class _AiPageState extends State<AiPage> {
  @override
  Widget build(BuildContext context) {
    final Chat c = Get.find();
    final ChatStt cs = Get.find();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('小特语音助手'),
        ),
        body: ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Obx(() => ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 180.0),
                      itemCount: c.list.length,
                      itemBuilder: (BuildContext content, int index) {
                        var item = c.list[index];
                        return Container(
                            margin: EdgeInsets.only(bottom: 15.0),
                            alignment: item['type'] == 'user'
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(8.0),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26,
                                          offset: Offset(0, 2.0),
                                          blurRadius: 4.0)
                                    ]),
                                padding: EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 10.0),
                                child: Text(
                                  item["text"]!,
                                  style: TextStyle(fontSize: 16),
                                )));
                      },
                    )),
                Obx(() => AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    bottom: c.list.isEmpty ? Get.height * 0.5 : 130,
                    child: Text(
                      cs.isListening.value
                          ? cs.talking.value
                              ? cs.waitInstructions.value
                                  ? '请说出操作指令，如“打开车门”'
                                  : '正在识别语音'
                              : '请说出“小特小特”，激活语音助手'
                          : '轻触麦克风开始监听',
                      style: TextStyle(fontSize: 18),
                    )))
              ],
            )),
        floatingActionButton: Obx(() => FloatingActionButton(
              onPressed: cs.isListening.value ? cs.stop : cs.start,
              tooltip: 'Listen',
              shape: CircleBorder(),
              child: Icon(cs.isListening.value ? Icons.mic : Icons.mic_off),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
