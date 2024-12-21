import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class ASectionHeading extends StatelessWidget {
  const ASectionHeading({
    super.key,
    this.onPressed,
    this.textColor,
    this.buttontitle = 'View all',
    required this.title,
    this.showActionbutton = true,
  });

  final Color? textColor;
  final bool showActionbutton;
  final String title, buttontitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final darkMode = AHelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Heading Text
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: textColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        // Button
        if (showActionbutton)
          TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              foregroundColor:
                  darkMode ? AColors.textSecondary : AColors.textPrimary,
              textStyle: const TextStyle(fontSize: 14),
            ),
            child: Text(buttontitle),
          ),
      ],
    );
  }
}
