import 'package:flutter/material.dart';

class SendButton extends StatelessWidget {
  final String title;
  final void Function() onTap;
  const SendButton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height*0.07,
        width:  MediaQuery.of(context).size.width*0.7,
        child: Center(
            child: Text(title,
                style: TextStyle(fontSize: 20,
                 color: Colors.white,
                 fontWeight: FontWeight.w400))),
        decoration: BoxDecoration(
            color: Colors.green[600]),
      ),
    );
  }
}
