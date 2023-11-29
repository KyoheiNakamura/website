import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';

class Recorder extends StatefulWidget {
  const Recorder({Key? key, required this.onStop}) : super(key: key);
  final void Function(String path) onStop;

  @override
  State<Recorder> createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  int _recordDuration = 0;
  Timer? _timer;
  late final AudioRecorder _audioRecorder;
  StreamSubscription<RecordState>? _recordSub;
  RecordState _recordState = RecordState.stop;

  @override
  void initState() {
    _audioRecorder = AudioRecorder();
    // NOTE: provider で現在の _audioRecorder を dispose してから 新しい AudioRecorder インスタンスを入れてあげれば良さそう。

    _recordSub = _audioRecorder.onStateChanged().listen(_updateRecordState);

    super.initState();
  }

  Future<void> _start() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        const encoder = AudioEncoder.wav;

        // We don't do anything with this but printing
        final isSupported = await _audioRecorder.isEncoderSupported(
          encoder,
        );

        if (!isSupported) {
          debugPrint('${encoder.name} supported: $isSupported');
        }

        final devs = await _audioRecorder.listInputDevices();
        debugPrint(devs.toString());

        const config = RecordConfig(encoder: encoder);

        // Record to file
        await _audioRecorder.start(config, path: '');

        _recordDuration = 0;

        _startTimer();
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _stop() async {
    final path = await _audioRecorder.stop();
    print('path: $path');

    if (path != null) {
      widget.onStop(path);

      // downloadWebData(path);
    }
  }

  Future<void> _pause() => _audioRecorder.pause();

  Future<void> _resume() => _audioRecorder.resume();

  void _updateRecordState(RecordState recordState) {
    setState(() => _recordState = recordState);

    switch (recordState) {
      case RecordState.pause:
        _timer?.cancel();
        break;
      case RecordState.record:
        _startTimer();
        break;
      case RecordState.stop:
        _timer?.cancel();
        _recordDuration = 0;
        break;
    }
  }

  // void downloadWebData(String path) {
  //   // Simple download code for web testing
  //   final anchor = html.document.createElement('a') as html.AnchorElement
  //     ..href = path
  //     ..style.display = 'none'
  //     ..download = 'audio.wav';
  //   html.document.body!.children.add(anchor);
  //   anchor.click();
  //   html.document.body!.children.remove(anchor);
  //   // html.Url.revokeObjectUrl(path);
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildRecordStopControl(),
                const SizedBox(width: 20),
                _buildPauseResumeControl(),
                const SizedBox(width: 20),
                _buildText(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _recordSub?.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

  Widget _buildRecordStopControl() {
    late Icon icon;
    late Color color;

    if (_recordState != RecordState.stop) {
      icon = const Icon(Icons.stop, color: Colors.red, size: 30);
      color = Colors.red.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = Icon(Icons.mic, color: theme.primaryColor, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 56, height: 56, child: icon),
          onTap: () {
            (_recordState != RecordState.stop) ? _stop() : _start();
          },
        ),
      ),
    );
  }

  Widget _buildPauseResumeControl() {
    if (_recordState == RecordState.stop) {
      return const SizedBox.shrink();
    }

    late Icon icon;
    late Color color;

    if (_recordState == RecordState.record) {
      icon = const Icon(Icons.pause, color: Colors.red, size: 30);
      color = Colors.red.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = const Icon(Icons.play_arrow, color: Colors.red, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 56, height: 56, child: icon),
          onTap: () {
            (_recordState == RecordState.pause) ? _resume() : _pause();
          },
        ),
      ),
    );
  }

  Widget _buildText() {
    if (_recordState != RecordState.stop) {
      return _buildTimer();
    }

    return const Text('Waiting to record');
  }

  Widget _buildTimer() {
    final minutes = _formatNumber(_recordDuration ~/ 60);
    final seconds = _formatNumber(_recordDuration % 60);

    return Text(
      '$minutes : $seconds',
      style: const TextStyle(color: Colors.red),
    );
  }

  String _formatNumber(int number) {
    var numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
    }

    return numberStr;
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });
  }
}
