import 'package:flutter/material.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/widget/region_option/region_option.dart';
import 'package:flutter/material.dart';

class RegionOptionPageView extends StatefulWidget {
  final List<String> generationCodes;
  final Function(String generationCode) onRegionClicked;
  bool regionTransition = false;
  RegionOptionPageView({Key? key, required this.generationCodes, required this.onRegionClicked})
      : super(key: key);

  @override
  State<RegionOptionPageView> createState() => _RegionOptionPageViewState();
}

class _RegionOptionPageViewState extends State<RegionOptionPageView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    final positionBeforeAnimation = widget.generationCodes.length;
    _pageController = PageController(
        viewportFraction: 0.80, initialPage: positionBeforeAnimation, keepPage: true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // You can add a delay before auto-scrolling, if needed.
    Future.delayed(Duration(milliseconds: 0), () {
      // Scroll to the left beyond position 0 (page 0).
      _pageController.animateToPage(0,
          duration: const Duration(milliseconds: 1000), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: const BouncingScrollPhysics(),
      controller: _pageController,
      itemCount: widget.generationCodes.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: RegionOption(
            generationCode: widget.generationCodes[index],
            onRegionClicked: (String generationCode) {},
          ),
        );
      },
    );
  }
}
