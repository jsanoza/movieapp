import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';

import '../../../themes/app_text_theme.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DelayedWidget(
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: AppTextStyles.base.whiteColor.s16.w900,
            ),
          ],
        ),
      ),
    );
  }
}
