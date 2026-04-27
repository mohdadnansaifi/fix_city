
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/utils/helpers/helper_function.dart';

class UFormDivider extends StatelessWidget {
  const UFormDivider({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        Expanded(
          child: Divider(
            indent: 40,
            endIndent: 5,
            thickness: 0.5,
            color: dark ? UColors.grey : UColors.grey,
          ),
        ),
        Text(title, style: Theme.of(context).textTheme.labelSmall),
        Expanded(
          child: Divider(
            indent: 5,
            endIndent: 40,
            thickness: 0.5,
            color: dark ? UColors.grey : UColors.grey,
          ),
        ),
      ],
    );
  }
}
