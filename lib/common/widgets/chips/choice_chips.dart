import 'package:aurakart/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:aurakart/utils/constants/colors.dart';
import 'package:aurakart/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class AChoiceChip extends StatelessWidget {
  const AChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final isColor = AHelperFunctions.getColor(text) != null;
    
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: isColor ? const SizedBox() : Text(text),
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected ? AColors.white : null),
        avatar: isColor
            ? ACircularContainer(
                width: 50,
                height: 50,
                backgroundColor: AHelperFunctions.getColor(text)!,
              )
            : null,
        shape: isColor ? const CircleBorder() : null,
        // Make icon in the center
        labelPadding: isColor ? const EdgeInsets.all(0) : null,
        padding: isColor ? const EdgeInsets.all(0) : null,
        backgroundColor: isColor ? AHelperFunctions.getColor(text)! : null,
      ),
    );
  }
}
