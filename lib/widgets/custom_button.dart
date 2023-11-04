// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  double? height;
  double? width;
  Color? buttonColor;
  Color? textColor;
  Color? buttonSplashColor;
  BoxShadow? boxShadow;
  final VoidCallback onPressed;
  final String label;
  TextStyle? textStyle;
  BorderRadius? borderRadius;

  CustomButton(
      {this.height,
      this.textStyle,
      this.borderRadius,
      this.boxShadow,
      this.buttonColor,
      this.buttonSplashColor,
      this.textColor,
      this.width,
      required this.onPressed,
      required this.label});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onPressed();
      },
      onTapDown: (_) {
        setState(() {
          _isTapped = true;
        });
      },
      onTapCancel: () {
        setState(() {
          _isTapped = false;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isTapped = false;
        });
      },
      child: AnimatedContainer(
        height: widget.height ?? 60,
        width: widget.width ?? 248,
        duration: Duration(milliseconds: 222),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          boxShadow: [
            widget.boxShadow ??
                BoxShadow(
                    offset: Offset(2, 2),
                    spreadRadius: 3,
                    blurRadius: 2,
                    color: Colors.grey.shade200)
          ],
          color: _isTapped
              ? widget.buttonSplashColor ?? Colors.teal
              : widget.buttonColor ?? Colors.deepPurple.shade400,
          borderRadius: widget.borderRadius ?? BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            widget.label,
            style: widget.textStyle ??
                TextStyle(
                    color: widget.buttonColor ?? Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
          ),
        ),
      ),
    );
  }
}
