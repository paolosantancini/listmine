import 'package:socket_io_client/socket_io_client.dart' as io;
import '../models/task.dart';
import 'package:flutter/foundation.dart';

class SocketService {
  String server = Uri.base.origin;
  String? _currentListId;

  late final io.Socket _socket;

  void connect() {
    _socket = io.io(
      server,
      io.OptionBuilder()
          .setPath("/listmine/socket.io/")
          .setTransports(["websocket"])
          .disableAutoConnect()
          .build(),
    );

    _socket.onConnect((_) {
      debugPrint("Socket connesso");
      if (_currentListId != null) {
        _socket.emit("join-list", _currentListId);
      }
    });

    _socket.onDisconnect((_) {
      debugPrint("Socket disconnesso");
    });

    _socket.onConnectError((err) {
      debugPrint(err);
    });

    _socket.connect();
  }

  void disconnect() {
    _socket.disconnect();
  }

  void joinList(String listId) {
    _currentListId = listId;
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
