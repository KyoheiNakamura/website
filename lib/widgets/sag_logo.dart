import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'logo_button.dart';

class SaGLogo extends HookConsumerWidget {
  const SaGLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const LogoButton(
      uri: 'https://sheepandgoat.io',
      darkModeAsset: 'assets/images/sag-logo-white.svg',
      lightModeAsset: 'assets/images/sag-logo-black.svg',
    );
  }
}
