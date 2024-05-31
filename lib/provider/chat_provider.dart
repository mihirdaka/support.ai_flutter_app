import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:supportu_flutter_app/data/chat.dart';
// import 'package:supportu_flutter_app/data/user.dart';
import 'package:supportu_flutter_app/service/auth.dart';

class ChatProvider extends ChangeNotifier {
  List<ChatMessage> _messages = [];
  AuthClient authApiClient = AuthClient();
  LazyBox<Sessions?>? sessionBox;
  int? sessionId;
  List<ChatMessage> get messages => _messages;

  bool isChatBotThinking = false;

  ChatProvider() {
    //initialise object
    // sessionId = 0;
  }

  setAiThinking(bool value) {
    isChatBotThinking = value;
    // if thinking add a message to the chat
    if (value) {
      final newMessage = ChatMessage(
        message: 'Thinking...',
        role: Role.assistant,
        timeStamp: DateTime.now(),
      );

      _messages.add(newMessage);
    } else {
      _messages.removeWhere((element) => element.message == 'Thinking...');
    }
    notifyListeners();
  }

  void addMessage(
    String message,
  ) async {
    final ChatMessage newMessage = ChatMessage(
      message: message,
      role: Role.user,
      timeStamp: DateTime.now(),
    );

    _messages.add(newMessage);
    if (sessionId == null) {
      await initNewSession(newMessage);
      await addMessageToSession(newMessage);
    } else {
      await addMessageToSession(newMessage);
    }

    notifyListeners();
  }

  void clearMessages() {
    _messages.clear();
    //print('messages cleared');
    sessionId = null;
  }

  //only initialise the session box if the assistant replied to the user

  initNewSession(message) async {
    sessionId = (sessionBox?.length ?? 0);
    // //print('session id : $sessionId');
    await sessionBox?.add(Sessions(sessionId: sessionId, messages: []));
  }

  void clearSessions() async {
    // final box = await Hive.openBox<Sessions>('session');
    sessionBox?.clear();
    notifyListeners();
  }

  addMessageToSession(ChatMessage message) async {
    final session = await sessionBox?.get(sessionId);
    if (sessionBox?.containsKey(sessionId) ?? false) {
      session?.messages?.add(message);
      await sessionBox?.put(sessionId, session);
      if (kDebugMode) {
        //print('message added to session');
      }
    } else {
      if (kDebugMode) {
        //print('session does not exist for $sessionId');
      }
      // addMessageToSession(message);
    }
  }

  loadSession() async {
    if (sessionId == null) {
      //print('cannot load');
      return;
    }
    final session = await sessionBox?.get(sessionId);
    //print('message length : ${session?.messages?.length}');
    _messages = session?.messages ?? [];
    notifyListeners();
  }

  Future<ChatResponse?> chatWithAssistant(String message) async {
    try {
      addMessage(message);
      setAiThinking(true);
      final context = _messages.length > 5
          ? _messages.sublist(_messages.length - 5)
          : _messages;

      final mapcontext = context.map((e) {
        return {
          "content": e.message,
          "role": (e.role == Role.user ? 'user' : 'assistant'),
        };
      }).toList();
      final data = {"messageContent": message, "context": mapcontext};

      final ChatResponse? response = await authApiClient.chatWithAi(data);
      if (response?.status ?? false) {
        // return response;
        final newMessage = ChatMessage(
          message: response?.messages?.message ?? '',
          role: Role.assistant,
          timeStamp: DateTime.now(),
        );
        setAiThinking(false);

        _messages.add(newMessage);

        addMessageToSession(newMessage);
        return response;
      } else {
        setAiThinking(false);
        return response;
      }
      // return _userFromFirebase(result.user);
    } on DioException catch (e) {
      setAiThinking(false);

      return ChatResponse.fromJson(e.response?.data);
    }
  }

  Future<File?> talkWithAssistant(File? audioFile) async {
    try {
      final userMessage = ChatMessage(
        message: '',
        role: Role.user,
        timeStamp: DateTime.now(),
        isAudio: true,
        audioFile: audioFile,
      );

      _messages.add(userMessage);
      setAiThinking(true);

      // notifyListeners();

      final response = await authApiClient.uploadAudioFile(audioFile!);

      final newMessage = ChatMessage(
        message: '',
        role: Role.assistant,
        timeStamp: DateTime.now(),
        isAudio: true,
        audioFile: response,
      );

      _messages.add(newMessage);
      setAiThinking(false);

      // notifyListeners();
      return response;
    } on DioException catch (e) {
      setAiThinking(false);

      //print('i got error \n\n\n\n');
      //print(e.toString());
      return null;
    }
  }
}
