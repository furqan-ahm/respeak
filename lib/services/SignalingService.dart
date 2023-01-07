import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:respeak/models/descriptionModel.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';


typedef void StreamStateCallback(MediaStream stream);

class SignalingService{

  late Socket _socket;
  Map<String, dynamic> configuration = {
  };


  final StreamController _rawAnswerStreamController=StreamController();
  final StreamController _rawOfferStreamController=StreamController();

  static SignalingService instance=SignalingService._();



  SignalingService._(){
    _socket=io(
      kDebugMode?'http://127.0.0.1:3000':'https://respeak-signaling-server-production-6828.up.railway.app',
      OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build());

    _socket.on('room-joined', (data){
      
    });
    _socket.on('answer-recieved', (data){
      if(data[''])_rawAnswerStreamController.add(data);
    });
    _socket.on('offer-recieved', (data){
      if(data[''])_rawOfferStreamController.add(data);
    });

  }

  Stream<DescriptionModel> get answerStream=>_rawAnswerStreamController.stream.map((event){
    return DescriptionModel.fromMap(event);
  });
  Stream<DescriptionModel> get offerStream=>_rawOfferStreamController.stream.map((event){
    return DescriptionModel.fromMap(event);
  });






  establishConnection({Function()? onConnect}){
    _socket.onConnect((data){
      print('connected');
      onConnect!=null?onConnect():null;
      print(_socket.id);
    });
    _socket.connect();
  }
  

  connectToRoom(String name, String roomCode){
    _socket.emit('join',{
      'room':roomCode,
      'name':name
    });
  }


  disconnect()=>_socket.disconnect();

  // final _socket = io(
  //     'https://respeak-signaling-server-production.up.railway.app',
  //     OptionBuilder()
  //         .setTransports(['websocket'])
  //         .build());

}