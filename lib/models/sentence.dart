// lib/models/sentence.dart
class Sentence {
  final String id;
  final String tigrigna;
  final String transliteration;
  final String english;
  final String emoji;
  final String? imagePath;
  final String audioPath;
  final List<String> words;
 
  const Sentence({
    required this.id,
    required this.tigrigna,
    required this.transliteration,
    required this.english,
    required this.emoji,
    this.imagePath,
    required this.audioPath,
    required this.words,
  });
 
  Map<String, dynamic> toJson() => {
        'id': id,
        'tigrigna': tigrigna,
        'transliteration': transliteration,
        'english': english,
        'emoji': emoji,
        'imagePath': imagePath,
        'audioPath': audioPath,
        'words': words,
      };
 
  factory Sentence.fromJson(Map<String, dynamic> json) => Sentence(
        id: json['id'],
        tigrigna: json['tigrigna'],
        transliteration: json['transliteration'],
        english: json['english'],
        emoji: json['emoji'] ?? '💬',
        imagePath: json['imagePath'],
        audioPath: json['audioPath'],
        words: List<String>.from(json['words']),
      );
}