import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loading extends StatelessWidget {
const Loading({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Center(
        child: LoadingAnimationWidget.dotsTriangle(color: Colors.purple, size: 46)
      );
  }
}