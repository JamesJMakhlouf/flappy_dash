import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TapToPlay extends StatelessWidget {
  const TapToPlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 0.15),
      child: IgnorePointer(
        child: Text(
          'TAP TO PLAY',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w900,
            color: Colors.amber,
            shadows: [
              for (double i = 0; i < 3; i += 0.25) 
                Shadow(
                  color: Colors.black,
                  offset: Offset(i, i)
                ),
              for (double i = 0; i < 1.5; i += 0.25) 
                Shadow(
                  color: Colors.white,
                  offset: Offset(-i, -i)
                )
            ]
          ),
        ).animate(
          onPlay: (controller) => controller.repeat(
            reverse: true,
          ),
        ).scale(
          begin: Offset(1.0, 1.0),
          end: Offset (1.125, 1.125),
          duration: const Duration(milliseconds: 750),
          curve: Curves.easeInOut
        ),
      ),
    );
  }
}