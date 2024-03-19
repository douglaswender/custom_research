import 'package:custom_research/core/constants/theme.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const ButtonWidget(
      {super.key,
      required this.text,
      required this.onPressed,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor, // Button color
          textStyle: kButtonTextStyle, // Text color
          padding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 10), // Button padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Button border radius
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
            : Text(
                text,
                style: kButtonTextStyle,
              ),
      ),
    );
  }
}
