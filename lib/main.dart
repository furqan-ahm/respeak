
import 'package:flutter/material.dart';
import 'package:keyboard_event/keyboard_event.dart';
import 'package:provider/provider.dart';
import 'package:respeak/provider/SignalingProvider.dart';
import 'package:respeak/screens/start_screen.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:window_manager/window_manager.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(380, 570),
    center: true,
    backgroundColor: Colors.transparent,
    title: 'Respeak',
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setAsFrameless();
    await windowManager.startDragging();
  });
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: SignalingProvider(),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData.dark().copyWith(primaryColor: Colors.purple),
          home: const StartScreen(),
      ),
    );
  }
}
