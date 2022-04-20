import 'package:decor_app/ui/pages/bottom_nav_page.dart';
import 'package:decor_app/utils/colors.dart';
import 'package:decor_app/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:simple_animations/simple_animations.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with AnimationMixin {
  final _enterTween = TimelineTween<EnterProp>()
    ..addScene(
      begin: Duration.zero,
      end: const Duration(seconds: 10),
      curve: Curves.elasticOut,
    ).animate(
      EnterProp.mainText,
      tween: Tween<double>(begin: -250, end: 10),
    )
    ..addScene(
      begin: const Duration(milliseconds: 2000),
      duration: const Duration(seconds: 12),
      curve: Curves.elasticOut,
    ).animate(
      EnterProp.titleText,
      tween: Tween<double>(begin: -100, end: 15),
    )
    ..addScene(
      begin: const Duration(milliseconds: 3000),
      duration: const Duration(seconds: 13),
      curve: Curves.elasticOut,
    ).animate(
      EnterProp.desc,
      tween: Tween<double>(begin: -260, end: 16),
    )
    ..addScene(
      begin: const Duration(milliseconds: 4200),
      duration: const Duration(seconds: 15),
      curve: Curves.elasticOut,
    ).animate(
      EnterProp.circle,
      tween: Tween<double>(begin: -500, end: -150),
    )
    ..addScene(
      begin: const Duration(milliseconds: 4500),
      duration: const Duration(seconds: 10),
      curve: Curves.elasticOut,
    ).animate(
      EnterProp.next,
      tween: Tween<double>(begin: -70, end: 15),
    );

  final _exitTween = TimelineTween<ExitProp>()
    ..addScene(
      begin: Duration.zero,
      end: const Duration(seconds: 10),
      curve: Curves.easeInOutCirc,
    )
        .animate(
          ExitProp.scale,
          tween: Tween<double>(begin: 1.0, end: 3.0),
        )
        .animate(
          ExitProp.color,
          tween: ColorTween(
            begin: kLandingSmallCircleColor,
            end: kBgColor,
          ),
        );

  late final Animation<TimelineValue<EnterProp>> _enterAnimation;
  late final Animation<TimelineValue<ExitProp>> _exitAnimation;
  late final AnimationController _exitAnimationController;

  @override
  void initState() {
    _enterAnimation = _enterTween.animate(controller);

    _exitAnimationController = createController();
    _exitAnimation = _exitTween.animate(_exitAnimationController);

    controller.play(duration: const Duration(milliseconds: 3000));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kLandingBgColor,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0.0,
            bottom: 0.0,
            child: Transform.translate(
              offset: Offset(
                _enterAnimation.value.get(EnterProp.circle),
                40.0,
              ),
              child: Transform.scale(
                scale: _exitAnimation.value.get(ExitProp.scale),
                child: Container(
                  width: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _exitAnimation.value.get(ExitProp.color),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Transform.translate(
                  offset: Offset(
                    _enterAnimation.value.get(EnterProp.titleText),
                    0.0,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(top: kToolbarHeight),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Neo',
                            style: TextStyle(
                              color: kTextPrimaryColor,
                            ),
                          ),
                          TextSpan(
                            text: 'Decor',
                            style: TextStyle(
                              color: kDecorColor,
                            ),
                          ),
                        ],
                      ),
                      style: TextStyle(
                        fontSize: 35.0,
                        color: kTextPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.08),
                Transform.translate(
                  offset: Offset(
                    _enterAnimation.value.get(EnterProp.mainText),
                    0.0,
                  ),
                  child: const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Let\'s\n',
                        ),
                        TextSpan(
                          text: 'decor\n',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        TextSpan(
                          text: 'your home',
                        ),
                      ],
                    ),
                    style: TextStyle(
                      fontSize: 50.0,
                      color: kTextPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Transform.translate(
                  offset: Offset(
                    _enterAnimation.value.get(EnterProp.desc),
                    0.0,
                  ),
                  child: const Text(
                    'Be faithful to your own taste, because\n'
                    'nothing you really like is ever out of style.',
                    style: TextStyle(
                      fontSize: 13.0,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Transform.translate(
                  offset: Offset(
                    _enterAnimation.value.get(EnterProp.next),
                    0.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(
                        Entypo.arrow_long_right,
                        size: 40.0,
                      ),
                      onPressed: () {
                        _exitAnimationController
                            .play(duration: const Duration(milliseconds: 500))
                            .whenComplete(() {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => BottomNavPage(),
                            ),
                          );
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
