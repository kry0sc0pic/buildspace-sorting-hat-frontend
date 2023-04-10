import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sorter/question.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () async {
                Uri uri = Uri.parse('https://buildspace.so/');
                await launchUrl(uri);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/48.png', height: 48, width: 48),
                  Text(
                    'buildspace',
                    style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        letterSpacing: -1),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Align(
              alignment: Alignment.center,
              child: Text("Built by",
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.5),
                    letterSpacing: 0,
                  )),
            ),
            Align(
              alignment: Alignment.center,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () async {
                    Uri uri = Uri.parse('https://linkedin.com/in/krishaayjois');
                    await launchUrl(uri);
                  },
                  child: Text(
                    " Krishaay",
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white.withOpacity(0.7),
                      color: Colors.white.withOpacity(0.7),
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: IconButton(
                  onPressed: () async {
                    Uri uri = Uri.parse(
                        'https://github.com/kry0sc0pic/buildspace-sorting-hat');
                    await launchUrl(uri);
                  },
                  icon: Icon(
                    Icons.code,
                    color: Colors.white.withOpacity(0.7),
                    size: 30,
                  )),
            )
          ],
        ),
        body: const LandingPage());
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  double learnMoreOpacity = 1;
  double letsGoOpacity = 1;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        List<Widget> imageLayout = [];
        if (constraints.maxWidth >= 1472) {
          imageLayout = [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BuildspaceHouseImage(imagePath: 'assets/red.jpg'),
                BuildspaceHouseImage(imagePath: 'assets/blue.jpg'),
                BuildspaceHouseImage(imagePath: 'assets/yellow.jpg'),
                BuildspaceHouseImage(imagePath: 'assets/green.jpg'),
              ],
            ),
          ];
        } else if (constraints.maxWidth >= 762) {
          imageLayout = [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BuildspaceHouseImage(imagePath: 'assets/red.jpg'),
                BuildspaceHouseImage(imagePath: 'assets/blue.jpg'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BuildspaceHouseImage(imagePath: 'assets/yellow.jpg'),
                BuildspaceHouseImage(imagePath: 'assets/green.jpg'),
              ],
            ),
          ];
        } else {
          imageLayout = [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BuildspaceHouseImage(imagePath: 'assets/red.jpg'),
                BuildspaceHouseImage(imagePath: 'assets/blue.jpg'),
                BuildspaceHouseImage(imagePath: 'assets/yellow.jpg'),
                BuildspaceHouseImage(imagePath: 'assets/green.jpg'),
              ],
            ),
          ];
        }
        return SingleChildScrollView(
          child: Container(
              child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                Text(
                  "which one are you?",
                  style: GoogleFonts.manrope(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 84,
                      letterSpacing: -3.6),
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SurveyPage())),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5000),
                              color: Colors.white),
                          child: Text("find out - 2 mins",
                              style: GoogleFonts.manrope(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () async {
                          Uri uri = Uri.parse('https://buildspace.so/more');
                          await launchUrl(uri);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.white
                                      .withOpacity(learnMoreOpacity),
                                  width: 1.5),
                              borderRadius: BorderRadius.circular(5000),
                              color: Colors.transparent),
                          child: Text("learn more",
                              style: GoogleFonts.manrope(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                ...imageLayout,

                // SizedBox.expand(),
                // Row(
                //   children: [
                //     Text(
                //       "Built by Krishaay",
                //       style: GoogleFonts.manrope(
                //         color: Colors.white.withOpacity(0.5),
                //       ),
                //     )
                //   ],
                // ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )),
        );
      },
    );
  }
}

class BuildspaceHouseImage extends StatefulWidget {
  const BuildspaceHouseImage({super.key, required this.imagePath});
  final String imagePath;

  @override
  State<BuildspaceHouseImage> createState() => _BuildspaceHouseImageState();
}

class _BuildspaceHouseImageState extends State<BuildspaceHouseImage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GlassmorphicContainer(
        width: 352,
        height: 352,
        blur: 20,
        borderRadius: 24,
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFffffff).withOpacity(0.5),
            Color((0xFFFFFFFF)).withOpacity(0.5),
          ],
        ),
        linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFffffff).withOpacity(0.1),
              Color(0xFFFFFFFF).withOpacity(0.05),
            ],
            stops: [
              0.1,
              1,
            ]),
        border: 3,
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              widget.imagePath,
              fit: BoxFit.cover,
              width: 350,
              height: 350,
            ),
          ),
        ),
      ),
    );
  }
}
