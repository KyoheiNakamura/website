import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../controllers/theme_color_controller.dart';
import '../extensions/context.dart';
import '../widgets/github_logo.dart';
import '../widgets/logo_button.dart';
import '../widgets/profile_card.dart';
import '../widgets/sag_logo.dart';
import '../widgets/sizu_logo.dart';
import '../widgets/theme_toggle_button.dart';
import '../widgets/x_logo.dart';
import '../widgets/zenn_logo.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeOffset = useState<Offset?>(null);
    final sagOffset = useState<Offset?>(null);
    final gitHubOffset = useState<Offset?>(null);
    final xOffset = useState<Offset?>(null);
    final zennOffset = useState<Offset?>(null);
    final sizuOffset = useState<Offset?>(null);

    final setRandomOffset = useCallback<VoidCallback>(
      () {
        final maxSize = Size(
          context.mediaSize.width - logoButtonSize,
          context.mediaSize.height - logoButtonSize,
        );
        // Completer でまとめて非同期処理にしたい。
        final themePosition = getOffsetOutsideProfileCard(maxSize);
        themeOffset.value = themePosition;
        final sagPosition = getOffsetOutsideProfileCard(maxSize);
        sagOffset.value = sagPosition;
        final gitHubPosition = getOffsetOutsideProfileCard(maxSize);
        gitHubOffset.value = gitHubPosition;
        final xPosition = getOffsetOutsideProfileCard(maxSize);
        xOffset.value = xPosition;
        final zennPosition = getOffsetOutsideProfileCard(maxSize);
        zennOffset.value = zennPosition;
        final sizuPosition = getOffsetOutsideProfileCard(maxSize);
        sizuOffset.value = sizuPosition;
      },
      [],
    );

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          print('addPostFrameCallback');
          setRandomOffset();
        });
        return null;
      },
      [],
    );

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: ProfileCard(
              key: profileCardKey,
              onTap: () {
                ref.read(themeColorControllerProvider.notifier).change();
                setRandomOffset();
              },
            ),
          ),
          const Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: ThemeToggleButton(),
            ),
          ),
          if (themeOffset.value != null)
            Positioned(
              top: themeOffset.value!.dy,
              left: themeOffset.value!.dx,
              child: const ThemeToggleButton(),
            ),
          if (sagOffset.value != null)
            Positioned(
              top: sagOffset.value!.dy,
              left: sagOffset.value!.dx,
              child: const SaGLogo(),
            ),
          if (gitHubOffset.value != null)
            Positioned(
              top: gitHubOffset.value!.dy,
              left: gitHubOffset.value!.dx,
              child: const GitHubLogo(),
            ),
          if (xOffset.value != null)
            Positioned(
              top: xOffset.value!.dy,
              left: xOffset.value!.dx,
              child: const XLogo(),
            ),
          if (zennOffset.value != null)
            Positioned(
              top: zennOffset.value!.dy,
              left: zennOffset.value!.dx,
              child: const ZennLogo(),
            ),
          if (sizuOffset.value != null)
            Positioned(
              top: sizuOffset.value!.dy,
              left: sizuOffset.value!.dx,
              child: const SizuLogo(),
            ),
        ],
      ),
    );
  }
}
