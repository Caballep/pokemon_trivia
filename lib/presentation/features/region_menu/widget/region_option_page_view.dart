import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:pokemon_trivia/presentation/features/region_menu/widget/region_option/region_option.dart';

class RegionOptionPageView extends StatefulWidget {
  final List<String> generationCodes;
  bool regionTransition = false;
  RegionOptionPageView({Key? key, required this.generationCodes}) : super(key: key);

  @override
  State<RegionOptionPageView> createState() => _RegionOptionPageViewState();
}

class _RegionOptionPageViewState extends State<RegionOptionPageView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8, initialPage: 0 // TODO
        );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _pageListener() {
    if (_pageController.page == _pageController.page!.roundToDouble()) {
      // Page has snapped to an integer value, transition has ended
      setState(() {
        widget.regionTransition = false;
      });
    } else {
      // Page is transitioning
      setState(() {
        widget.regionTransition = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      //physics: const CustomPageScrollPhysics(),
      itemCount: widget.generationCodes.length,
      itemBuilder: (context, index) {
        return Container(
          child: RegionOption(
            generationCode: widget.generationCodes[index],
            onRegionClicked: (generationCode) {
              // Handle the click event here
              print("Clicked on generation: $generationCode");
            },
          ),
          padding: EdgeInsets.only(left: 20, right: 20),
        );
      },
    );
  }
}

class CustomPageScrollPhysics extends ScrollPhysics {
  const CustomPageScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  CustomPageScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomPageScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    if (velocity.abs() < 500.0) {
      // Simulate a snap when velocity is near 0
      return SpringSimulation(
        SpringDescription.withDampingRatio(
          mass: 0.5,
          stiffness: 100.0,
          ratio: 0.5,
        ),
        position.pixels,
        position.pixels + velocity,
        0.0,
      );
    }
    return super.createBallisticSimulation(position, velocity);
  }
}
