import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class TutorialWidget extends StatefulWidget {
  const TutorialWidget({super.key});

  @override
  State<StatefulWidget> createState() => TutorialState();
}

class TutorialState extends State<TutorialWidget> {
  Map<String, StateMachineController> controllers = {};
  @override
  void initState() {
    super.initState();
  }

  Future<void> play() async {
    final animations = [
      'Zoom Out',
      'Machine Flashing On',
      'Machine Flashing Off',
      'Hide Bookbot',
    ];

    final inputs = controllers['Factory Scene']?.inputs ?? [];
    for (final animation in animations) {
      for (final input in inputs) {
        if (input.name == animation) {
          debugPrint('play  $animation');
          input.value = true;
        } else {
          input.value = false;
        }
      }

      await Future.delayed(const Duration(seconds: 2));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        RiveAnimation.asset(
          'assets/factory.riv',
          artboard: 'Factory Scene',
          alignment: Alignment.center,
          fit: BoxFit.contain,
          onInit: ((artboard) {
            final stateMachines = [
              'Factory Scene',
              'Robot Animations',
              'Robot Idle',
              'Robot Mouth',
              'Robot Eyes'
            ];
            for (final key in stateMachines) {
              final controller =
                  StateMachineController.fromArtboard(artboard, key);
              if (controller != null) {
                artboard.addController(controller);
                controllers[key] = controller;
              } else {
                debugPrint('controller ${key.toString()} is null');
              }
            }
          }),
        ),
        TextButton(onPressed: () => play(), child: const Text('play')),
      ],
    );
  }
}
