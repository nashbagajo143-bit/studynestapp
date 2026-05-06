import 'package:flutter/material.dart';
import 'package:mystudynestflutter/4screen/app_colors.dart';

class BackBtn extends StatelessWidget {
  const BackBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFEEEEEE)),
        ),
        child: const Icon(Icons.arrow_back_ios_rounded, size: 16, color: AppColors.textDark),
      ),
    );
  }
}