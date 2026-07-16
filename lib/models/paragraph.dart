// lib/models/paragraph.dart
 
enum ParagraphDifficulty { easy, medium, hard }
 
class Paragraph {
  final String id;
  final String title;
  final String tigrigna;
  final String english;
  final String audioPath;
  final List<String> comprehensionQuestionIds;
  final String? imagePath;
  final ParagraphDifficulty difficulty;
 
  const Paragraph({
    required this.id,
    required this.title,
    required this.tigrigna,
    required this.english,
    required this.audioPath,
    required this.comprehensionQuestionIds,
    required this.difficulty,
    this.imagePath,
  });
}