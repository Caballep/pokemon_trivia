import 'package:flutter/material.dart';
import 'package:pokemon_trivia/presentation/utils/strings.dart';

class TosScrollableContent extends StatelessWidget {
  final VoidCallback onTermsReadCallback;
  final ScrollController _scrollController = ScrollController();

  TosScrollableContent({Key? key, required this.onTermsReadCallback})
      : super(key: key) {
    _scrollController.addListener(_checkScrollPosition);
  }

  void _checkScrollPosition() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      onTermsReadCallback();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                    color: Colors.yellow[100],
                    fontSize: 30,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Please read carefully",
                style: TextStyle(
                    color: Colors.grey[100],
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
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
    ));
  }
}
