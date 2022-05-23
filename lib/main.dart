import 'package:alan_voice/alan_callback.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'AI Alan aps',
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

  @override
  Widget build(BuildContext context) {
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
                image: DecorationImage(
                  image: AssetImage("assets/jar.jpg"),
                  fit: BoxFit.fill,
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
                            size: 80,
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
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GlassContainer(
                      height: 250,
                      width: 320,
                      blur: 1,
                      border: 5,
                      child: const Center(
                        child: Text(
                          "Hello Alan",
                        ),
                      ),
                    ),
                    GlassListTile(
                      trailing : const GlassIcon(Icons.send),
                      title: TextField(
                        decoration: InputDecoration(
                          hintText: 'enter the command here',
                          border: InputBorder.none,
                          hintStyle: glassTextStyle,
                        ),
                        style: glassTextStyle,
                      ),
                      onTap: () {},
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            AlanVoice.addButton(
                "02c928ef41848e918efab694f76ffbc82e956eca572e1d8b807a3e2338fdd0dc/stage");

            AlanVoice.onCommand.add((Command command) {
              debugPrint("got new command ${command.toString()}");
            });
          },
          child: const Icon(
            Icons.mic_none_rounded,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
