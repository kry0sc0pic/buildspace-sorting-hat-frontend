import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sorter/landing.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lottie/lottie.dart';

class SurveyPage extends StatefulWidget {
  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  int _currentQuestionIndex = 0;
  final List<String> _answers = List.filled(5, ''); // initial empty answers
  final List<String> _questions = [
    "when given a task, do you prefer to dive right in or carefully plan your approach?",
    "how do you handle setbacks or failures?",
    "would you describe yourself as more of a leader or a team player?",
    "which of the following qualities do you value most in others: ambition, intelligence, optimism, or patience?",
    "how do you typically handle stress or pressure?"
  ];
  final TextEditingController _controller = TextEditingController();
  // function to move to the next question
  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < 4) {
        _currentQuestionIndex++;
      } else {
        // submit survey or show completion message
        print('Survey completed!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: MouseRegion(
          cursor: SystemMouseCursors.click,
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
        actions: [
          Icon(Icons.check_circle_outline_outlined,
              color: (_currentQuestionIndex >= 0 && _answers[0] != '')
                  ? Color(0xFF66bb66)
                  : Colors.white.withOpacity(0.5)),
          Icon(
            Icons.check_circle_outline_outlined,
            color: (_currentQuestionIndex >= 1 && _answers[1] != '')
                ? Color(0xFF66bb66)
                : Colors.white.withOpacity(0.5),
          ),
          Icon(
            Icons.check_circle_outline_outlined,
            color: (_currentQuestionIndex >= 2 && _answers[2] != '')
                ? Color(0xFF66bb66)
                : Colors.white.withOpacity(0.5),
          ),
          Icon(
            Icons.check_circle_outline_outlined,
            color: (_currentQuestionIndex >= 3 && _answers[3] != '')
                ? Color(0xFF66bb66)
                : Colors.white.withOpacity(0.5),
          ),
          Icon(
            Icons.check_circle_outline_outlined,
            color: (_currentQuestionIndex >= 4 && _answers[4] != '')
                ? Color(0xFF66bb66)
                : Colors.white.withOpacity(0.5),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _questions[_currentQuestionIndex],
              style: GoogleFonts.manrope(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _controller,
              maxLines: 3, // allow for multiple lines of text
              maxLength: 400,
              cursorColor: Colors.white,
              onChanged: (answer) {
                setState(() {
                  _answers[_currentQuestionIndex] = answer;
                }); // store answer
              },

              autofocus: true,
              autocorrect: true,
              style: GoogleFonts.manrope(
                color: Colors.white.withOpacity(0.9),
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                  hintText: 'Type your answer here',
                  hintStyle: GoogleFonts.manrope(
                    color: Colors.white.withOpacity(0.5),
                    fontWeight: FontWeight.w600,
                  ),
                  fillColor: Colors.white.withOpacity(0.1),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white.withOpacity(0.3), width: 1))),
            ),
            Row(
              children: [
                Visibility(
                  visible: _currentQuestionIndex != 0,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentQuestionIndex--;
                          _controller.text = _answers[_currentQuestionIndex];
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(85000),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        child: Text(
                          'prev',
                          style: GoogleFonts.manrope(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () async {
                      // check if there is an answer
                      if (_currentQuestionIndex == 4) {
                        //submisson
                        showDialog(
                            context: context,
                            builder: (context) {
                              return ResultDialog({
                                "question1": _answers[0],
                                "question2": _answers[1],
                                "question3": _answers[2],
                                "question4": _answers[3],
                                "question5": _answers[4],
                              });
                            }).then((_) {
                          Navigator.pushReplacement(
                              context,
                              (MaterialPageRoute(
                                  builder: (context) => const WelcomePage())));
                        });

                        return;
                      }
                      if (_answers[_currentQuestionIndex].isEmpty) {
                        //TODO: show error message

                        return;
                      }
                      _controller.text = ''; // clear text field
                      _nextQuestion();
                    },
                    child: Opacity(
                      opacity:
                          _answers[_currentQuestionIndex].isEmpty ? 0.5 : 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: _currentQuestionIndex < 4
                              ? Colors.white
                              : Color(0xFF66bb66),
                          borderRadius: BorderRadius.circular(85000),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        child: Text(
                          _currentQuestionIndex < 4 ? 'next' : 'submit',
                          style: GoogleFonts.manrope(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: _currentQuestionIndex < 4
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   child: Row(
      //     children: [
      //       if (_currentQuestionIndex > 0)
      //         TextButton(
      //           onPressed: () {
      //             setState(() {
      //               _currentQuestionIndex--;
      //             });
      //           },
      //           child: Text('Back'),
      //         ),
      //       Spacer(),
      //       Text('${_currentQuestionIndex + 1} of 5'),
      //       Spacer(),
      //       TextButton(
      //         onPressed: _nextQuestion,
      //         child: _currentQuestionIndex < 4 ? Text('Next') : Text('Submit'),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

enum Houses { spectreseek, alterok, gaudmire, erevald, none }

class ResultDialog extends StatefulWidget {
  const ResultDialog(this.data, {super.key});
  final Map<String, String> data;
  @override
  State<ResultDialog> createState() => _ResultDialogState();
}

class _ResultDialogState extends State<ResultDialog> {
  Houses _house = Houses.none;
  @override
  void initState() {
    Dio dio = new Dio();

    dio.post('/api/reccomendation', data: widget.data).then((r) {
      RegExp exp = new RegExp(r'\[(.*?)\]');
      print(r.data.toString().toLowerCase());
      Iterable<Match> matches = exp.allMatches(r.data.toString().toLowerCase());
      print(matches);
      String house = 'erevald';
      if (matches.isNotEmpty) {
        house = matches.first.group(1)!;
      }

      switch (house) {
        case 'spectreseek':
          setState(() {
            _house = Houses.spectreseek;
          });
          break;
        case 'alterok':
          setState(() {
            _house = Houses.alterok;
          });
          break;
        case 'gaudmire':
          setState(() {
            _house = Houses.gaudmire;
          });
          break;
        case 'erevald':
          setState(() {
            _house = Houses.erevald;
          });
          break;
        default:
          setState(() {
            _house = Houses.erevald;
          });
      }
    }).onError((error, stackTrace) {
      _house = Houses.erevald;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_house == Houses.none) {
      return AlertDialog(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        content: Lottie.asset('assets/51634-train-buildings.json',
            height: 300, width: 300),
      );
    }
    String image = 'assets/green.jpg';
    switch (_house) {
      case Houses.spectreseek:
        image = 'assets/red.jpg';
        break;
      case Houses.alterok:
        image = 'assets/blue.jpg';
        break;
      case Houses.gaudmire:
        image = 'assets/yellow.jpg';
        break;
      case Houses.erevald:
        image = 'assets/green.jpg';
        break;
      case Houses.none:
        image = 'assets/green.jpg';

        break;
    }
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: Colors.black,
      actionsPadding: EdgeInsets.symmetric(vertical: 10),
      actionsOverflowAlignment: OverflowBarAlignment.center,
      title: Text(
        "your house is",
        style: GoogleFonts.manrope(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
      ),
      content: BuildspaceHouseImage(imagePath: image),
      actions: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () async {
              Uri url = Uri.parse('https://buildspace.so/home');
              await launchUrl(url);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1.5),
                  borderRadius: BorderRadius.circular(5000),
                  color: Colors.transparent),
              child: Text("get assets",
                  style: GoogleFonts.manrope(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  )),
            ),
          ),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () async {
              final Uri url = Uri(
                  scheme: 'https',
                  host: 'twitter.com',
                  path: 'intent/tweet',
                  queryParameters: {
                    "text":
                        "#${_house.name} @_buildspace, LFG 🚀.\nwhat house are you in?\nfind your house at https://buildspace-house.up.railway.app/"
                  });
              await launchUrl(url);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5000),
                  color: Colors.white),
              child: Text("share on twitter",
                  style: GoogleFonts.manrope(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  )),
            ),
          ),
        ),
      ],
    );
  }
}

getColorFromHouse(h) {
  switch (h) {
    case Houses.spectreseek:
      return Colors.red;
    case Houses.alterok:
      return Colors.blue;
    case Houses.gaudmire:
      return Colors.yellow;
    case Houses.erevald:
      return Colors.green;
    case Houses.none:
      return Colors.red;
  }
}
