// lib/models/word.dart
class Word {
  final String id;
  final String tigrigna;
  final String transliteration;
  final String english;
  final String emoji;        // add this
  final String imagePath;    // keep for backwards compat or remove
  final String audioPath;

  const Word({
    required this.id,
    required this.tigrigna,
    required this.transliteration,
    required this.english,
    required this.emoji,
    this.imagePath = '',
    required this.audioPath,
  });
}