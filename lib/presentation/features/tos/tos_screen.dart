import 'package:flutter/material.dart';
import 'package:pokemon_trivia/presentation/features/splash/splash_screen.dart';
import 'package:pokemon_trivia/presentation/features/tos/widget/tos_accept_panel.dart';
import 'package:pokemon_trivia/presentation/features/tos/widget/tos_scrollable_content.dart';

class TosScreen extends StatefulWidget {
  const TosScreen({Key? key}) : super(key: key);

  @override
  _TosScreenState createState() => _TosScreenState();
}

class _TosScreenState extends State<TosScreen> {
  bool _termsReaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TosScrollableContent(
                onTermsReadCallback: () => {
                      setState(() {
                        _termsReaded = true;
                      })
                    }),
            TosAcceptPanel(
              termsReaded: _termsReaded,
              onTermsAcceptedCallback: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SplashScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
