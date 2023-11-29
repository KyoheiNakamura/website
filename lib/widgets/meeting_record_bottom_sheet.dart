import 'dart:html' as html;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'audio_player.dart';
import 'audio_recorder.dart';

/// 担当者会議を録音するための全画面ダイアログを表示する。
void showMeetingRecordBottomSheet({
  required BuildContext context,
}) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    constraints: const BoxConstraints.expand(),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (builder) {
      return const MeetingRecordBottomSheet();
    },
  );
}

class MeetingRecordBottomSheet extends HookConsumerWidget {
  const MeetingRecordBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final isRecording = useState(false);
    final showPlayer = useState(false);
    final audioPath = useState<String?>(null);
    final onPressedUploadRecord = useCallback<Future<void> Function()>(
      () async {
        Navigator.pop(context);
      },
      [],
    );

    // TODO: アプリを閉じない限りは録音を続けたいので、トップレベルの方で録音の状態を監視しとく。

    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: CloseButton(),
            ),
            const SizedBox(height: 8),
            const Text(
              '担当者会議を録音すると、AIが会議の内容を自動で入力してくれます。',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '・AIによる読み取りには間違いが含まれる可能性がございます。読み取り結果の整合性を必ずご確認ください。',
              style: TextStyle(color: Colors.grey),
            ),
            Expanded(
              child: SizedBox.expand(
                child: showPlayer.value
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: AudioPlayer(
                          source: audioPath.value!,
                          onDelete: () {
                            // TODO: html.Url.revokeObjectUrl(path); も実行したい
                            showPlayer.value = false;
                            html.Url.revokeObjectUrl(audioPath.value!);
                          },
                        ),
                      )
                    : Recorder(
                        onStop: (path) {
                          if (kDebugMode) print('Recorded file path: $path');
                          audioPath.value = path;
                          showPlayer.value = true;
                        },
                      ),
                // child: Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     IconButton(
                //       iconSize: context.mediaWidth * .2,
                //       onPressed: () {
                //         isRecording.value = !isRecording.value;
                //       },
                //       icon: Icon(
                //         isRecording.value ? Icons.stop_circle : Icons.radio_button_checked_outlined,
                //         color: isRecording.value ? Colors.red : null,
                //       ),
                //     ),
                //     Text(
                //       isRecording.value ? '停止' : '録音',
                //       style: const TextStyle(
                //         fontSize: 20,
                //       ),
                //     ),
                //   ],
                // ),
              ),
            ),
            const Divider(),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onPressedUploadRecord,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                textStyle: const TextStyle(
                  fontSize: 20,
                  height: 56 / 20,
                ),
              ),
              icon: const Icon(Icons.upload_file),
              label: const Text('録音をアップロードする'),
            ),
            const SizedBox(height: 8),
            const Text(
              '・録音の解析には30秒ほど時間がかかります。\n'
              '・録音の解析が完了すると、通知が届きます(としたい)。\n'
              '・アプリを閉じても解析は続きます。',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
