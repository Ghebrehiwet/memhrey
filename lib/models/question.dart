// lib/models/question.dart
enum QuestionType { multipleChoice, trueOrFalse, fillBlank, listen, ordering, wordMatch, fillBank }

class Question {
  final String id;
  final String prompt;
  final String? audioPath;
  final String? imagePath;   // ← added: shows word/sentence image; emoji in prompt is fallback
  final String? context;     // paragraph title shown as prefix in quiz
  final QuestionType type;
  final List<String> options;
  final String correctAnswer;
  final int level;

  const Question({
    required this.id,
    required this.prompt,
    this.audioPath,
    this.imagePath,
    this.context,
    required this.type,
    required this.options,
    required this.correctAnswer,
    required this.level,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'prompt': prompt,
        'audioPath': audioPath,
        'imagePath': imagePath,
        'context': context,
        'type': type.name,
        'options': options,
        'correctAnswer': correctAnswer,
        'level': level,
      };

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json['id'],
        prompt: json['prompt'],
        audioPath: json['audioPath'],
        imagePath: json['imagePath'],
        context: json['context'],
        type: QuestionType.values.byName(json['type']),
        options: List<String>.from(json['options']),
        correctAnswer: json['correctAnswer'],
        level: json['level'],
      );
}