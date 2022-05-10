import 'package:alan_voice/alan_callback.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import 'package:alan_voice/alan_voice.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        canvasColor: Colors.yellow,
      ),

      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  _MyHomePageState() {
    AlanVoice.addButton(
        "02c928ef41848e918efab694f76ffbc82e956eca572e1d8b807a3e2338fdd0dc/stage");

    AlanVoice.onCommand.add((Command command) {
      debugPrint("got new command ${command.toString()}");
    });
  }

  @override
  Widget build(BuildContext context) {
    /// [AnnotatedRegion<SystemUiOverlayStyle>] only for android black navigation bar. 3 button navigation control (legacy)

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 149, 241, 195),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: <Widget>[
            Center(
              child: Column(
                // ignore: always_specify_types
                children: [
                  const SizedBox(height: 200),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 200,
                      maxWidth: 300,
                      minHeight: 200,
                      maxHeight: 300,
                    ),
                    child: Container(
                      height: 500, //300
                      width: 500, //300
                      color: Colors.red,
                      alignment: Alignment.center,
                      child: const Text(
                        "penambahan histori chat AI dan bisa\nmenggunakan perintah TTS untuk no't voice",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
          child: WaterDropNavBar(
            onItemSelected: (int index) {
              setState(() {
                selectedIndex = index;
              });
            },
            selectedIndex: selectedIndex,
            barItems: <BarItem>[
              BarItem(
                filledIcon: Icons.smart_screen,
                outlinedIcon: Icons.smart_screen_outlined,
              ),
              BarItem(
                filledIcon: Icons.mic_none_rounded,
                outlinedIcon: Icons.mic_none_outlined,
              ),
              BarItem(
                filledIcon: Icons.message_rounded,
                outlinedIcon: Icons.message_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
