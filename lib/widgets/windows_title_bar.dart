import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class WindowsTitleBar extends StatelessWidget {
  const WindowsTitleBar({Key? key, this.showMaximize = false})
      : super(key: key);

  final bool showMaximize;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      height: 25,
      child: Row(
        children: [
          (Navigator.of(context).canPop())
              ? IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 12,
                  ))
              : const SizedBox.shrink(),
          Expanded(child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onPanStart: (details){
              windowManager.startDragging();
            },
            child: SizedBox(
              height: Size.infinite.height,
            ),
          )),
          Row(
            children: [
              Material(
                shape: const CircleBorder(),
                color: Colors.redAccent,
                child: InkWell(
                  mouseCursor: SystemMouseCursors.basic,
                  customBorder: CircleBorder(),
                  onTap: (){
                    windowManager.close();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(2.0),
                    child: Center(child: Icon(Icons.close, size: 12, color: Theme.of(context).scaffoldBackgroundColor,)),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}