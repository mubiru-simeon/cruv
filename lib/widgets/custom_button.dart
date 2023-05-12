import 'package:flutter/material.dart';
import '../constants/constants.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  const CustomButton({
    Key key,
    @required this.onPressed,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        onPressed();
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(standardPadding / 2),
        padding: EdgeInsets.all(standardPadding),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: standardBorderRadius,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
