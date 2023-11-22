import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'sag_logo.dart';

class ProfileCard extends HookConsumerWidget {
  const ProfileCard({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.all(24),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
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
