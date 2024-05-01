import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'logger_service.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();
  bool isConnected = false;

  late IO.Socket socket;

  factory SocketService() {
    return _instance;
  }

  SocketService._internal() {
    _init();
  }

  void _init() {
    socket = IO.io('http://192.168.0.16:5000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.on('connect', (_) {
      isConnected = true;
    });
    socket.on('disconnect', (_) {
      isConnected = false;
    });

    socket.connect();
    Log.info("Connected to the API server");
  }

  void emit(String event, dynamic data) {
    if (socket.connected) {
      socket.emit(event, data);
      Log.info('Sent - $event event to the API server.');
    } else {
      Log.info('Socket not connected during $event event.');
    }
  }

  void on(String event, Function(dynamic) handler) {
    socket.on(event, handler);
    Log.info('Recieved - $event event from the API server.');
  }

  void connect() {
    Log.info('Connecting to the API server');
    socket.connect();
  }

  void disconnect() {
    Log.info('Disconnected from the API server');
    socket.disconnect();
  }

  bool get isConnectedStatus => isConnected;
}
