import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/link.dart';

import '../extensions/context.dart';

const logoButtonSize = 48.0;

class LogoButton extends HookConsumerWidget {
  const LogoButton({
    super.key,
    required this.uri,
    required this.darkModeAsset,
    required this.lightModeAsset,
  });

  final String uri;
  final String darkModeAsset;
  final String lightModeAsset;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Link(
      uri: Uri.parse(uri),
      target: LinkTarget.blank,
      builder: (context, followLink) => IconButton(
        onPressed: followLink,
        icon: SvgPicture.asset(
          context.isDarkMode ? darkModeAsset : lightModeAsset,
          height: logoButtonSize,
          width: logoButtonSize,
          color: context.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
