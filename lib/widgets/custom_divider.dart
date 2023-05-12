import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double height;
  const CustomDivider({
    Key key,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      height: 1,
      padding: height != null ? EdgeInsets.symmetric(vertical: height) : null,
      width: MediaQuery.of(context).size.width,
    );
  }
}
