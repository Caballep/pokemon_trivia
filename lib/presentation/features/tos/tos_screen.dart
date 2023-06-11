import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_trivia/locator.dart';
import 'package:pokemon_trivia/presentation/features/splash/splash_screen.dart';
import 'package:pokemon_trivia/presentation/features/tos/tos_bloc.dart';
import 'package:pokemon_trivia/presentation/features/tos/widget/tos_accept_panel.dart';
import 'package:pokemon_trivia/presentation/features/tos/widget/tos_scrollable_content.dart';
import 'package:pokemon_trivia/presentation/shared/basic_dialog.dart';

class TosScreen extends StatefulWidget {
  final TosCubit _tosCubit = locator.get<TosCubit>();

  TosScreen({Key? key}) : super(key: key) {
    _tosCubit.verifyIsTosAccepted();
  }

  @override
  _TosScreenState createState() => _TosScreenState();
}

class _TosScreenState extends State<TosScreen> {
  bool _termsReaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: BlocBuilder<TosCubit, TosState>(
          bloc: widget._tosCubit,
          builder: (context, state) {
            if (state is TosErrorState) {
              _showErrorDialog();
            }

            if (state is TosAcceptedState || state is TosAlreadyAcceptedState) {
              _navigateToSplashScreen();
            }

            if (state is TosNotAcceptedState || state is TosAcceptingInProcessState) {
              return SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TosScrollableContent(
                      onTermsReadCallback: () {
                        setState(() {
                          _termsReaded = true;
                        });
                      },
                    ),
                    TosAcceptPanel(
                      termsReaded: _termsReaded,
                      onTermsAcceptedCallback: () {
                        widget._tosCubit.saveTosAcceptedDeviceData();
                      },
                    ),
                  ],
                ),
              );
            }
            return Container();
          }),
    );
  }

  void _navigateToSplashScreen() {
    Future.delayed(Duration.zero, () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SplashScreen()),
        (route) => false,
      );
    });
  }

  void _showErrorDialog() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) => BasicDialog(
          icon: Icons.cancel,
          iconColor: Colors.red,
          title: 'Something went wrong',
          text: 'If you keep experience issues please contact support',
          onConfirm: () {
            SystemNavigator.pop();
          },
        ),
      );
    });
  }
}
