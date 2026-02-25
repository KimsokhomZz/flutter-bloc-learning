import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learning_flutter_bloc/pallete.dart';

class SocialButton extends StatelessWidget {
  final String label;
  final String iconPath;
  final double horizontalPadding;
  const SocialButton({
    super.key,
    required this.label,
    required this.iconPath,
    this.horizontalPadding = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        //TODO
      },
      icon: SvgPicture.asset(iconPath, width: 24, color: Pallete.whiteColor),
      label: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          color: Pallete.whiteColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: 32.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(color: Pallete.borderColor, width: 3),
        ),
      ),
    );
  }
}
