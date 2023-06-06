import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../themes/app_text_theme.dart';

class Notice extends StatelessWidget {
  const Notice({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 100,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LucideIcons.bot,
              color: Colors.red,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              "Connection Error",
              style: AppTextStyles.base.redColor.w900,
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Uh-oh looks like, you have no internet connection.",
            style: AppTextStyles.base.whiteColor.italic,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "During this demo, my focus is on saving the API responses from the homepage exclusively to the database, rather than storing them for individual series or movies.",
            style: AppTextStyles.base.whiteColor,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
