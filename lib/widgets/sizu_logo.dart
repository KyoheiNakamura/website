import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'logo_button.dart';

class SizuLogo extends HookConsumerWidget {
  const SizuLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const LogoButton(
      uri: 'https://sizu.me/kyoheinakamura',
      darkModeAsset: 'assets/images/sizu-logo.svg',
      lightModeAsset: 'assets/images/sizu-logo.svg',
    );
  }
}
