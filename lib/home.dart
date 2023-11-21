import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/link.dart';

import 'theme/theme_builder.dart';
import 'theme/theme_color_controller.dart';
import 'theme/theme_toggle_button.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          Center(
            child: ProfileCard(),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: ThemeToggleButton(),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileCard extends HookConsumerWidget {
  const ProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.all(24),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => ref.read(themeColorControllerProvider.notifier).change(),
        child: Container(
          width: 360,
          height: 520,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/profile.png',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const FittedBox(
                child: Text(
                  'Kyohei Nakamura',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              const FittedBox(
                child: Text('Sheep and Goat, LLC'),
              ),
              const Spacer(),
              const Align(
                alignment: Alignment.centerRight,
                child: SaGLogo(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SaGLogo extends HookConsumerWidget {
  const SaGLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Link(
      uri: Uri.parse('https://sheepandgoat.io'),
      target: LinkTarget.blank,
      builder: (context, followLink) => IconButton(
        onPressed: followLink,
        icon: ThemeBuilder(
          builder: (context, brightness) => SvgPicture.asset(
            brightness == Brightness.light
                ? 'assets/images/sag-logo-black.svg'
                : 'assets/images/sag-logo-white.svg',
            height: 24,
          ),
        ),
      ),
    );
  }
}
