import 'package:flutter/material.dart';
import 'package:pokemon_trivia/presentation/features/splash/splash_screen.dart';

class TosScreen extends StatefulWidget {
  const TosScreen({super.key});

  @override
  _TosScreenState createState() => _TosScreenState();
}

class _TosScreenState extends State<TosScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _termsReaded = false;
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_checkScrollPosition);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_checkScrollPosition);
    _scrollController.dispose();
    super.dispose();
  }

  void _checkScrollPosition() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        _termsReaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Terms of Service",
                        style: TextStyle(
                            color: Colors.grey[200],
                            fontSize: 28,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        termsOfService,
                        style: TextStyle(color: Colors.grey[200], fontSize: 15),
                        textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                ),
              ),
            )),
            Container(
              padding: EdgeInsets.all(25),
              color: Colors.grey[900],
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Theme(
                        data: ThemeData(
                          unselectedWidgetColor: !_termsReaded
                              ? Colors.grey[400]
                              : Colors.grey[100],
                        ),
                        child: Transform.scale(
                          scale: 1.4,
                          child: Checkbox(
                            value: _isChecked,
                            onChanged: _termsReaded
                                ? (value) {
                                    setState(() {
                                      _isChecked = value ?? false;
                                    });
                                  }
                                : null,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 2),
                            child: Text(
                              "I've read and understanded the terms of service and agree to abide by them.",
                              maxLines: null,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 18,
                                color: !_termsReaded
                                    ? Colors.grey[500]
                                    : _isChecked
                                        ? Colors.blue[400]
                                        : Colors.yellow[100],
                              ),
                            )),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: _isChecked
                          ? () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SplashScreen()),
                                (route) => false,
                              );
                            }
                          : null,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Colors.grey[400]!;
                            }
                            return Colors.blue;
                          },
                        ),
                      ),
                      child: Text(
                        'Accept',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

String termsOfService = '''

Please read carefully.

1. Acceptance of Terms:

By downloading, installing, or using [Your Game Name] (the "Game"), you agree to be bound by these Terms of Service ("ToS"). If you do not agree with these terms, you may not use the Game.


2. Non-Profit and Educational Use:

The Game is a non-profit, educational/fun project aimed at providing an interactive and entertaining experience for users. It is not intended for commercial purposes. By using the Game, you acknowledge and agree that it is for educational and recreational purposes only.


3. Data Source and Attribution:

The Game utilizes data and resources from PokéAPI (pokéapi.co) as its primary data provider. All Pokémon-related data, including but not limited to Pokémon names, images, and statistics, are sourced from PokéAPI. We acknowledge and give credit to PokéAPI as the data provider for the Game.


4. Intellectual Property:

All intellectual property rights, including copyrights, trademarks, and any other proprietary rights, associated with the Game and its content are the property of their respective owners. The Game does not claim any ownership rights over Pokémon intellectual property, which is owned by The Pokémon Company, Nintendo, and Game Freak.


5. Limitation of Liability:

The Game is provided on an "as is" basis without warranties of any kind, whether expressed or implied. We shall not be liable for any damages, losses, or liabilities arising from the use or inability to use the Game.


6. Privacy:

Any personal information collected from users will be handled in accordance with our Privacy Policy. By using the Game, you consent to the collection, storage, and processing of your personal information as described in the Privacy Policy.


7. Modification and Termination:

We reserve the right to modify or terminate the Game or these ToS at any time, for any reason, without notice. Your continued use of the Game following any modifications to the ToS constitutes your acceptance of the modified terms.

''';
