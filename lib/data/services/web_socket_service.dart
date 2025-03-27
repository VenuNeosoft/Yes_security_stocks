import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:stock_market/core/constants/url_helper.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class WebSocketService {
  final String url = baseUrl;
  late WebSocketChannel channel;
  StreamController<String> controller = StreamController.broadcast();
  Timer? _pingTimer;

  WebSocketService() {
    _connect();
  }

  void _connect() {
    channel = WebSocketChannel.connect(Uri.parse(url));
    if (kDebugMode) {
      print('WebSocket connected: $url');
    }

    channel.stream.listen(
      (data) {
        controller.add(data);
      },
      onError: (error) {
        if (kDebugMode) {
          print('WebSocket Error: $error');
        }
        _reconnect();
      },
      onDone: () {
        if (kDebugMode) {
          print('WebSocket closed. Reconnecting...');
        }
        _reconnect();
      },
    );

    _startPing();
  }

  void _startPing() {
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(const Duration(seconds: 20), (timer) {
      if (channel.closeCode == null) {
        channel.sink.add('{"action":"ping"}');
        if (kDebugMode) {
          print('Ping sent');
        }
      } else {
        if (kDebugMode) {
          print('Connection closed, stopping ping');
        }
        _pingTimer?.cancel();
      }
    });
  }

  void _reconnect() {
    Future.delayed(const Duration(seconds: 5), () {
      _connect();
    });
  }

  void subscribeToStocks(List<String> stocks) {
   
    for (String stock in stocks) {
      channel.sink.add(
        '{"action":"subscribe","type":"freefeed","symbols":["$stock"]}',
      );
    }

    if (kDebugMode) {
      print('Subscribed to Nifty 50');
    }
  }

  Stream<String> getStream() {
    return controller.stream;
  }

  void closeConnection() {
    _pingTimer?.cancel();
    channel.sink.close(status.normalClosure);
  }
}
