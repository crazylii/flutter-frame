import 'dart:convert';
import 'dart:isolate';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:async/async.dart';
const filenames = [
  'assets/app_en.arb',
  'assets/app_zh.arb',
];
///主副线程多次交互式演示
class LongRunningIsolate {
  void main() async {
    await for (final jsonData in _sendAndReceive(filenames)) {
      // LoggerUtil().d('Received JSON with ${jsonData.length} keys');
      print('Received JSON with ${jsonData.length} keys');
    }
  }
}

// Spawns an isolate and asynchronously sends a list of filenames for it to
// read and decode. Waits for the response containing the decoded JSON
// before sending the next.
//
// Returns a stream that emits the JSON-decoded contents of each file.
Stream<Map<String, dynamic>> _sendAndReceive(List<String> filenames) async* {
  final p = ReceivePort();
  await Isolate.spawn(_readAndParseJsonService, p.sendPort);

  // Convert the ReceivePort into a StreamQueue to receive messages from the
  // spawned isolate using a pull-based interface. Events are stored in this
  // queue until they are accessed by `events.next`.
  final events = StreamQueue<dynamic>(p);

  // The first message from the spawned isolate is a SendPort. This port is
  // used to communicate with the spawned isolate.
  SendPort sendPort = await events.next;

  for (var filename in filenames) {
    // Send the next filename to be read and parsed
    sendPort.send(filename);

    // Receive the parsed JSON
    Map<String, dynamic> message = await events.next;

    // Add the result to the stream returned by this async* function.
    yield message;
  }

  // Send a signal to the spawned isolate indicating that it should exit.
  sendPort.send(null);

  // Dispose the StreamQueue.
  await events.cancel();
}

Future _readAndParseJsonService(SendPort p) async {
  // LoggerUtil().i('Spawned isolate started.');
  // Send a SendPort to the main isolate so that it can send JSON strings to
  // this isolate.
  final commandPort = ReceivePort();
  p.send(commandPort.sendPort);

  // Wait for messages from the main isolate.
  await for (final message in commandPort) {
    if (message is String) {
      // Read and decode the file.
      // final contents = await File(message).readAsString();
      final contents = await rootBundle.loadString(message);

      // Send the result to the main isolate.
      p.send(jsonDecode(contents));
    } else if (message == null) {
      // Exit if the main isolate sends a null message, indicating there are no
      // more files to read and parse.
      break;
    }
  }

  // LoggerUtil().i('Spawned isolate finished.');
  Isolate.exit();
}