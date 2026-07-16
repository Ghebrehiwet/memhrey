// lib/models/level_meta.dart
class LevelMeta {
  final int levelNumber;
  final String title;
  final String description;
  final String icon;
  bool isUnlocked;
  bool isCompleted;
  double progressPercent; // 0.0 - 1.0
  int quizScore; // 0-100
  int xpPoints;
  int stars; // 0-3
 
  LevelMeta({
    required this.levelNumber,
    required this.title,
    required this.description,
    required this.icon,
    this.isUnlocked = false,
    this.isCompleted = false,
    this.progressPercent = 0.0,
    this.quizScore = 0,
    this.xpPoints = 0,
    this.stars = 0,
  });
 
  Map<String, dynamic> toJson() => {
        'levelNumber': levelNumber,
        'title': title,
        'description': description,
        'icon': icon,
        'isUnlocked': isUnlocked,
        'isCompleted': isCompleted,
        'progressPercent': progressPercent,
        'quizScore': quizScore,
        'xpPoints': xpPoints,
        'stars': stars,
      };
 
  factory LevelMeta.fromJson(Map<String, dynamic> json) => LevelMeta(
        levelNumber: json['levelNumber'],
        title: json['title'],
        description: json['description'],
        icon: json['icon'],
        isUnlocked: json['isUnlocked'] ?? false,
        isCompleted: json['isCompleted'] ?? false,
        progressPercent: (json['progressPercent'] ?? 0.0).toDouble(),
        quizScore: json['quizScore'] ?? 0,
        xpPoints: json['xpPoints'] ?? 0,
        stars: json['stars'] ?? 0,
      );
 
  LevelMeta copyWith({
    bool? isUnlocked,
    bool? isCompleted,
    double? progressPercent,
    int? quizScore,
    int? xpPoints,
    int? stars,
  }) =>
      LevelMeta(
        levelNumber: levelNumber,
        title: title,
        description: description,
        icon: icon,
        isUnlocked: isUnlocked ?? this.isUnlocked,
        isCompleted: isCompleted ?? this.isCompleted,
        progressPercent: progressPercent ?? this.progressPercent,
        quizScore: quizScore ?? this.quizScore,
        xpPoints: xpPoints ?? this.xpPoints,
        stars: stars ?? this.stars,
      );
}