import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'meeting_record_bottom_sheet.dart';

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
              ElevatedButton(
                onPressed: () {
                  showMeetingRecordBottomSheet(context: context);
                },
                child: const Text('button'),
              ),
              // const Align(
              //   alignment: Alignment.centerRight,
              //   child: SaGLogo(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

final random = Random();

/// ランダムな座標を返す。
Offset getRandomOffset(Size maxSize) {
  final dx = random.nextDouble() * maxSize.width;
  final dy = random.nextDouble() * maxSize.height;
  return Offset(dx, dy);
}

final profileCardKey = GlobalKey();

/// [ProfileCard] の左上の座標を返す。
Offset getTopLeftOffsetProfileCard() {
  final renderBox = profileCardKey.currentContext?.findRenderObject();
  if (renderBox is! RenderBox) {
    throw Exception('RenderBoxが見つかりませんでした。');
  }
  final offset = renderBox.localToGlobal(Offset.zero);
  return offset;
}

/// [ProfileCard] の外側にあるランダムな座標を返す。
Offset getOffsetOutsideProfileCard(Size maxSize) {
  final renderBox = profileCardKey.currentContext?.findRenderObject();
  if (renderBox is! RenderBox) {
    throw Exception('RenderBoxが見つかりませんでした。');
  }

  final pSize = renderBox.size;
  final pOffset = renderBox.localToGlobal(Offset.zero);

  Offset rOffset;
  var isInside = false;

  do {
    rOffset = getRandomOffset(maxSize);
    if ((pOffset.dx <= rOffset.dx && rOffset.dx <= pOffset.dx + pSize.width) &&
        (pOffset.dy <= rOffset.dy && rOffset.dy <= pOffset.dy + pSize.height)) {
      // ボタンが範囲内にある
      print('ボタンが範囲内にある');
      isInside = true;
    } else {
      // ボタンが範囲内にない
      print('ボタンが範囲内にない');
      isInside = false;
    }
  } while (isInside);

  return rOffset;
}
