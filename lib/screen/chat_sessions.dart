import 'package:flutter/material.dart';
// import 'package:hive_ui/hive_ui.dart';
// import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:supportu_flutter_app/data/chat.dart';

import 'package:supportu_flutter_app/provider/chat_provider.dart';
import 'package:supportu_flutter_app/screen/chat.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class ChatSessions extends StatefulWidget {
  const ChatSessions({super.key});

  @override
  State<ChatSessions> createState() => _ChatSessionsState();
}

class _ChatSessionsState extends State<ChatSessions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Sessions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Provider.of<ChatProvider>(context, listen: false).clearSessions();
            },
          ),
        ],
      ),
      body: Consumer<ChatProvider>(builder: (context, provider, _) {
        // lazy box to box

        // final chatBox = Hive.box('session');
        return ValueListenableBuilder<LazyBox<Sessions?>>(
          valueListenable: provider.sessionBox!.listenable(),
          builder: (context, box, widget) {
            return box.isEmpty
                ? const Center(
                    child: Text('No chat sessions'),
                  )
                : ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      // Sessions? session;

                      return FutureBuilder(
                          future: box.getAt((box.length - 1) - index),
                          builder: (context, snap) {
                            if (snap.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            final session = snap.data;
                            String formattedDate =
                                DateFormat('dd-MMM-yy  hh:mma').format(
                                    session?.messages?.last.timeStamp ??
                                        DateTime.now());

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: Colors.black,
                                child: ListTile(
                                  title: Text(
                                    session?.messages?.last.message ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Text(
                                      formattedDate,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(
                                            color: Colors.grey,
                                          ),
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(
                                        Icons.arrow_forward_ios_sharp),
                                    onPressed: () {
                                      // open chat screen
                                      print('session id : ${session?.key}');
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChatScreen(
                                            sessionId: session?.key,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                  );
          },
        );
      }),
    );
  }
}
