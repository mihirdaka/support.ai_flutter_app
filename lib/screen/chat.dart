import 'dart:math';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:supportu_flutter_app/data/chat.dart';
import 'package:supportu_flutter_app/provider/chat_provider.dart';
// import 'package:flutter_sound/flutter_sound.dart';
import 'dart:io';

import 'package:voice_message_package/voice_message_package.dart';

class ChatScreen extends StatefulWidget {
  final int? sessionId;

  const ChatScreen({super.key, this.sessionId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _textController = TextEditingController();
  final player = AudioPlayer();

  ValueNotifier<bool> isRecording = ValueNotifier<bool>(false);
  File audioFile = File('');
  Future<void> startRecording() async {
    audioFile = File(
        '${(await getTemporaryDirectory()).path}/${Random().nextInt(10000)}.mp3');
    print('start recording');
    try {
      RecordMp3.instance.start(audioFile.path, (type) {
        // record fail callback
        print('fail');
        isRecording.value = false;
      });

      isRecording.value = true;
    } catch (e) {
      isRecording.value = false;
      // TODO
      // print(e as CodeNor);
    }
  }

  Future<File> stopRecording() async {
    print('stop recording');
    RecordMp3.instance.stop();

    isRecording.value = false;
    return File(audioFile.path);
  }

  getAudioChat() async {
    File audioFile = await stopRecording();

    await Provider.of<ChatProvider>(context, listen: false)
        .talkWithAssistant(audioFile);
  }

  @override
  void initState() {
    super.initState();
    initNewSession();
  }

  initNewSession() {
    if (widget.sessionId == 0) {
      Provider.of<ChatProvider>(context, listen: false).sessionId = 0;
      Provider.of<ChatProvider>(context, listen: false).clearMessages();
    } else {
      Provider.of<ChatProvider>(context, listen: false).sessionId =
          widget.sessionId ?? 0;
      Provider.of<ChatProvider>(context, listen: false).loadSession();
    }
  }

  final List<String> suggestions = [
    'Recipe for cupcakes',
    'Plan an itinerary',
    'How to change email?',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        title: const Text('Support.ai Assistant'),
      ),
      bottomNavigationBar: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 8,
                sigmaY: 8,
              ),
              child: BottomAppBar(
                // elevation: 0,
                clipBehavior: Clip.antiAlias,
                color: Color.fromARGB(255, 9, 9, 9).withOpacity(0.9),
                // .withAlpha(255),
                // color: Colors.black.withOpacity(0.1),
                child: Row(
                  children: [
                    // text field
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: TextField(
                          controller: _textController,
                          autofocus: widget.sessionId == null ? true : false,
                          decoration: InputDecoration(
                            filled: true,
                            labelText: 'Type a message...',
                            labelStyle: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.grey),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),

                    // send button
                    Builder(builder: (context) {
                      // bool isRecording = recorder?.isRecording ?? false;
                      return ValueListenableBuilder<bool>(
                          valueListenable: isRecording,
                          builder: (context, isRecording, child) {
                            return InkWell(
                              onTapDown: (details) => startRecording(),
                              onTapCancel: () => getAudioChat(),
                              child: IconButton(
                                // color: Colors.white,
                                icon: isRecording
                                    ? Icon(Icons.stop)
                                    : Icon(CupertinoIcons.mic_fill),
                                onPressed: () {},
                              ),
                            );
                          });
                    }),
                    IconButton(
                      // color: Colors.white,
                      icon: const Icon(CupertinoIcons.paperplane_fill),
                      onPressed: () {
                        // send message
                        if (_textController.text.isNotEmpty) {
                          Provider.of<ChatProvider>(context, listen: false)
                              .chatWithAssistant(_textController.text);
                          _textController.clear();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          )),
      body: Consumer<ChatProvider>(
        builder: (context, provider, _) {
          bool isListEmpty = provider.messages.isEmpty;

          if (!isListEmpty) {
            final chats = provider.messages.reversed.toList();

            // make this list reverse in order to show the latest message at the bottom
            return ListView.builder(
              reverse: true,
              itemCount: chats.length,
              itemBuilder: (
                context,
                index,
              ) {
                // is role is user then align to right
                // else align to left
                ChatMessage message = chats[index];
                final Color messageBackgroundColor = message.role == Role.user
                    ? Colors.white
                    : const Color(0xff212121);

                final Color messageTextColor =
                    message.role == Role.user ? Colors.black : Colors.white;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: message.role == Role.user
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: messageBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: message.role == Role.user
                              ? const Radius.circular(16)
                              : const Radius.circular(0),
                          bottomRight: message.role == Role.user
                              ? const Radius.circular(0)
                              : const Radius.circular(16),
                          topRight: const Radius.circular(16),
                          bottomLeft: const Radius.circular(16),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AudioMessageWidget(
                            message: message,
                            messageBackgroundColor: messageBackgroundColor,
                            messageTextColor: messageTextColor,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '${message.timeStamp?.hour}:${message.timeStamp?.minute}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: messageTextColor.withOpacity(0.5),
                                    ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Text(
                    'Hello, How can I help you?',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // prompt message suggestion

                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 20,
                      children: suggestions
                          .map(
                            (i) => InkWell(
                              onTap: () {
                                Provider.of<ChatProvider>(context,
                                        listen: false)
                                    .chatWithAssistant(i);
                              },
                              child: Chip(
                                label: Text(i),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(child: Text('Hold the mic icon to send voice message'))
              ],
            ),
          );
        },
      ),
    );
  }
}

class AudioMessageWidget extends StatefulWidget {
  const AudioMessageWidget({
    super.key,
    required this.message,
    required this.messageBackgroundColor,
    required this.messageTextColor,
  });

  final ChatMessage message;
  final Color messageBackgroundColor;
  final Color messageTextColor;

  @override
  State<AudioMessageWidget> createState() => _AudioMessageWidgetState();
}

class _AudioMessageWidgetState extends State<AudioMessageWidget> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (widget.message.isAudio ?? false) {
        // var duration = player.setUrl('file.mp3');

        return VoiceMessageView(
          innerPadding: 12,
          circlesColor: Colors.grey.shade800,
          backgroundColor: widget.messageBackgroundColor,
          controller: VoiceController(
            audioSrc: widget.message.audioFile?.path ?? '',
            isFile: true,
            onComplete: () {},
            onPause: () {},
            onPlaying: () {},
            onError: (err) {},
            maxDuration: const Duration(seconds: 15),
          ),
          counterTextStyle: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: widget.messageTextColor),
          cornerRadius: 20,
        );
      } else {
        return Text(
          widget.message.message ?? '',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: widget.messageTextColor,
              ),
        );
      }
    });
  }
}
