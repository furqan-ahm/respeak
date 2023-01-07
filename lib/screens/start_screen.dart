import 'package:fade_out_particle/fade_out_particle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:respeak/provider/SignalingProvider.dart';
import 'package:respeak/widgets/loading.dart';
import 'package:respeak/widgets/windows_title_bar.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController room = TextEditingController();

  bool isBall = false;

  final InputDecoration dec = const InputDecoration(
    filled: true,
    fillColor: Colors.black12,
  );

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 1000),
      tween: ColorTween(begin: Colors.purple, end: Colors.transparent),
      builder: (context, value, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(stops: [0], colors: [value??Colors.transparent])
                .createShader(bounds);
          },
          blendMode: BlendMode.dstOut,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Scaffold(
              body: Column(
                children: [
                  const WindowsTitleBar(),
                  Expanded(
                    child: !Provider.of<SignalingProvider>(context).isConnected
                        ? const Loading()
                        : Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20),
                            child: Column(
                              children: [
                                const Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 2),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            color: Colors.purple),
                                        child: const Text(
                                          'Re',
                                          style: TextStyle(
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    const Text(
                                      ' speak',
                                      style: TextStyle(fontSize: 40),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextField(
                                      controller: room,
                                      decoration:
                                          dec.copyWith(labelText: 'Room Code'),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextField(
                                        controller: name,
                                        decoration: dec.copyWith(
                                            labelText: 'Nickname')),
                                  ],
                                ),
                                const Spacer(),
                                Material(
                                  color: Colors.purpleAccent,
                                  borderRadius: BorderRadius.circular(5),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(5),
                                    onTap: () {
                                      setState(() {
                                        isBall = !isBall;
                                      });
                                    },
                                    child: SizedBox(
                                      width: Size.infinite.width,
                                      height: 45,
                                      child: const Center(
                                          child: Text(
                                        'Join',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
