import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'logo_button.dart';

class GitHubLogo extends HookConsumerWidget {
  const GitHubLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const LogoButton(
      uri: 'https://github.com/KyoheiNakamura',
      darkModeAsset: 'assets/images/github-logo-white.svg',
      lightModeAsset: 'assets/images/github-logo-black.svg',
    );
  }
}
