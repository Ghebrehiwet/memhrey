// lib/widgets/audio_btn.dart
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioBtn extends StatefulWidget {
  final String? audioPath;
  final String? ttsText; // kept for API compatibility but no longer used
  final double size;
  final Color? color;

  const AudioBtn({
    super.key,
    this.audioPath,
    this.ttsText,
    this.size = 48,
    this.color,
  });

  @override
  State<AudioBtn> createState() => _AudioBtnState();
}

class _AudioBtnState extends State<AudioBtn> {
  bool _isPlaying = false;
  AudioPlayer? _player;

  @override
  void dispose() {
    _player?.dispose();
    super.dispose();
  }

  Future<void> _play() async {
    debugPrint('=== AudioBtn._play() called! path=${widget.audioPath}');
    // Tap while playing = stop
    if (_isPlaying) {
      await _player?.stop();
      _player?.dispose();
      _player = null;
      if (mounted) setState(() => _isPlaying = false);
      return;
    }

    if (widget.audioPath == null || widget.audioPath!.isEmpty) return; 

    final assetPath = widget.audioPath!.replaceFirst('assets/', '');
    debugPrint('=== AudioBtn raw: "${widget.audioPath}"');
    debugPrint('=== AudioBtn stripped: "$assetPath"');

    setState(() => _isPlaying = true);

    try {
      _player?.dispose();
      _player = AudioPlayer();

      _player!.onPlayerComplete.listen((_) {
        if (mounted) setState(() => _isPlaying = false);
        _player?.dispose();
        _player = null;
      });

      await _player!.play(AssetSource(assetPath));

      // Safety: reset after 6s if completion never fires
      Future.delayed(const Duration(seconds: 6), () {
        if (mounted && _isPlaying) setState(() => _isPlaying = false);
      });

    } catch (e) {
      debugPrint('AudioBtn ERROR: $e');
      if (mounted) setState(() => _isPlaying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? const Color(0xFF5C6BC0); 
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _play,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: _isPlaying ? color : color.withOpacity(0.12),
          shape: BoxShape.circle,
          border: Border.all(color: color, width: 2),
        ),
        child: Icon(
          _isPlaying ? Icons.volume_up : Icons.play_arrow,
          color: _isPlaying ? Colors.white : color,
          size: widget.size * 0.55,
        ),
      ),
    );
  }
}
