import 'package:socket_io_client/socket_io_client.dart' as io;

import '../models/task.dart';

class SocketService {
  static const String server = "http://94.177.201.57:3000";

  late final io.Socket _socket;

  void connect() {
    _socket = io.io(
      server,
      io.OptionBuilder()
          .setTransports(["websocket"])
          .disableAutoConnect()
          .build(),
    );

    _socket.onConnect((_) {
      print("Socket connesso");
//      joinList(currentListId);
    });

    _socket.onDisconnect((_) {
      print("Socket disconnesso");
    });

    _socket.onConnectError((err) {
      print(err);
    });

    _socket.connect();
  }

  void disconnect() {
    _socket.disconnect();
  }

  void joinList(String listId) {
    _socket.emit("join-list", listId);
  }

  void leaveList(String listId) {
    _socket.emit("leave-list", listId);
  }

  void onTaskCreated(Function(Task) callback) {
    _socket.on("taskCreated", (data) {
      callback(Task.fromJson(Map<String, dynamic>.from(data)));
    });
  }

  void onTaskUpdated(Function(Task) callback) {
    _socket.on("taskUpdated", (data) {
      callback(Task.fromJson(Map<String, dynamic>.from(data)));
    });
  }

  void onTaskDeleted(Function(int) callback) {
    _socket.on("taskDeleted", (data) {
      callback(data["id"]);
    });
  }
}
