import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../services/services.dart';

class BackBar extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Widget action;
  final IconData icon;

  const BackBar({
    Key key,
    @required this.icon,
    @required this.onPressed,
    @required this.text,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: standardPadding,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: standardPadding / 2,
            horizontal: standardPadding / 2,
          ),
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  icon ?? Icons.arrow_back_ios_rounded,
                ),
                onPressed: onPressed ??
                    () {
                      NavigationService().pop();
                    },
              ),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (action != null) action,
            ],
          ),
        ),
      ],
    );
  }
}
