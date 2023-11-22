import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'logo_button.dart';

class ZennLogo extends HookConsumerWidget {
  const ZennLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const LogoButton(
      uri: 'https://zenn.dev/kyoheinakamura',
      darkModeAsset: 'assets/images/zenn-logo-white.svg',
      lightModeAsset: 'assets/images/zenn-logo-black.svg',
    );
  }
}
