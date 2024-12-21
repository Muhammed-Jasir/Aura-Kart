import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class ARatingProgressIndicator extends StatelessWidget {
  const ARatingProgressIndicator({
    super.key,
    required this.text,
    required this.value,
  });

  final String text;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
        ),
        Expanded(
          flex: 11,
          child: SizedBox(
            width: ADeviceUtils.getScreenWidth(context) * 0.8,
            child: LinearProgressIndicator(
              value: value,
              minHeight: 11,
              backgroundColor: AColors.grey,
              borderRadius: BorderRadius.circular(7),
              valueColor: const AlwaysStoppedAnimation(AColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}
