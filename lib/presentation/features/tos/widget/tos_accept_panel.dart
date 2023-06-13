import 'package:flutter/material.dart';

class TosAcceptPanel extends StatefulWidget {
  final VoidCallback onTermsAcceptedCallback;
  final bool termsReaded;

  const TosAcceptPanel({
    Key? key,
    required this.onTermsAcceptedCallback,
    required this.termsReaded,
  }) : super(key: key);

  @override
  State<TosAcceptPanel> createState() => _TosAcceptPanelState();
}

class _TosAcceptPanelState extends State<TosAcceptPanel> {
  late bool _termsReaded;
  late bool _isChecked;
  late bool _acceptingTerms;

  @override
  void initState() {
    super.initState();
    _termsReaded = widget.termsReaded;
    _isChecked = false;
    _acceptingTerms = false;
  }

  @override
  void didUpdateWidget(TosAcceptPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.termsReaded != oldWidget.termsReaded) {
      setState(() {
        _termsReaded = widget.termsReaded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
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
                  unselectedWidgetColor:
                      !_termsReaded ? Colors.grey[400] : Colors.grey[100],
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
              SizedBox(
                width: 12,
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: Text(
                    "I have read and comprehended the terms of service, and agree to adhere to all the stipulations, rules, and regulations outlined therein.",
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
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 22,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
                onPressed: _isChecked
                    ? () {
                        widget.onTermsAcceptedCallback();
                        _acceptingTerms = true;
                      }
                    : null,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return Colors.grey[600]!;
                      }
                      return Colors.blue;
                    },
                  ),
                ),
                child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 80,
                    child: _acceptingTerms
                        ? Container(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                        : Text(
                            'ACCEPT',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ))),
          ),
        ],
      ),
    );
  }
}
