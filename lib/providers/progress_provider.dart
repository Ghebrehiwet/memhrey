// lib/providers/progress_provider.dart
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/level_meta.dart';
import '../data/words_data.dart';
import '../data/sentences_data.dart';
import '../data/paragraphs_data.dart';
import '../models/paragraph.dart';

class ProgressProvider extends ChangeNotifier {
  static const _keyStudentName = 'student_name';
  static const _keyLevels = 'levels_data';
  static const _keyAlphabetProgress = 'alphabet_progress';
  static const _keyReferenceViewed  = 'reference_viewed';
  static const _keyWordProgress = 'word_progress';
  static const _keyPuzzleProgress = 'puzzle_progress';
  static const _keySentenceProgress = 'sentence_progress';
  static const _keyParagraphProgress = 'paragraph_progress';
  static const _keyTotalXP = 'total_xp';
  static const _keyStreak = 'streak';
  static const _keyLastLogin = 'last_login';
  static const _keyAchievements = 'achievements';

  String _studentName = '';
  List<LevelMeta> _levels = [];
  Map<int, Map<String, bool>> _alphabetSetProgress = {};
  bool _referenceViewed = false;
  Map<String, bool> _wordProgress = {};
  Map<int, int> _puzzleProgress = {};
  Map<String, bool> _sentenceProgress = {};
  Map<String, bool> _paragraphProgress = {};
  int _totalXP = 0;
  int _streak = 0;
  String _lastLogin = '';
  List<String> _achievements = [];

  String get studentName => _studentName;
  List<LevelMeta> get levels => List.unmodifiable(_levels);
  int get totalXP => _totalXP;
  int get streak => _streak;
  List<String> get achievements => _achievements;

  // Safe getters — never crash even if _levels is empty
  LevelMeta get level1 => _levels[0];
  LevelMeta get level2 => _levels[1];
  LevelMeta get level3 => _levels[2];
  LevelMeta get level4 => _levels[3];

  // Alphabet set unlocked if previous set >= 80% complete
  bool isAlphabetSetUnlocked(int setIndex) {
    if (setIndex == 0) return true;
    return getAlphabetSetProgress(setIndex - 1) >= 0.8;
  }

  double getAlphabetSetProgress(int setIndex) {
    const activities = ['audio', 'sequencing', 'tracing', 'matching', 'game', 'combo'];
    final set = _alphabetSetProgress[setIndex] ?? {};
    int done = activities.where((a) => set[a] == true).length;
    return done / activities.length;
  }

  bool isAlphabetActivityDone(int setIndex, String activity) {
    return _alphabetSetProgress[setIndex]?[activity] ?? false;
  }

  Future<void> markAlphabetActivity(int setIndex, String activity) async {
    _alphabetSetProgress[setIndex] ??= {};
    _alphabetSetProgress[setIndex]![activity] = true;
    _addXP(10);
    await _saveAlphabetProgress();
    _updateLevel1Progress();
    notifyListeners();
  }

  void _updateLevel1Progress() {
    if (_levels.isEmpty) return;
    const activities = ['audio', 'sequencing', 'tracing', 'matching', 'game', 'combo'];
    const int setScount = 32;
    int total = setScount * activities.length + 1;
    int done = 0;
    for (int i = 0; i < setScount; i++) {
      for (final a in activities) {
        if (_alphabetSetProgress[i]?[a] == true) done++;
      }
    }
    if (_referenceViewed) done++;
    _levels[0].progressPercent = done / total;
  }

  bool get canTakeLevel1Quiz => (level1?.progressPercent ?? 0) >= 0.8;
  bool get referenceViewed => _referenceViewed;

  Future<void> markReferenceViewed() async {
    if (_referenceViewed) return;
    _referenceViewed = true;
    _addXP(20);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyReferenceViewed, true);
    notifyListeners();
  }

  Future<void> submitLevel1Quiz(int score) async {
    if (_levels.isEmpty) return;
    _levels[0].quizScore = score;
    _levels[0].stars = _starsFromScore(score);
    if (score >= 80) {
      _levels[0].isCompleted = true;
      if (_levels.length > 1) _levels[1].isUnlocked = true;
      _addXP(200);
      _unlockAchievement('level1_complete');
    }
    await _saveLevels();
    notifyListeners();
  }

  // Word progress
  double get wordLevelProgress {
    if (wordsData.isEmpty) return 0;
    int done = _wordProgress.values.where((v) => v).length;
    return done / wordsData.length;
  }

  bool get canTakeLevel2Quiz {
    int qualifiedPuzzles = 0;
    for (int i = 0; i < 20; i++) {
      final found = _puzzleProgress[i] ?? 0;
      if (found >= 3) qualifiedPuzzles++;
    }
    return qualifiedPuzzles >= 10;
  }

  int getPuzzleFoundCount(int puzzleIndex) => _puzzleProgress[puzzleIndex] ?? 0;

  Future<void> markPuzzleWordFound(int puzzleIndex, String wordId) async {
    if (_levels.length < 2) return;
    _wordProgress[wordId] = true;
    _levels[1].progressPercent = wordLevelProgress;
    _addXP(5);
    final current = _puzzleProgress[puzzleIndex] ?? 0;
    if (current < 5) _puzzleProgress[puzzleIndex] = current + 1;
    await _saveWordProgress();
    await _savePuzzleProgress();
    notifyListeners();
  }

  bool isWordDone(String wordId) => _wordProgress[wordId] == true;

  Future<void> markWordDone(String wordId) async {
    if (_levels.length < 2) return;
    _wordProgress[wordId] = true;
    _levels[1].progressPercent = wordLevelProgress;
    _addXP(5);
    await _saveWordProgress();
    notifyListeners();
  }

  Future<void> submitLevel2Quiz(int score) async {
    if (_levels.length < 2) return;
    _levels[1].quizScore = score;
    _levels[1].stars = _starsFromScore(score);
    if (score >= 80) {
      _levels[1].isCompleted = true;
      if (_levels.length > 2) _levels[2].isUnlocked = true;
      _addXP(300);
      _unlockAchievement('level2_complete');
    }
    await _saveLevels();
    notifyListeners();
  }

  // Sentence progress
  double get sentenceLevelProgress {
    if (sentencesData.isEmpty) return 0;
    int done = _sentenceProgress.values.where((v) => v).length;
    return done / sentencesData.length;
  }

  bool get canTakeLevel3Quiz => sentenceLevelProgress >= 0.8;
  bool get canPlayListeningChallenge => sentenceLevelProgress >= 0.8;
  bool isSentenceDone(String sentenceId) => _sentenceProgress[sentenceId] == true;

  Future<void> markSentenceDone(String sentenceId) async {
    if (_levels.length < 3) return;
    _sentenceProgress[sentenceId] = true;
    _levels[2].progressPercent = sentenceLevelProgress;
    _addXP(8);
    await _saveSentenceProgress();
    notifyListeners();
  }

  Future<void> submitLevel3Quiz(int score) async {
    if (_levels.length < 3) return;
    _levels[2].quizScore = score;
    _levels[2].stars = _starsFromScore(score);
    if (score >= 80) {
      _levels[2].isCompleted = true;
      if (_levels.length > 3) _levels[3].isUnlocked = true;
      _addXP(400);
      _unlockAchievement('level3_complete');
    }
    await _saveLevels();
    notifyListeners();
  }

  // Paragraph progress
  double get paragraphLevelProgress {
    if (paragraphsData.isEmpty) return 0;
    int done = _paragraphProgress.values.where((v) => v).length;
    return done / paragraphsData.length;
  }

  double _difficultyProgress(ParagraphDifficulty diff) {
    final group = paragraphsData.where((p) => p.difficulty == diff).toList();
    if (group.isEmpty) return 1.0;
    final done = group.where((p) => _paragraphProgress[p.id] == true).length;
    return done / group.length;
  }

  double get easyProgress   => _difficultyProgress(ParagraphDifficulty.easy);
  double get mediumProgress => _difficultyProgress(ParagraphDifficulty.medium);
  double get hardProgress   => _difficultyProgress(ParagraphDifficulty.hard);

  bool get mediumUnlocked  => easyProgress >= 0.8;
  bool get hardUnlocked    => mediumUnlocked && mediumProgress >= 0.8;
  bool get canTakeLevel4Quiz => hardUnlocked && hardProgress >= 0.8;

  bool isParagraphDone(String paraId) => _paragraphProgress[paraId] == true;

  bool isParagraphUnlocked(Paragraph p) {
    switch (p.difficulty) {
      case ParagraphDifficulty.easy:   return true;
      case ParagraphDifficulty.medium: return mediumUnlocked;
      case ParagraphDifficulty.hard:   return hardUnlocked;
    }
  }

  Future<void> markParagraphDone(String paragraphId) async {
    if (_levels.length < 4) return;
    _paragraphProgress[paragraphId] = true;
    _levels[3].progressPercent = paragraphLevelProgress;
    _addXP(15);
    await _saveParagraphProgress();
    notifyListeners();
  }

  Future<void> submitLevel4Quiz(int score) async {
    if (_levels.length < 4) return;
    _levels[3].quizScore = score;
    _levels[3].stars = _starsFromScore(score);
    if (score >= 80) {
      _levels[3].isCompleted = true;
      _addXP(500);
      _unlockAchievement('all_levels_complete');
    }
    await _saveLevels();
    notifyListeners();
  }

  int _starsFromScore(int score) {
    if (score >= 95) return 3;
    if (score >= 80) return 2;
    if (score >= 60) return 1;
    return 0;
  }

  void _addXP(int amount) {
    _totalXP += amount;
    _checkXPAchievements();
  }

  void _checkXPAchievements() {
    if (_totalXP >= 100) _unlockAchievement('xp_100');
    if (_totalXP >= 500) _unlockAchievement('xp_500');
    if (_totalXP >= 1000) _unlockAchievement('xp_1000');
  }

  void _unlockAchievement(String id) {
    if (!_achievements.contains(id)) {
      _achievements.add(id);
      _saveAchievements();
    }
  }

  Future<void> setStudentName(String name) async {
    _studentName = name;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyStudentName, name);
    notifyListeners();
  }

  Future<void> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _studentName = prefs.getString(_keyStudentName) ?? '';
      _totalXP = prefs.getInt(_keyTotalXP) ?? 0;
      _streak = prefs.getInt(_keyStreak) ?? 0;
      _lastLogin = prefs.getString(_keyLastLogin) ?? '';
      final achievementsStr = prefs.getString(_keyAchievements);
      if (achievementsStr != null) {
        _achievements = List<String>.from(jsonDecode(achievementsStr));
      }
      await _loadLevels(prefs);
      await _loadAlphabetProgress(prefs);
      _referenceViewed = prefs.getBool(_keyReferenceViewed) ?? false;
      await _loadWordProgress(prefs);
      final puzzleStr = prefs.getString(_keyPuzzleProgress);
      if (puzzleStr != null) {
        _puzzleProgress = (jsonDecode(puzzleStr) as Map<String, dynamic>)
            .map((k, v) => MapEntry(int.parse(k), v as int));
      }
      await _loadSentenceProgress(prefs);
      await _loadParagraphProgress(prefs);
      _updateStreak(prefs);
    } catch (e) {
      // If anything fails during load, ensure levels are always populated
      if (_levels.isEmpty) {
        _levels = _defaultLevels();
      }
      debugPrint('ProgressProvider.init() error: $e');
    }
    notifyListeners();
  }

  void _updateStreak(SharedPreferences prefs) {
    final today = DateTime.now().toIso8601String().substring(0, 10);
    if (_lastLogin != today) {
      final yesterday = DateTime.now()
          .subtract(const Duration(days: 1))
          .toIso8601String()
          .substring(0, 10);
      if (_lastLogin == yesterday) {
        _streak++;
      } else {
        _streak = 1;
      }
      _lastLogin = today;
      prefs.setString(_keyLastLogin, today);
      prefs.setInt(_keyStreak, _streak);
    }
  }

  Future<void> _loadLevels(SharedPreferences prefs) async {
    try {
      final str = prefs.getString(_keyLevels);
      if (str != null) {
        final List<dynamic> list = jsonDecode(str);
        final loaded = list.map((e) => LevelMeta.fromJson(e)).toList();
        // Safety: only use loaded levels if we got all 4
        if (loaded.length == 4) {
          _levels = loaded;
        } else {
          _levels = _defaultLevels();
        }
      } else {
        _levels = _defaultLevels();
      }
    } catch (e) {
      _levels = _defaultLevels();
      debugPrint('_loadLevels error: $e');
    }
  }

  List<LevelMeta> _defaultLevels() => [
        LevelMeta(
          levelNumber: 1,
          title: 'ፊደላት',
          description: 'ፊደላት - Alphabet - Learn all 32 sets of Tigrigna alphabets',
          icon: '🔤',
          isUnlocked: true,
        ),
        LevelMeta(
          levelNumber: 2,
          title: 'ቃላት',
          description: 'ቃላት - Words - Build vocabulary with 500 words',
          icon: '📝',
          isUnlocked: false,
        ),
        LevelMeta(
          levelNumber: 3,
          title: 'ምሉእ ሓሳባት',
          description: 'ምሉእ ሓሳባት - Sentences - Practice 300 sentences',
          icon: '💬',
          isUnlocked: false,
        ),
        LevelMeta(
          levelNumber: 4,
          title: 'ሕጡበ ጽሑፋት',
          description: 'ሕጡበ ጽሑፋት - Paragraphs - Read and comprehend 50 paragraphs',
          icon: '📖',
          isUnlocked: false,
        ),
      ];

  Future<void> _loadAlphabetProgress(SharedPreferences prefs) async {
    try {
      final str = prefs.getString(_keyAlphabetProgress);
      if (str != null) {
        final Map<String, dynamic> map = jsonDecode(str);
        _alphabetSetProgress = map.map((k, v) => MapEntry(
              int.parse(k),
              Map<String, bool>.from(v),
            ));
      }
    } catch (e) {
      _alphabetSetProgress = {};
      debugPrint('_loadAlphabetProgress error: $e');
    }
  }

  Future<void> _loadWordProgress(SharedPreferences prefs) async {
    try {
      final str = prefs.getString(_keyWordProgress);
      if (str != null) {
        _wordProgress = Map<String, bool>.from(jsonDecode(str));
      }
    } catch (e) {
      _wordProgress = {};
      debugPrint('_loadWordProgress error: $e');
    }
  }

  Future<void> _loadSentenceProgress(SharedPreferences prefs) async {
    try {
      final str = prefs.getString(_keySentenceProgress);
      if (str != null) {
        _sentenceProgress = Map<String, bool>.from(jsonDecode(str));
      }
    } catch (e) {
      _sentenceProgress = {};
      debugPrint('_loadSentenceProgress error: $e');
    }
  }

  Future<void> _loadParagraphProgress(SharedPreferences prefs) async {
    try {
      final str = prefs.getString(_keyParagraphProgress);
      if (str != null) {
        _paragraphProgress = Map<String, bool>.from(jsonDecode(str));
      }
    } catch (e) {
      _paragraphProgress = {};
      debugPrint('_loadParagraphProgress error: $e');
    }
  }

  Future<void> _saveLevels() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLevels,
        jsonEncode(_levels.map((l) => l.toJson()).toList()));
  }

  Future<void> _saveAlphabetProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final map = _alphabetSetProgress.map((k, v) => MapEntry(k.toString(), v));
    await prefs.setString(_keyAlphabetProgress, jsonEncode(map));
  }

  Future<void> _saveWordProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyWordProgress, jsonEncode(_wordProgress));
  }

  Future<void> _savePuzzleProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final map = _puzzleProgress.map((k, v) => MapEntry(k.toString(), v));
    await prefs.setString(_keyPuzzleProgress, jsonEncode(map));
  }

  Future<void> _saveSentenceProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keySentenceProgress, jsonEncode(_sentenceProgress));
  }

  Future<void> _saveParagraphProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyParagraphProgress, jsonEncode(_paragraphProgress));
  }

  Future<void> _saveAchievements() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAchievements, jsonEncode(_achievements));
  }

  Future<void> resetAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _studentName = '';
    _levels = _defaultLevels();
    _alphabetSetProgress = {};
    _referenceViewed = false;
    _wordProgress = {};
    _puzzleProgress = {};
    _sentenceProgress = {};
    _paragraphProgress = {};
    _totalXP = 0;
    _streak = 0;
    _achievements = [];
    notifyListeners();
  }
}