import 'package:flutter/material.dart';

import '../constants/ui.dart';

class NoDataFound extends StatefulWidget {
  final String text;
  final String doSthText;
  final Function onTap;
  final double picSize;
  const NoDataFound({
    Key key,
    @required this.text,
    this.onTap,
    this.doSthText,
    this.picSize,
  }) : super(key: key);

  @override
  State<NoDataFound> createState() => _NoDataFoundState();
}

class _NoDataFoundState extends State<NoDataFound> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.text ?? "No data found",
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(
              height: 20,
            ),
            if (widget.onTap != null)
              GestureDetector(
                onTap: () async {
                  widget.onTap();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: standardBorderRadius,
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    widget.doSthText ?? "Tap here",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
