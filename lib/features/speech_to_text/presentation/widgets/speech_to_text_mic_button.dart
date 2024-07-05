import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:milkydiary/core/themes/apppallete.dart';


class STTMicButton extends StatefulWidget {
  final bool isListening;
  final void Function()? listen;
  final void Function()? stoplistening;


  const STTMicButton({super.key, required this.isListening, required this.listen, required this.stoplistening});

  @override
  State<STTMicButton> createState() => _STTMicButtonState();
}

class _STTMicButtonState extends State<STTMicButton> {
  @override
  Widget build(BuildContext context) {
    return  AvatarGlow(
        animate: widget.isListening,
        glowColor: primarycolorss,
        glowRadiusFactor: 1.0,
        duration: const Duration(milliseconds: 2000),
        repeat: true,
        startDelay: const Duration(milliseconds: 1000),
        child: FloatingActionButton(
          backgroundColor: primarycolorss,
          onPressed: widget.isListening ? widget.stoplistening : widget.listen,
          child: Icon(widget.isListening ? Icons.mic : Icons.mic_none),
        ),
      );
    
  }
}