import 'package:alan_voice/alan_callback.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:qr_flutter/qr_flutter.dart';

Future<void> main() async {
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
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.red,
                    Colors.green,
                    Colors.black,
                  ],
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 60,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          QrImage(
                            version: QrVersions.auto,
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            size: 90,
                            // embeddedImage: const AssetImage(
                            //   'assets/icons8-search-50.png',
                            // ),
                            // embeddedImageStyle: QrEmbeddedImageStyle(
                            //   size: const Size(40, 40),
                            //   color: Colors.white,
                            // ),
                            data:
                                '00020101021126590013ID.CO.BNI.WWW011893600009150211577802096017020480303UMI51450015ID.OR.GPNQR.WWW0215ID10221724287270303UMI5204481453033605802ID5911BW*MOBAZONE6015LABUHANBATU UTA6105214576304B39E',
                            errorStateBuilder: (cxt, err) {
                              return const Center(
                                child: Text(
                                  "Uh oh! Something went wrong...",
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                          ),
                          const Text(
                            'Hello World AI Apps',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const GlassContainer(
                      height: 300,
                      width: 300,
                      // blur: 1,
                      opacity: 0.1,
                      shadowStrength: 5,
                      child: Center(
                        child: Text(
                          "Hello Alan",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  'asset/ai.jpg',
                  width: 100,
                  height: 100,
                ),
              ],
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
