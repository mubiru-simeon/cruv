import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants/ui.dart';
import '../services/services.dart';

class ProceedButton extends StatefulWidget {
  final String text;
  final String processingText;
  final BorderRadius borderRadius;
  final Function onTap;
  final bool outlined;
  final Color color;
  final bool enablable;
  final bool enabled;
  final Widget child;
  final bool processing;
  final double textSize;

  const ProceedButton({
    Key key,
    @required this.onTap,
    this.text = "Proceed",
    this.outlined = false,
    this.enablable = false,
    this.color,
    this.enabled,
    this.processingText,
    this.borderRadius,
    this.child,
    this.processing = false,
    this.textSize,
  }) : super(key: key);

  @override
  State<ProceedButton> createState() => _ProceedButtonState();
}

class _ProceedButtonState extends State<ProceedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 5,
        right: 5,
        bottom: 5,
        top: 5,
      ),
      child: GestureDetector(
        onTap: widget.processing
            ? () {
                CommunicationServices().showToast(
                  "Processing. Please wait..",
                  primaryColor,
                );
              }
            : widget.enablable != null && widget.enablable
                ? widget.enabled
                    ? widget.onTap
                    : null
                : widget.onTap,
        child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(standardPadding * 2),
            decoration: BoxDecoration(
              border: widget.outlined != null && widget.outlined
                  ? Border.all(
                      width: 1,
                    )
                  : null,
              color: widget.outlined != null && widget.outlined
                  ? null
                  : widget.enablable != null && widget.enablable
                      ? widget.enabled
                          ? widget.color ?? primaryColor
                          : Colors.grey
                      : widget.color ?? primaryColor,
              borderRadius: widget.borderRadius ?? standardBorderRadius,
            ),
            child: Center(
                child: widget.processing
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SpinKitWave(
                            size: 20,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: standardPadding,
                          ),
                          if (widget.processingText != null)
                            Text(
                              widget.processingText,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                        ],
                      )
                    : widget.text == null
                        ? widget.child
                        : Text(
                            widget.text,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ))),
      ),
    );
  }
}
