import 'package:flutter/material.dart';
import 'package:pokemon_trivia/presentation/shared/retro_text.dart';
import 'package:google_fonts/google_fonts.dart' as gf;

class DexFilters extends StatefulWidget {
  final void Function(String) onValueChanged;

  const DexFilters({Key? key, required this.onValueChanged}) : super(key: key);

  @override
  _FilterRowState createState() => _FilterRowState();
}

class _FilterRowState extends State<DexFilters> {
  final TextEditingController _filterController = TextEditingController();

  @override
  void dispose() {
    _filterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          RetroText(
            text: "Filter: ",
            color: Colors.black,
            fontSize: 36,
          ),
          Expanded(
            child: TextField(
                maxLines: 1,
                maxLength: 20,
                controller: _filterController,
                onChanged: (value) {
                  widget.onValueChanged(value);
                },
                style: gf.GoogleFonts.vt323(
                  fontSize: 32.0,
                  fontWeight: FontWeight.normal,
                ),
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                    border: InputBorder.none,
                    hintText: "name/number",
                    counterText: "")),
          ),
        ],
      ),
    );
  }
}
