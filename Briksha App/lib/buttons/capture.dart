import 'package:flutter/material.dart';



class Capture extends StatefulWidget {
  Capture({required this.onTap});
  final void Function() onTap;

  @override
  _CaptureState createState() => _CaptureState();
}

class _CaptureState extends State<Capture> {
  double innerDiameter = 0.0;
  double margin = 35.0;
  double opacity = 0.5;

  void _setInitialValues() {
    innerDiameter = 0.0;
    margin = 35.0;
    opacity = 0.5;
    setState(() {});
  }

  void _setFinalValues() {
    innerDiameter = 74.0;
    margin = 2.0;
    opacity = 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) {
        _setFinalValues();
      },
      onTapUp: (_) {
        _setInitialValues();
      },
      onTapCancel: () {
        _setInitialValues();
        widget.onTap();
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 74.0,
          minWidth: 74.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              color: Colors.black87,
              width: 2.0,
            ),
          ),
          child: AnimatedContainer(
            height: innerDiameter,
            width: innerDiameter,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            margin: EdgeInsets.all(margin),
            decoration: BoxDecoration(
              color: Colors.black87.withOpacity(opacity),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
