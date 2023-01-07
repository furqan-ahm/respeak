import 'package:flutter_webrtc/flutter_webrtc.dart';

class DescriptionModel{
  String uid;
  RTCSessionDescription desc;

  DescriptionModel({required this.uid, required this.desc,});

  static DescriptionModel fromMap(data)=>DescriptionModel(uid: data['uid'], desc: RTCSessionDescription(data['sdp'], data['type']));
}