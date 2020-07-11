import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class UtilityService extends ChangeNotifier{

  WebSocketChannel _channel;
  List<String> _messages = [];

  bool _isTyping =false;

  //  typing(){
  //   print("Inside typing");
  //   _isTyping = true;
  //   notifyListeners();
  // }

  //  doneTyping(){
  //   print("Done with typing");
  //   _isTyping = false;
  //   notifyListeners();
  // }

  connectWebSocketChannel() {
    _channel = IOWebSocketChannel.connect('ws://echo.websocket.org');
  }

  List<String> get messages => _messages;

  WebSocketChannel get channel => _channel;

  // bool get isTyping => _isTyping;


  void sendMessage(String message) {
    _channel.sink.add(message);
    // _messages.add(message);
    
  }


}