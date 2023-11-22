import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'logo_button.dart';

class XLogo extends HookConsumerWidget {
  const XLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const LogoButton(
      uri: 'https://x.com/elonmusk',
      darkModeAsset: 'assets/images/x-logo.svg',
      lightModeAsset: 'assets/images/x-logo.svg',
    );
  }
}
