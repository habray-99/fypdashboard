import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/custom_text_style.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final double height;
  final bool isDisabled;
  final Color? backGroundColor;
  final Color? textColor;
  final Color? borderColor;
  const CustomElevatedButton(
      {super.key,
      required this.title,
      required this.onTap,
      this.height = 50,
      this.isDisabled = false,
      this.backGroundColor,
      this.textColor,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.borderColor,
          minimumSize: Size.fromHeight(height),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      onPressed: isDisabled ? null : onTap,
      child: Text(
        title,
        style: CustomTextStyles.f16W600(color: textColor ?? Colors.white),
      ),
    );
  }
}
