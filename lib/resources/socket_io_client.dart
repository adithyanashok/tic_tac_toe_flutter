import 'package:socket_io_client/socket_io_client.dart' as socket_io;

class SocketIOClient {
  socket_io.Socket? socket;
  static SocketIOClient? _instance;

  SocketIOClient._internal() {
    socket = socket_io.io('http://ipaddress:5000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket?.connect();
  }

  static SocketIOClient? get instance {
    _instance ??= SocketIOClient._internal();
    return _instance;
  }
}
