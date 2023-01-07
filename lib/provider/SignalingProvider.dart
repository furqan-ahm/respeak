import 'package:flutter/material.dart';
import 'package:respeak/services/SignalingService.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class SignalingProvider extends ChangeNotifier{
  SignalingService service=SignalingService.instance;

  bool isConnected=false;

  Map<String, RTCPeerConnection> connections={};
  Map<String, MediaStream> remoteStreams={}; 

  MediaStream? localStream;
  String? roomId;
  StreamStateCallback? onAddRemoteStream;

  SignalingProvider(){
    service.establishConnection(
      onConnect: initialize
    );
  }

  initialize(){
    isConnected=true;
    notifyListeners();
  }

  joinRoom(String name, String roomCode){

    service.connectToRoom(name, roomCode);
  }



  @override
  void dispose() {
    print('destroy');
    service.disconnect();
    super.dispose();
  }

}