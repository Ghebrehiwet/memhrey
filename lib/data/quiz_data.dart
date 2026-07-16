// lib/data/quiz_data.dart
import '../models/question.dart';
 
// lib/data/quiz_data.dart  — Level 1 only
// Correct answer positions randomized (seed=7)
// Part A distribution: {pos0:14, pos1:11, pos2:13, pos3:12}
// Part B distribution: {pos0:9,  pos1:15, pos2:12, pos3:14}

final List<Question> level1QuizData = [

  // ══════════════════════════════════════════════════════════════════════════
  // PART A — audio → correct letter  (q1_001 – q1_050)
  // ══════════════════════════════════════════════════════════════════════════

  // ── ሀ family ─────────────────────────────────────────────────────────────
  Question(
    id: 'q1_001',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ነ', 'ለ', 'ሀ', 'ሐ'],
    correctAnswer: 'ሀ',
    level: 1,
    audioPath: 'assets/audio/alphabets/he.mp3',
  ),

  Question(
    id: 'q1_002',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ሉ', 'ሑ', 'ኑ', 'ሁ'],
    correctAnswer: 'ሁ',
    level: 1,
    audioPath: 'assets/audio/alphabets/hu.mp3',
  ),

  Question(
    id: 'q1_003',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ሊ', 'ሂ', 'ኒ', 'ሒ'],
    correctAnswer: 'ሂ',
    level: 1,
    audioPath: 'assets/audio/alphabets/hi.mp3',
  ),

  Question(
    id: 'q1_004',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ና', 'ሓ', 'ሃ', 'ላ'],
    correctAnswer: 'ሃ',
    level: 1,
    audioPath: 'assets/audio/alphabets/ha.mp3',
  ),

  // ── ለ family ─────────────────────────────────────────────────────────────
  Question(
    id: 'q1_005',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ነ', 'ለ', 'ሀ', 'ሐ'],
    correctAnswer: 'ለ',
    level: 1,
    audioPath: 'assets/audio/alphabets/le.mp3',
  ),

  Question(
    id: 'q1_006',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ሑ', 'ኩ', 'ሉ', 'ሁ'],
    correctAnswer: 'ሉ',
    level: 1,
    audioPath: 'assets/audio/alphabets/lu.mp3',
  ),

  Question(
    id: 'q1_007',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ሂ', 'ዊ', 'ሒ', 'ሊ'],
    correctAnswer: 'ሊ',
    level: 1,
    audioPath: 'assets/audio/alphabets/li.mp3',
  ),

  Question(
    id: 'q1_008',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ዋ', 'ላ', 'ና', 'ሃ'],
    correctAnswer: 'ላ',
    level: 1,
    audioPath: 'assets/audio/alphabets/la.mp3',
  ),

  // ── መ family ─────────────────────────────────────────────────────────────
  Question(
    id: 'q1_009',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ነ', 'ሐ', 'መ', 'ሸ'],
    correctAnswer: 'መ',
    level: 1,
    audioPath: 'assets/audio/alphabets/me.mp3',
  ),

  Question(
    id: 'q1_010',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ሁ', 'ኑ', 'ሱ', 'ሙ'],
    correctAnswer: 'ሙ',
    level: 1,
    audioPath: 'assets/audio/alphabets/mu.mp3',
  ),

  Question(
    id: 'q1_011',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ዛ', 'ማ', 'ሃ', 'ና'],
    correctAnswer: 'ማ',
    level: 1,
    audioPath: 'assets/audio/alphabets/ma.mp3',
  ),

  // ── ሰ family ─────────────────────────────────────────────────────────────
  Question(
    id: 'q1_012',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ጸ', 'ሸ', 'ዘ', 'ሰ'],
    correctAnswer: 'ሰ',
    level: 1,
    audioPath: 'assets/audio/alphabets/se.mp3',
  ),

  Question(
    id: 'q1_013',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ጻ', 'ዛ', 'ሳ', 'ሻ'],
    correctAnswer: 'ሳ',
    level: 1,
    audioPath: 'assets/audio/alphabets/sa.mp3',
  ),

  Question(
    id: 'q1_014',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ሽ', 'ጽ', 'ስ', 'ዝ'],
    correctAnswer: 'ስ',
    level: 1,
    audioPath: 'assets/audio/alphabets/s.mp3',
  ),

  // ── ሸ family ─────────────────────────────────────────────────────────────
  Question(
    id: 'q1_015',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ሰ', 'ጸ', 'ቸ', 'ሸ'],
    correctAnswer: 'ሸ',
    level: 1,
    audioPath: 'assets/audio/alphabets/she.mp3',
  ),

  Question(
    id: 'q1_016',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ሻ', 'ሳ', 'ቻ', 'ጻ'],
    correctAnswer: 'ሻ',
    level: 1,
    audioPath: 'assets/audio/alphabets/sha.mp3',
  ),

  Question(
    id: 'q1_017',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ሽ', 'ሾ', 'ሺ', 'ሼ'],
    correctAnswer: 'ሽ',
    level: 1,
    audioPath: 'assets/audio/alphabets/sh.mp3',
  ),

  // ── ቀ family ─────────────────────────────────────────────────────────────
  Question(
    id: 'q1_018',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ገ', 'ቀ', 'ቐ', 'ከ'],
    correctAnswer: 'ቀ',
    level: 1,
    audioPath: 'assets/audio/alphabets/qe.mp3',
  ),

  Question(
    id: 'q1_019',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ቓ', 'ቃ', 'ጋ', 'ካ'],
    correctAnswer: 'ቃ',
    level: 1,
    audioPath: 'assets/audio/alphabets/qa.mp3',
  ),

  Question(
    id: 'q1_020',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ቕ', 'ክ', 'ጽ', 'ቅ'],
    correctAnswer: 'ቅ',
    level: 1,
    audioPath: 'assets/audio/alphabets/q.mp3',
  ),

  // ── በ family ─────────────────────────────────────────────────────────────
  Question(
    id: 'q1_021',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['በ', 'ፈ', 'ተ', 'ደ'],
    correctAnswer: 'በ',
    level: 1,
    audioPath: 'assets/audio/alphabets/be.mp3',
  ),

  Question(
    id: 'q1_022',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ቱ', 'ቡ', 'ዱ', 'ፉ'],
    correctAnswer: 'ቡ',
    level: 1,
    audioPath: 'assets/audio/alphabets/bu.mp3',
  ),

  Question(
    id: 'q1_023',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ጌ', 'ቴ', 'ፌ', 'ቤ'],
    correctAnswer: 'ቤ',
    level: 1,
    audioPath: 'assets/audio/alphabets/bie2.mp3',
  ),

  // ── ተ family ─────────────────────────────────────────────────────────────
  Question(
    id: 'q1_024',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ደ', 'ተ', 'ጠ', 'በ'],
    correctAnswer: 'ተ',
    level: 1,
    audioPath: 'assets/audio/alphabets/te.mp3',
  ),

  Question(
    id: 'q1_025',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ዳ', 'ታ', 'ባ', 'ጣ'],
    correctAnswer: 'ታ',
    level: 1,
    audioPath: 'assets/audio/alphabets/ta.mp3',
  ),

  Question(
    id: 'q1_026',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ጥ', 'ብ', 'ድ', 'ት'],
    correctAnswer: 'ት',
    level: 1,
    audioPath: 'assets/audio/alphabets/t.mp3',
  ),

  // ── ነ family ─────────────────────────────────────────────────────────────
  Question(
    id: 'q1_027',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ነ', 'መ', 'ሸ', 'ሐ'],
    correctAnswer: 'ነ',
    level: 1,
    audioPath: 'assets/audio/alphabets/ne.mp3',
  ),

  Question(
    id: 'q1_028',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ና', 'ማ', 'ሃ', 'ዛ'],
    correctAnswer: 'ና',
    level: 1,
    audioPath: 'assets/audio/alphabets/na.mp3',
  ),

  Question(
    id: 'q1_029',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ህ', 'ም', 'ዝ', 'ን'],
    correctAnswer: 'ን',
    level: 1,
    audioPath: 'assets/audio/alphabets/n.mp3',
  ),

  // ── ዘ family ─────────────────────────────────────────────────────────────
  Question(
    id: 'q1_030',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ሰ', 'ዘ', 'ዠ', 'ጸ'],
    correctAnswer: 'ዘ',
    level: 1,
    audioPath: 'assets/audio/alphabets/ze.mp3',
  ),

  Question(
    id: 'q1_031',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ጻ', 'ሳ', 'ዣ', 'ዛ'],
    correctAnswer: 'ዛ',
    level: 1,
    audioPath: 'assets/audio/alphabets/za.mp3',
  ),

  Question(
    id: 'q1_032',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ዝ', 'ዥ', 'ስ', 'ጽ'],
    correctAnswer: 'ዝ',
    level: 1,
    audioPath: 'assets/audio/alphabets/z.mp3',
  ),

  // ── የ family ─────────────────────────────────────────────────────────────
  Question(
    id: 'q1_033',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ደ', 'ወ', 'የ', 'ከ'],
    correctAnswer: 'የ',
    level: 1,
    audioPath: 'assets/audio/alphabets/ye.mp3',
  ),

  Question(
    id: 'q1_034',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ዋ', 'ዳ', 'ያ', 'ካ'],
    correctAnswer: 'ያ',
    level: 1,
    audioPath: 'assets/audio/alphabets/ya.mp3',
  ),

  // ── ደ family ─────────────────────────────────────────────────────────────
  Question(
    id: 'q1_035',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ዘ', 'ጀ', 'ደ', 'ገ'],
    correctAnswer: 'ደ',
    level: 1,
    audioPath: 'assets/audio/alphabets/de.mp3',
  ),

  Question(
    id: 'q1_036',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ዛ', 'ጋ', 'ዳ', 'ጃ'],
    correctAnswer: 'ዳ',
    level: 1,
    audioPath: 'assets/audio/alphabets/da.mp3',
  ),

  Question(
    id: 'q1_037',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ድ', 'ጅ', 'ዝ', 'ግ'],
    correctAnswer: 'ድ',
    level: 1,
    audioPath: 'assets/audio/alphabets/d.mp3',
  ),

  // ── ገ family ─────────────────────────────────────────────────────────────
  Question(
    id: 'q1_038',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ጀ', 'ከ', 'ደ', 'ገ'],
    correctAnswer: 'ገ',
    level: 1,
    audioPath: 'assets/audio/alphabets/ge.mp3',
  ),

  Question(
    id: 'q1_039',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ጋ', 'ካ', 'ጃ', 'ዳ'],
    correctAnswer: 'ጋ',
    level: 1,
    audioPath: 'assets/audio/alphabets/ga.mp3',
  ),

  // ── ከ family ─────────────────────────────────────────────────────────────
  Question(
    id: 'q1_040',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ከ', 'ገ', 'ኸ', 'ቀ'],
    correctAnswer: 'ከ',
    level: 1,
    audioPath: 'assets/audio/alphabets/ke.mp3',
  ),

  Question(
    id: 'q1_041',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ካ', 'ጋ', 'ቃ', 'ዛ'],
    correctAnswer: 'ካ',
    level: 1,
    audioPath: 'assets/audio/alphabets/ka.mp3',
  ),

  Question(
    id: 'q1_042',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ዝ', 'ግ', 'ክ', 'ቅ'],
    correctAnswer: 'ክ',
    level: 1,
    audioPath: 'assets/audio/alphabets/k.mp3',
  ),

  // ── ፈ family ─────────────────────────────────────────────────────────────
  Question(
    id: 'q1_043',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ደ', 'ፐ', 'ፈ', 'በ'],
    correctAnswer: 'ፈ',
    level: 1,
    audioPath: 'assets/audio/alphabets/fe.mp3',
  ),

  Question(
    id: 'q1_044',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ፓ', 'ዳ', 'ፋ', 'ባ'],
    correctAnswer: 'ፋ',
    level: 1,
    audioPath: 'assets/audio/alphabets/fa.mp3',
  ),

  Question(
    id: 'q1_045',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ፍ', 'ፕ', 'ድ', 'ብ'],
    correctAnswer: 'ፍ',
    level: 1,
    audioPath: 'assets/audio/alphabets/f.mp3',
  ),

  // ── ጸ / ጠ / ጨ families ───────────────────────────────────────────────────
  Question(
    id: 'q1_046',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ጨ', 'ጠ', 'ሰ', 'ጸ'],
    correctAnswer: 'ጸ',
    level: 1,
    audioPath: 'assets/audio/alphabets/tse.mp3',
  ),

  Question(
    id: 'q1_047',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ጣ', 'ጫ', 'ሳ', 'ጻ'],
    correctAnswer: 'ጣ',
    level: 1,
    audioPath: 'assets/audio/alphabets/t-a.mp3',
  ),

  Question(
    id: 'q1_048',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ቻ', 'ጫ', 'ጻ', 'ጣ'],
    correctAnswer: 'ጫ',
    level: 1,
    audioPath: 'assets/audio/alphabets/c-a.mp3',
  ),

  // ── ወ / ዓ families ────────────────────────────────────────────────────────
  Question(
    id: 'q1_049',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ወ', 'የ', 'ዐ', 'ዘ'],
    correctAnswer: 'ወ',
    level: 1,
    audioPath: 'assets/audio/alphabets/we.mp3',
  ),

  Question(
    id: 'q1_050',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ፊደል ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ዓ', 'ያ', 'ዋ', 'ዛ'],
    correctAnswer: 'ዓ',
    level: 1,
    audioPath: 'assets/audio/alphabets/aa2.mp3',
  ),

  // ══════════════════════════════════════════════════════════════════════════
  // PART B — fill the blank in the vowel-order sequence (q1_051 – q1_100)
  // ══════════════════════════════════════════════════════════════════════════

  // ── ሀ family ──────────────────────────────────────────────────────────────
  Question(
    id: 'q1_051',
    prompt: '\nሀ  ___  ሂ  ሃ  ሄ  ህ  ሆ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ኑ', 'ሑ', 'ሉ', 'ሁ'],
    correctAnswer: 'ሁ',
    level: 1,
  ),

  Question(
    id: 'q1_052',
    prompt: '\nሀ  ሁ  ሂ  ሃ  ___  ህ  ሆ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ቤ', 'ሌ', 'ሬ', 'ሄ'],
    correctAnswer: 'ሄ',
    level: 1,
  ),

  Question(
    id: 'q1_053',
    prompt: '\nሀ  ሁ  ሂ  ሃ  ሄ  ህ  ___\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ሞ', 'ሆ', 'ሶ', 'ሎ'],
    correctAnswer: 'ሆ',
    level: 1,
  ),

  // ── ለ family ──────────────────────────────────────────────────────────────
  Question(
    id: 'q1_054',
    prompt: '\n___  ሉ  ሊ  ላ  ሌ  ል  ሎ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ሐ', 'ነ', 'ሀ', 'ለ'],
    correctAnswer: 'ለ',
    level: 1,
  ),

  Question(
    id: 'q1_055',
    prompt: '\nለ  ሉ  ሊ  ___  ሌ  ል  ሎ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ሳ', 'ማ', 'ዛ', 'ላ'],
    correctAnswer: 'ላ',
    level: 1,
  ),

  // ── ሐ family ──────────────────────────────────────────────────────────────
  Question(
    id: 'q1_056',
    prompt: '\nሐ  ሑ  ___  ሓ  ሔ  ሕ  ሖ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ሊ', 'ሺ', 'ሂ', 'ሒ'],
    correctAnswer: 'ሒ',
    level: 1,
  ),

  Question(
    id: 'q1_057',
    prompt: '\nሐ  ሑ  ሒ  ሓ  ሔ  ___  ሖ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ሽ', 'ህ', 'ዕ', 'ሕ'],
    correctAnswer: 'ሕ',
    level: 1,
  ),

  // ── መ family ──────────────────────────────────────────────────────────────
  Question(
    id: 'q1_058',
    prompt: '\nመ  ___  ሚ  ማ  ሜ  ም  ሞ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ሙ', 'ኑ', 'ሱ', 'ሁ'],
    correctAnswer: 'ሙ',
    level: 1,
  ),

  Question(
    id: 'q1_059',
    prompt: '\nመ  ሙ  ሚ  ማ  ሜ  ም  ___\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ሞ', 'ሶ', 'ሎ', 'ነ'],
    correctAnswer: 'ሞ',
    level: 1,
  ),

  // ── ሰ family ──────────────────────────────────────────────────────────────
  Question(
    id: 'q1_060',
    prompt: '\n___  ሱ  ሲ  ሳ  ሴ  ስ  ሶ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ሸ', 'ዘ', 'ሰ', 'ጸ'],
    correctAnswer: 'ሰ',
    level: 1,
  ),

  Question(
    id: 'q1_061',
    prompt: '\nሰ  ሱ  ሲ  ___  ሴ  ስ  ሶ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ሳ', 'ዛ', 'ሻ', 'ጻ'],
    correctAnswer: 'ሳ',
    level: 1,
  ),

  // ── ሸ family ──────────────────────────────────────────────────────────────
  Question(
    id: 'q1_062',
    prompt: '\nሸ  ___  ሺ  ሻ  ሼ  ሽ  ሾ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ቹ', 'ሹ', 'ሱ', 'ጹ'],
    correctAnswer: 'ሹ',
    level: 1,
  ),

  Question(
    id: 'q1_063',
    prompt: '\nሸ  ሹ  ሺ  ሻ  ___  ሽ  ሾ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ቼ', 'ጼ', 'ሼ', 'ሌ'],
    correctAnswer: 'ሼ',
    level: 1,
  ),

  // ── ቀ family ──────────────────────────────────────────────────────────────
  Question(
    id: 'q1_064',
    prompt: '\nቀ  ቁ  ___  ቃ  ቄ  ቅ  ቆ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ጊ', 'ቂ', 'ቒ', 'ኪ'],
    correctAnswer: 'ቂ',
    level: 1,
  ),

  Question(
    id: 'q1_065',
    prompt: '\nቀ  ቁ  ቂ  ቃ  ቄ  ቅ  ___\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ጎ', 'ኮ', 'ሆ', 'ቆ'],
    correctAnswer: 'ቆ',
    level: 1,
  ),

  // ── ቐ family ──────────────────────────────────────────────────────────────
  Question(
    id: 'q1_066',
    prompt: '\n___  ቑ  ቒ  ቓ  ቔ  ቕ  ቖ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ከ', 'ቐ', 'ኸ', 'ቀ'],
    correctAnswer: 'ቐ',
    level: 1,
  ),

  // ── በ family ──────────────────────────────────────────────────────────────
  Question(
    id: 'q1_067',
    prompt: '\nበ  ___  ቢ  ባ  ቤ  ብ  ቦ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ሁ', 'ቡ', 'ቱ', 'ዱ'],
    correctAnswer: 'ቡ',
    level: 1,
  ),

  Question(
    id: 'q1_068',
    prompt: '\nበ  ቡ  ቢ  ባ  ___  ብ  ቦ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ቤ', 'ቴ', 'ሬ', 'ሌ'],
    correctAnswer: 'ቤ',
    level: 1,
  ),

  // ── ተ family ──────────────────────────────────────────────────────────────
  Question(
    id: 'q1_069',
    prompt: '\nተ  ቱ  ___  ታ  ቴ  ት  ቶ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ዲ', 'ቲ', 'ቢ', 'ሲ'],
    correctAnswer: 'ቲ',
    level: 1,
  ),

  Question(
    id: 'q1_070',
    prompt: '\nተ  ቱ  ቲ  ታ  ቴ  ___  ቶ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ብ', 'ት', 'ዝ', 'ድ'],
    correctAnswer: 'ት',
    level: 1,
  ),

  // ── ቸ family ──────────────────────────────────────────────────────────────
  Question(
    id: 'q1_071',
    prompt: '\nቸ  ቹ  ቺ  ___  ቼ  ች  ቾ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ጫ', 'ጣ', 'ቻ', 'ሻ'],
    correctAnswer: 'ቻ',
    level: 1,
  ),

  // ── ነ family ──────────────────────────────────────────────────────────────
  Question(
    id: 'q1_072',
    prompt: '\nነ  ___  ኒ  ና  ኔ  ን  ኖ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ሱ', 'ዱ', 'ኑ', 'ሁ'],
    correctAnswer: 'ኑ',
    level: 1,
  ),

  Question(
    id: 'q1_073',
    prompt: '\nነ  ኑ  ኒ  ና  ___  ን  ኖ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ሴ', 'ኔ', 'ሬ', 'ሌ'],
    correctAnswer: 'ኔ',
    level: 1,
  ),

  // ── ኘ family ──────────────────────────────────────────────────────────────
  Question(
    id: 'q1_074',
    prompt: '\nኘ  ኙ  ኚ  ___  ኜ  ኝ  ኞ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ዛ', 'ጛ', 'ና', 'ኛ'],
    correctAnswer: 'ኛ',
    level: 1,
  ),

  // ── አ family ──────────────────────────────────────────────────────────────
  Question(
    id: 'q1_075',
    prompt: '\n___  ኡ  ኢ  ኣ  ኤ  እ  ኦ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ዐ', 'ሀ', 'አ', 'ወ'],
    correctAnswer: 'አ',
    level: 1,
  ),

  Question(
    id: 'q1_076',
    prompt: '\nአ  ኡ  ኢ  ኣ  ___  እ  ኦ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ኤ', 'ሄ', 'ዔ', 'ሌ'],
    correctAnswer: 'ኤ',
    level: 1,
  ),

  // ── ከ family ──────────────────────────────────────────────────────────────
  Question(
    id: 'q1_077',
    prompt: '\nከ  ኩ  ___  ካ  ኬ  ክ  ኮ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ቂ', 'ቒ', 'ኪ', 'ጊ'],
    correctAnswer: 'ኪ',
    level: 1,
  ),

  Question(
    id: 'q1_078',
    prompt: '\nከ  ኩ  ኪ  ካ  ኬ  ክ  ___\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ጎ', 'ቆ', 'ሶ', 'ኮ'],
    correctAnswer: 'ኮ',
    level: 1,
  ),

  // ── ኸ family ──────────────────────────────────────────────────────────────
  Question(
    id: 'q1_079',
    prompt: '\nኸ  ኹ  ኺ  ___  ኼ  ኽ  ኾ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ጋ', 'ኻ', 'ዛ', 'ካ'],
    correctAnswer: 'ኻ',
    level: 1,
  ),

  // ── ወ family ──────────────────────────────────────────────────────────────
  Question(
    id: 'q1_080',
    prompt: '\nወ  ___  ዊ  ዋ  ዌ  ው  ዎ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ሁ', 'ዉ', 'ዑ', 'ዩ'],
    correctAnswer: 'ዉ',
    level: 1,
  ),

  Question(
    id: 'q1_081',
    prompt: '\nወ  ዉ  ዊ  ዋ  ዌ  ___  ዎ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ው', 'ህ', 'ን', 'ም'],
    correctAnswer: 'ው',
    level: 1,
  ),

  // ── ዐ family ──────────────────────────────────────────────────────────────
  Question(
    id: 'q1_082',
    prompt: '\nዐ  ዑ  ___  ዓ  ዔ  ዕ  ዖ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ዊ', 'ዚ', 'ሒ', 'ዒ'],
    correctAnswer: 'ዒ',
    level: 1,
  ),

  Question(
    id: 'q1_083',
    prompt: '\nዐ  ዑ  ዒ  ዓ  ዔ  ___  ዖ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ህ', 'ዕ', 'ን', 'ም'],
    correctAnswer: 'ዕ',
    level: 1,
  ),

  // ── ዘ family ──────────────────────────────────────────────────────────────
  Question(
    id: 'q1_084',
    prompt: '\nዘ  ___  ዚ  ዛ  ዜ  ዝ  ዞ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ሱ', 'ዑ', 'ዙ', 'ሙ'],
    correctAnswer: 'ዙ',
    level: 1,
  ),

  Question(
    id: 'q1_085',
    prompt: '\nዘ  ዙ  ዚ  ዛ  ___  ዝ  ዞ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ሌ', 'ሜ', 'ዜ', 'ሴ'],
    correctAnswer: 'ዜ',
    level: 1,
  ),

  // ── የ family ──────────────────────────────────────────────────────────────
  Question(
    id: 'q1_086',
    prompt: '\nየ  ___  ዪ  ያ  ዬ  ይ  ዮ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ዑ', 'ዩ', 'ዙ', 'ዉ'],
    correctAnswer: 'ዩ',
    level: 1,
  ),

  Question(
    id: 'q1_087',
    prompt: '\nየ  ዩ  ዪ  ያ  ዬ  ይ  ___\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ጎ', 'ዶ', 'ዮ', 'ዞ'],
    correctAnswer: 'ዮ',
    level: 1,
  ),

  // ── ደ family ──────────────────────────────────────────────────────────────
  Question(
    id: 'q1_088',
    prompt: '\nደ  ዱ  ___  ዳ  ዴ  ድ  ዶ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ዒ', 'ዚ', 'ዊ', 'ዲ'],
    correctAnswer: 'ዲ',
    level: 1,
  ),

  Question(
    id: 'q1_089',
    prompt: '\nደ  ዱ  ዲ  ዳ  ___  ድ  ዶ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ዴ', 'ሌ', 'ሴ', 'ቴ'],
    correctAnswer: 'ዴ',
    level: 1,
  ),

  // ── ጀ family ──────────────────────────────────────────────────────────────
  Question(
    id: 'q1_090',
    prompt: '\nጀ  ___  ጂ  ጃ  ጄ  ጅ  ጆ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ጡ', 'ዱ', 'ጁ', 'ጩ'],
    correctAnswer: 'ጁ',
    level: 1,
  ),

  // ── ገ family ──────────────────────────────────────────────────────────────
  Question(
    id: 'q1_091',
    prompt: '\nገ  ጉ  ___  ጋ  ጌ  ግ  ጎ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ኪ', 'ዲ', 'ቢ', 'ጊ'],
    correctAnswer: 'ጊ',
    level: 1,
  ),

  // ── ጠ family ──────────────────────────────────────────────────────────────
  Question(
    id: 'q1_092',
    prompt: '\nጠ  ጡ  ጢ  ___  ጤ  ጥ  ጦ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ጻ', 'ጣ', 'ታ', 'ጫ'],
    correctAnswer: 'ጣ',
    level: 1,
  ),

  Question(
    id: 'q1_093',
    prompt: '\nጠ  ጡ  ጢ  ጣ  ጤ  ___  ጦ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ጭ', 'ት', 'ጥ', 'ጽ'],
    correctAnswer: 'ጥ',
    level: 1,
  ),

  // ── ጨ family ──────────────────────────────────────────────────────────────
  Question(
    id: 'q1_094',
    prompt: '\nጨ  ___  ጪ  ጫ  ጬ  ጭ  ጮ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ጡ', 'ጩ', 'ቹ', 'ጹ'],
    correctAnswer: 'ጩ',
    level: 1,
  ),

  // ── ጸ family ──────────────────────────────────────────────────────────────
  Question(
    id: 'q1_095',
    prompt: '\nጸ  ጹ  ጺ  ___  ጼ  ጽ  ጾ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ጻ', 'ሳ', 'ጣ', 'ጫ'],
    correctAnswer: 'ጻ',
    level: 1,
  ),

  Question(
    id: 'q1_096',
    prompt: '\nጸ  ጹ  ጺ  ጻ  ጼ  ጽ  ___\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ጦ', 'ሶ', 'ጾ', 'ጮ'],
    correctAnswer: 'ጾ',
    level: 1,
  ),

  // ── ፈ family ──────────────────────────────────────────────────────────────
  Question(
    id: 'q1_097',
    prompt: '\nፈ  ፉ  ___  ፋ  ፌ  ፍ  ፎ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ፊ', 'ቢ', 'ቲ', 'ዲ'],
    correctAnswer: 'ፊ',
    level: 1,
  ),

  Question(
    id: 'q1_098',
    prompt: '\nፈ  ፉ  ፊ  ፋ  ፌ  ፍ  ___\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ሆ', 'ፎ', 'ቶ', 'ቦ'],
    correctAnswer: 'ፎ',
    level: 1,
  ),

  // ── ፐ family ──────────────────────────────────────────────────────────────
  Question(
    id: 'q1_099',
    prompt: '\nፐ  ፑ  ___  ፓ  ፔ  ፕ  ፖ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ቢ', 'ቲ', 'ፊ', 'ፒ'],
    correctAnswer: 'ፒ',
    level: 1,
  ),

  // ── ቨ family ──────────────────────────────────────────────────────────────
  Question(
    id: 'q1_100',
    prompt: '\nቨ  ቩ  ቪ  ___  ቬ  ቭ  ቮ\nባዶ ቦታ ምላእ',
    type: QuestionType.multipleChoice,
    options: ['ፋ', 'ካ', 'ዛ', 'ቫ'],
    correctAnswer: 'ቫ',
    level: 1,
  ),
];
 
// Level 2 Quiz - Words (100 questions)
// All 100 questions are audio-based: hear the word → select the correct Tigrigna word.
// Audio files follow the pattern: assets/audio/words/wXXX.mp3
// Correct answer positions randomized (seed=42): {pos0: 26, pos1: 29, pos2: 24, pos3: 21}

final List<Question> level2QuizData = [

  // ══════════════════════════════════════════════════════════════════════════
  // PART A — audio → Tigrigna word  (q2_001 – q2_050)
  // ══════════════════════════════════════════════════════════════════════════

  // ── People & family ───────────────────────────────────────────────────────
  Question(
    id: 'q2_001',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ቆልዓ', 'ወዲ', 'ሕጻን', 'ጓል'],
    correctAnswer: 'ወዲ',
    level: 2,
    audioPath: 'assets/audio/words/w006.mp3',
  ),

  Question(
    id: 'q2_002',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ቆልዓ', 'ሰበይቲ', 'ወዲ', 'ጓል'],
    correctAnswer: 'ጓል',
    level: 2,
    audioPath: 'assets/audio/words/w007.mp3',
  ),

  Question(
    id: 'q2_003',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ሓው', 'ኣቦሓጎ', 'ኣቦ', 'ኣደ'],
    correctAnswer: 'ኣቦ',
    level: 2,
    audioPath: 'assets/audio/words/w004.mp3',
  ),

  Question(
    id: 'q2_004',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ሓፍቲ', 'ሰበይቲ', 'ዓባይ', 'ኣደ'],
    correctAnswer: 'ኣደ',
    level: 2,
    audioPath: 'assets/audio/words/w005.mp3',
  ),

  Question(
    id: 'q2_005',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ኣቦ', 'ኣቦሓጎ', 'ሰብኣይ', 'ሽማግለ'],
    correctAnswer: 'ኣቦሓጎ',
    level: 2,
    audioPath: 'assets/audio/words/w123.mp3',
  ),

  Question(
    id: 'q2_006',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ሓፍቲ', 'ሰበይቲ', 'ዓባይ', 'ኣደ'],
    correctAnswer: 'ዓባይ',
    level: 2,
    audioPath: 'assets/audio/words/w124.mp3',
  ),

  // ── Body parts ────────────────────────────────────────────────────────────
  Question(
    id: 'q2_007',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['እግሪ', 'ኢድ', 'እዝኒ', 'ዓይኒ'],
    correctAnswer: 'ኢድ',
    level: 2,
    audioPath: 'assets/audio/words/w030.mp3',
  ),

  Question(
    id: 'q2_008',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ዓይኒ', 'ኣፍንጫ', 'ኣፍ', 'ርእሲ'],
    correctAnswer: 'ዓይኒ',
    level: 2,
    audioPath: 'assets/audio/words/w031.mp3',
  ),

  Question(
    id: 'q2_009',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ኣፍ', 'እዝኒ', 'ዓይኒ', 'ኣፍንጫ'],
    correctAnswer: 'እዝኒ',
    level: 2,
    audioPath: 'assets/audio/words/w033.mp3',
  ),

  Question(
    id: 'q2_010',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ጸጉሪ', 'ዓጽሚ', 'ስኒ', 'ከናፍር'],
    correctAnswer: 'ስኒ',
    level: 2,
    audioPath: 'assets/audio/words/w053.mp3',
  ),

  // ── Animals ───────────────────────────────────────────────────────────────
  Question(
    id: 'q2_011',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ድሙ', 'ላም', 'ጤል', 'ከልቢ'],
    correctAnswer: 'ድሙ',
    level: 2,
    audioPath: 'assets/audio/words/w008.mp3',
  ),

  Question(
    id: 'q2_012',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ሓሰማ', 'ፈረስ', 'ከልቢ', 'ድሙ'],
    correctAnswer: 'ከልቢ',
    level: 2,
    audioPath: 'assets/audio/words/w009.mp3',
  ),

  Question(
    id: 'q2_013',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ህበይ', 'ኣንበሳ', 'ነብሪ', 'ሓርማዝ'],
    correctAnswer: 'ኣንበሳ',
    level: 2,
    audioPath: 'assets/audio/words/w019.mp3',
  ),

  Question(
    id: 'q2_014',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ነብሪ', 'ሓርጌጽ', 'ዘራፍ', 'ኣንበሳ'],
    correctAnswer: 'ነብሪ',
    level: 2,
    audioPath: 'assets/audio/words/w073.mp3',
  ),

  Question(
    id: 'q2_015',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ዘራፍ', 'ፈረስ', 'ህበይ', 'ሓርማዝ'],
    correctAnswer: 'ሓርማዝ',
    level: 2,
    audioPath: 'assets/audio/words/w044.mp3',
  ),

  Question(
    id: 'q2_016',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ኣድጊ', 'ሓርማዝ', 'ፈረስ', 'ዘራፍ'],
    correctAnswer: 'ዘራፍ',
    level: 2,
    audioPath: 'assets/audio/words/w203.mp3',
  ),

  Question(
    id: 'q2_017',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ህበይ', 'ጻጸ', 'ጎብየ', 'ዓሳ'],
    correctAnswer: 'ህበይ',
    level: 2,
    audioPath: 'assets/audio/words/w206.mp3',
  ),

  Question(
    id: 'q2_018',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ፈረስ', 'ላም', 'ጤል', 'ሓሰማ'],
    correctAnswer: 'ላም',
    level: 2,
    audioPath: 'assets/audio/words/w097.mp3',
  ),

  Question(
    id: 'q2_019',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ፈረስ', 'ጤል', 'ላም', 'ኣድጊ'],
    correctAnswer: 'ፈረስ',
    level: 2,
    audioPath: 'assets/audio/words/w202.mp3',
  ),

  Question(
    id: 'q2_020',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ጎብየ', 'ሓርጌጽ', 'ዓሳ', 'ተምን'],
    correctAnswer: 'ዓሳ',
    level: 2,
    audioPath: 'assets/audio/words/w017.mp3',
  ),

  // ── Nature & weather ──────────────────────────────────────────────────────
  Question(
    id: 'q2_021',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ወርሒ', 'ዝናብ', 'ጸሓይ', 'ኮኾብ'],
    correctAnswer: 'ጸሓይ',
    level: 2,
    audioPath: 'assets/audio/words/w012.mp3',
  ),

  Question(
    id: 'q2_022',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ጸሓይ', 'ሰማይ', 'ኮኾብ', 'ወርሒ'],
    correctAnswer: 'ወርሒ',
    level: 2,
    audioPath: 'assets/audio/words/w013.mp3',
  ),

  Question(
    id: 'q2_023',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ጸሓይ', 'ኮኾብ', 'ወርሒ', 'ሰማይ'],
    correctAnswer: 'ኮኾብ',
    level: 2,
    audioPath: 'assets/audio/words/w014.mp3',
  ),

  Question(
    id: 'q2_024',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ደበና', 'ዝናብ', 'ንፋስ', 'ሰማይ'],
    correctAnswer: 'ዝናብ',
    level: 2,
    audioPath: 'assets/audio/words/w015.mp3',
  ),

  Question(
    id: 'q2_025',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ንፋስ', 'ዝናብ', 'ሰማይ', 'ደበና'],
    correctAnswer: 'ደበና',
    level: 2,
    audioPath: 'assets/audio/words/w200.mp3',
  ),

  Question(
    id: 'q2_026',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ማይ', 'በረድ', 'ዝናብ', 'ንፋስ'],
    correctAnswer: 'በረድ',
    level: 2,
    audioPath: 'assets/audio/words/w089.mp3',
  ),

  Question(
    id: 'q2_027',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ሓዊ', 'ዘይቲ', 'ማይ', 'ትኪ'],
    correctAnswer: 'ሓዊ',
    level: 2,
    audioPath: 'assets/audio/words/w029.mp3',
  ),

  Question(
    id: 'q2_028',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ዘይቲ', 'ማይ', 'ሓዊ', 'ትኪ'],
    correctAnswer: 'ማይ',
    level: 2,
    audioPath: 'assets/audio/words/w003.mp3',
  ),

  // ── Food & drink ──────────────────────────────────────────────────────────
  Question(
    id: 'q2_029',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ባኒ', 'ሽሮ', 'እንጀራ', 'ጸባ'],
    correctAnswer: 'ባኒ',
    level: 2,
    audioPath: 'assets/audio/words/w060.mp3',
  ),

  Question(
    id: 'q2_030',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ማይ', 'ሻሂ', 'ጽሟቕ', 'ጸባ'],
    correctAnswer: 'ጸባ',
    level: 2,
    audioPath: 'assets/audio/words/w152.mp3',
  ),

  Question(
    id: 'q2_031',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ጸባ', 'ሻሂ', 'ቡን', 'ጽሟቕ'],
    correctAnswer: 'ቡን',
    level: 2,
    audioPath: 'assets/audio/words/w059.mp3',
  ),

  Question(
    id: 'q2_032',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ቡን', 'ሻሂ', 'ማይ', 'ጸባ'],
    correctAnswer: 'ሻሂ',
    level: 2,
    audioPath: 'assets/audio/words/w170.mp3',
  ),

  Question(
    id: 'q2_033',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ጸባ', 'ስጋ', 'ሽሮ', 'እንቋቑሖ'],
    correctAnswer: 'እንቋቑሖ',
    level: 2,
    audioPath: 'assets/audio/words/w156.mp3',
  ),

  Question(
    id: 'q2_034',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ለሚን', 'ቱፋሕ', 'ማንጉስ', 'ኣራንሺ'],
    correctAnswer: 'ቱፋሕ',
    level: 2,
    audioPath: 'assets/audio/words/w165.mp3',
  ),

  Question(
    id: 'q2_035',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ቱፋሕ', 'ኣናናስ', 'ወይኒ', 'በነና'],
    correctAnswer: 'በነና',
    level: 2,
    audioPath: 'assets/audio/words/w167.mp3',
  ),

  Question(
    id: 'q2_036',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ቱፋሕ', 'ፐረ', 'ኣራንሺ', 'ለሚን'],
    correctAnswer: 'ኣራንሺ',
    level: 2,
    audioPath: 'assets/audio/words/w168.mp3',
  ),

  Question(
    id: 'q2_037',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ፐረ', 'ኣራንሺ', 'ቱፋሕ', 'ለሚን'],
    correctAnswer: 'ለሚን',
    level: 2,
    audioPath: 'assets/audio/words/w039.mp3',
  ),

  // ── Household & tools ─────────────────────────────────────────────────────
  Question(
    id: 'q2_038',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ክፍሊ', 'ጎጆ', 'ቴንዳ', 'ቤት'],
    correctAnswer: 'ቤት',
    level: 2,
    audioPath: 'assets/audio/words/w002.mp3',
  ),

  Question(
    id: 'q2_039',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ዓራት', 'ኣስካላ', 'ምስኮት', 'ሶፋ'],
    correctAnswer: 'ምስኮት',
    level: 2,
    audioPath: 'assets/audio/words/w094.mp3',
  ),

  Question(
    id: 'q2_040',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ዓራት', 'ኣርማድዮ', 'ተመዛዚ', 'ሶፋ'],
    correctAnswer: 'ዓራት',
    level: 2,
    audioPath: 'assets/audio/words/w371.mp3',
  ),

  Question(
    id: 'q2_041',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ማንካ', 'ካራ', 'ፋርኬታ', 'ሸሓኒ'],
    correctAnswer: 'ማንካ',
    level: 2,
    audioPath: 'assets/audio/words/w048.mp3',
  ),

  Question(
    id: 'q2_042',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ፋርኬታ', 'ማንካ', 'ካራ', 'መቐስ'],
    correctAnswer: 'መቐስ',
    level: 2,
    audioPath: 'assets/audio/words/w057.mp3',
  ),

  Question(
    id: 'q2_043',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['መፍትሕ', 'ሜላ', 'ስልኪ', 'ካርታ'],
    correctAnswer: 'መፍትሕ',
    level: 2,
    audioPath: 'assets/audio/words/w190.mp3',
  ),

  // ── Transport & places ────────────────────────────────────────────────────
  Question(
    id: 'q2_044',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['መኪና', 'ባቡር', 'ታክሲ', 'ኣውቶቡስ'],
    correctAnswer: 'መኪና',
    level: 2,
    audioPath: 'assets/audio/words/w091.mp3',
  ),

  Question(
    id: 'q2_045',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ባቡር', 'መርከብ', 'ነፋሪት', 'ኣውቶቡስ'],
    correctAnswer: 'ነፋሪት',
    level: 2,
    audioPath: 'assets/audio/words/w066.mp3',
  ),

  Question(
    id: 'q2_046',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['መርከብ', 'ነፋሪት', 'ባቡር', 'ኣውቶቡስ'],
    correctAnswer: 'ባቡር',
    level: 2,
    audioPath: 'assets/audio/words/w356.mp3',
  ),

  Question(
    id: 'q2_047',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ብሽክለታ', 'ታክሲ', 'ዓረብያ', 'ሞተርሳይክል'],
    correctAnswer: 'ብሽክለታ',
    level: 2,
    audioPath: 'assets/audio/words/w352.mp3',
  ),

  Question(
    id: 'q2_048',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ቤት-ፍርዲ', 'ቤት-ክርስቲያን', 'ሆስፒታል', 'ቤት-ትምህርቲ'],
    correctAnswer: 'ቤት-ትምህርቲ',
    level: 2,
    audioPath: 'assets/audio/words/w081.mp3',
  ),

  Question(
    id: 'q2_049',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ሆስፒታል', 'ቤት-ትምህርቲ', 'ቤት-ፍርዲ', 'ቤት-ክርስቲያን'],
    correctAnswer: 'ሆስፒታል',
    level: 2,
    audioPath: 'assets/audio/words/w149.mp3',
  ),

  Question(
    id: 'q2_050',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ቤት-መግቢ', 'ፖስታ ቤት', 'ባንክ', 'ሆቴል'],
    correctAnswer: 'ባንክ',
    level: 2,
    audioPath: 'assets/audio/words/w150.mp3',
  ),

  // ══════════════════════════════════════════════════════════════════════════
  // PART B — audio → Tigrigna word  (q2_051 – q2_100)
  // ══════════════════════════════════════════════════════════════════════════

  // ── People & family ───────────────────────────────────────────────────────
  Question(
    id: 'q2_051',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ኣቦ', 'ሓፍቲ', 'ዓባይ', 'ኣደ'],
    correctAnswer: 'ኣቦ',
    level: 2,
    audioPath: 'assets/audio/words/w004.mp3',
  ),

  Question(
    id: 'q2_052',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ዓባይ', 'ኣደ', 'ሓፍቲ', 'ኣቦ'],
    correctAnswer: 'ኣደ',
    level: 2,
    audioPath: 'assets/audio/words/w005.mp3',
  ),

  Question(
    id: 'q2_053',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ጓል', 'ወዲ', 'ቆልዓ', 'ሰበይቲ'],
    correctAnswer: 'ወዲ',
    level: 2,
    audioPath: 'assets/audio/words/w006.mp3',
  ),

  Question(
    id: 'q2_054',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ወዲ', 'ቆልዓ', 'ጓል', 'ሰበይቲ'],
    correctAnswer: 'ጓል',
    level: 2,
    audioPath: 'assets/audio/words/w007.mp3',
  ),

  Question(
    id: 'q2_055',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ዓርኪ', 'ሓፍቲ', 'ቆልዓ', 'ሓው'],
    correctAnswer: 'ዓርኪ',
    level: 2,
    audioPath: 'assets/audio/words/w118.mp3',
  ),

  Question(
    id: 'q2_056',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ሓው', 'ሓፍቲ', 'ዓርኪ', 'ቆልዓ'],
    correctAnswer: 'ሓፍቲ',
    level: 2,
    audioPath: 'assets/audio/words/w122.mp3',
  ),

  // ── Professions ───────────────────────────────────────────────────────────
  Question(
    id: 'q2_057',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ነርስ', 'ሓረስታይ', 'ዘዋሪ', 'ሓኪም'],
    correctAnswer: 'ሓኪም',
    level: 2,
    audioPath: 'assets/audio/words/w129.mp3',
  ),

  Question(
    id: 'q2_058',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ዘዋሪ', 'ሃናጺ', 'ነርስ', 'ሓኪም'],
    correctAnswer: 'ነርስ',
    level: 2,
    audioPath: 'assets/audio/words/w130.mp3',
  ),

  Question(
    id: 'q2_059',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ዘዋሪ', 'ሓረስታይ', 'ነጋዳይ', 'ሓኪም'],
    correctAnswer: 'ሓረስታይ',
    level: 2,
    audioPath: 'assets/audio/words/w131.mp3',
  ),

  Question(
    id: 'q2_060',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['መምህር', 'ሓረስታይ', 'ዘዋሪ', 'ሃናጺ'],
    correctAnswer: 'መምህር',
    level: 2,
    audioPath: 'assets/audio/words/w080.mp3',
  ),

  // ── Clothing ──────────────────────────────────────────────────────────────
  Question(
    id: 'q2_061',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ቀምሽ', 'ጃኬት', 'ካምቻ', 'ስረ'],
    correctAnswer: 'ካምቻ',
    level: 2,
    audioPath: 'assets/audio/words/w110.mp3',
  ),

  Question(
    id: 'q2_062',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ጃኬት', 'ስረ', 'ካምቻ', 'ቀምሽ'],
    correctAnswer: 'ጃኬት',
    level: 2,
    audioPath: 'assets/audio/words/w111.mp3',
  ),

  Question(
    id: 'q2_063',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ጃኬት', 'ሳእኒ', 'ካምቻ', 'ካልሲ'],
    correctAnswer: 'ሳእኒ',
    level: 2,
    audioPath: 'assets/audio/words/w113.mp3',
  ),

  Question(
    id: 'q2_064',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ሳእኒ', 'ጓንቲ', 'ካልሲ', 'ቆቢዕ'],
    correctAnswer: 'ካልሲ',
    level: 2,
    audioPath: 'assets/audio/words/w115.mp3',
  ),

  Question(
    id: 'q2_065',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ቆቢዕ', 'ካልሲ', 'ቦርሳ', 'ሳእኒ'],
    correctAnswer: 'ቆቢዕ',
    level: 2,
    audioPath: 'assets/audio/words/w109.mp3',
  ),

  // ── Food & kitchen ────────────────────────────────────────────────────────
  Question(
    id: 'q2_066',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ጸባ', 'ሽሮ', 'ስጋ', 'እንጀራ'],
    correctAnswer: 'እንጀራ',
    level: 2,
    audioPath: 'assets/audio/words/w151.mp3',
  ),

  Question(
    id: 'q2_067',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ዘይቲ', 'በርበረ', 'ጨው', 'ሸኮር'],
    correctAnswer: 'ሸኮር',
    level: 2,
    audioPath: 'assets/audio/words/w158.mp3',
  ),

  Question(
    id: 'q2_068',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ጨው', 'በርበረ', 'ዘይቲ', 'ሸኮር'],
    correctAnswer: 'ጨው',
    level: 2,
    audioPath: 'assets/audio/words/w157.mp3',
  ),

  Question(
    id: 'q2_069',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ሽጉርቲ', 'ድንሽ', 'ኮሚደረ', 'ካሮት'],
    correctAnswer: 'ድንሽ',
    level: 2,
    audioPath: 'assets/audio/words/w163.mp3',
  ),

  Question(
    id: 'q2_070',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ካሮት', 'ድንሽ', 'ሽጉርቲ', 'ኮሚደረ'],
    correctAnswer: 'ኮሚደረ',
    level: 2,
    audioPath: 'assets/audio/words/w162.mp3',
  ),

  // ── Colors ────────────────────────────────────────────────────────────────
  Question(
    id: 'q2_071',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ቀጠልያ', 'ብጫ', 'ቀይሕ', 'ጸሊም'],
    correctAnswer: 'ቀይሕ',
    level: 2,
    audioPath: 'assets/audio/words/w301.mp3',
  ),

  Question(
    id: 'q2_072',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ቀጠልያ', 'ጸሊም', 'ቀይሕ', 'ጻዕዳ'],
    correctAnswer: 'ጸሊም',
    level: 2,
    audioPath: 'assets/audio/words/w302.mp3',
  ),

  Question(
    id: 'q2_073',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ቀይሕ', 'ጻዕዳ', 'ጸሊም', 'ሰማያዊ'],
    correctAnswer: 'ጻዕዳ',
    level: 2,
    audioPath: 'assets/audio/words/w303.mp3',
  ),

  Question(
    id: 'q2_074',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ብጫ', 'ጻዕዳ', 'ሰማያዊ', 'ቀይሕ'],
    correctAnswer: 'ሰማያዊ',
    level: 2,
    audioPath: 'assets/audio/words/w304.mp3',
  ),

  Question(
    id: 'q2_075',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ብጫ', 'ቀጠልያ', 'ሰማያዊ', 'ቀይሕ'],
    correctAnswer: 'ብጫ',
    level: 2,
    audioPath: 'assets/audio/words/w305.mp3',
  ),

  Question(
    id: 'q2_076',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ቀይሕ', 'ቀጠልያ', 'ብጫ', 'ሰማያዊ'],
    correctAnswer: 'ቀጠልያ',
    level: 2,
    audioPath: 'assets/audio/words/w306.mp3',
  ),

  // ── Numbers 1–10 ──────────────────────────────────────────────────────────
  Question(
    id: 'q2_077',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ሰለስተ', 'ሓደ', 'ኣርባዕተ', 'ክልተ'],
    correctAnswer: 'ሓደ',
    level: 2,
    audioPath: 'assets/audio/words/w311.mp3',
  ),

  Question(
    id: 'q2_078',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ሰለስተ', 'ኣርባዕተ', 'ክልተ', 'ሓደ'],
    correctAnswer: 'ክልተ',
    level: 2,
    audioPath: 'assets/audio/words/w312.mp3',
  ),

  Question(
    id: 'q2_079',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ኣርባዕተ', 'ክልተ', 'ሓደ', 'ሰለስተ'],
    correctAnswer: 'ሰለስተ',
    level: 2,
    audioPath: 'assets/audio/words/w313.mp3',
  ),

  Question(
    id: 'q2_080',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ሽዱሽተ', 'ሓሙሽተ', 'ኣርባዕተ', 'ሰለስተ'],
    correctAnswer: 'ኣርባዕተ',
    level: 2,
    audioPath: 'assets/audio/words/w314.mp3',
  ),

  Question(
    id: 'q2_081',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ሸውዓተ', 'ኣርባዕተ', 'ሓሙሽተ', 'ሽዱሽተ'],
    correctAnswer: 'ሓሙሽተ',
    level: 2,
    audioPath: 'assets/audio/words/w315.mp3',
  ),

  Question(
    id: 'q2_082',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ሸሞንተ', 'ሸውዓተ', 'ሓሙሽተ', 'ሽዱሽተ'],
    correctAnswer: 'ሽዱሽተ',
    level: 2,
    audioPath: 'assets/audio/words/w316.mp3',
  ),

  Question(
    id: 'q2_083',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ሽዱሽተ', 'ሸውዓተ', 'ሸሞንተ', 'ትሽዓተ'],
    correctAnswer: 'ሸውዓተ',
    level: 2,
    audioPath: 'assets/audio/words/w317.mp3',
  ),

  Question(
    id: 'q2_084',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ትሽዓተ', 'ሸሞንተ', 'ሸውዓተ', 'ዓሰርተ'],
    correctAnswer: 'ሸሞንተ',
    level: 2,
    audioPath: 'assets/audio/words/w318.mp3',
  ),

  Question(
    id: 'q2_085',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ትሽዓተ', 'ሸውዓተ', 'ሸሞንተ', 'ዓሰርተ'],
    correctAnswer: 'ትሽዓተ',
    level: 2,
    audioPath: 'assets/audio/words/w319.mp3',
  ),

  Question(
    id: 'q2_086',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ሚእቲ', 'ዓሰርተ', 'ትሽዓተ', 'ዕስራ'],
    correctAnswer: 'ዓሰርተ',
    level: 2,
    audioPath: 'assets/audio/words/w320.mp3',
  ),

  // ── Feelings & time ───────────────────────────────────────────────────────
  Question(
    id: 'q2_087',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ሓጎስ', 'ፍቕሪ', 'ዓወት', 'ሰላም'],
    correctAnswer: 'ሰላም',
    level: 2,
    audioPath: 'assets/audio/words/w024.mp3',
  ),

  Question(
    id: 'q2_088',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ሓጎስ', 'ፍቕሪ', 'ዓወት', 'ሰላም'],
    correctAnswer: 'ፍቕሪ',
    level: 2,
    audioPath: 'assets/audio/words/w023.mp3',
  ),

  Question(
    id: 'q2_089',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ሓጎስ', 'ሓዘን', 'ፍርሒ', 'ሕርቃን'],
    correctAnswer: 'ሓጎስ',
    level: 2,
    audioPath: 'assets/audio/words/w025.mp3',
  ),

  Question(
    id: 'q2_090',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ሕርቃን', 'ሓጎስ', 'ሓዘን', 'ፍርሒ'],
    correctAnswer: 'ሓዘን',
    level: 2,
    audioPath: 'assets/audio/words/w247.mp3',
  ),

  Question(
    id: 'q2_091',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ሎሚ', 'ጽባሕ', 'ትማሊ', 'ሰሙን'],
    correctAnswer: 'ሎሚ',
    level: 2,
    audioPath: 'assets/audio/words/w289.mp3',
  ),

  Question(
    id: 'q2_092',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ትማሊ', 'ጽባሕ', 'ሰሙን', 'ሎሚ'],
    correctAnswer: 'ትማሊ',
    level: 2,
    audioPath: 'assets/audio/words/w290.mp3',
  ),

  Question(
    id: 'q2_093',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ጽባሕ', 'ሎሚ', 'ትማሊ', 'ሰሙን'],
    correctAnswer: 'ጽባሕ',
    level: 2,
    audioPath: 'assets/audio/words/w291.mp3',
  ),

  Question(
    id: 'q2_094',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ቀትሪ', 'ምሸት', 'ንጉሆ', 'ለይቲ'],
    correctAnswer: 'ንጉሆ',
    level: 2,
    audioPath: 'assets/audio/words/w286.mp3',
  ),

  Question(
    id: 'q2_095',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ንጉሆ', 'ቀትሪ', 'ምሸት', 'ለይቲ'],
    correctAnswer: 'ቀትሪ',
    level: 2,
    audioPath: 'assets/audio/words/w287.mp3',
  ),

  Question(
    id: 'q2_096',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ለይቲ', 'ንጉሆ', 'ቀትሪ', 'ምሸት'],
    correctAnswer: 'ምሸት',
    level: 2,
    audioPath: 'assets/audio/words/w285.mp3',
  ),

  Question(
    id: 'q2_097',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ንጉሆ', 'ለይቲ', 'ቀትሪ', 'ምሸት'],
    correctAnswer: 'ለይቲ',
    level: 2,
    audioPath: 'assets/audio/words/w288.mp3',
  ),

  // ── Culture & nation ──────────────────────────────────────────────────────
  Question(
    id: 'q2_098',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ባህሊ', 'ታሪኽ', 'ካርታ', 'ቋንቋ'],
    correctAnswer: 'ታሪኽ',
    level: 2,
    audioPath: 'assets/audio/words/w439.mp3',
  ),

  Question(
    id: 'q2_099',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ናጽነት', 'ሰላም', 'ሃገር', 'ሓድነት'],
    correctAnswer: 'ናጽነት',
    level: 2,
    audioPath: 'assets/audio/words/w442.mp3',
  ),

  Question(
    id: 'q2_100',
    prompt: '🔊 ድምጺ ስምዕዎ — ዝሰማዕክምዎ ቃል ትግርኛ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: ['ሃገር', 'ሰላም', 'ሓድነት', 'ናጽነት'],
    correctAnswer: 'ሓድነት',
    level: 2,
    audioPath: 'assets/audio/words/w443.mp3',
  ),
];
 
// Level 3 Quiz - Sentences (100 questions)
//
// Format: student hears the Tigrigna sentence (audioPath) and selects
// the correct Tigrigna sentence from 4 written options.
// The learner must listen carefully and match what they hear to the
// correct written sentence — all options are in Tigrigna.
//
// Distractors are drawn from the same thematic group so the learner must
// listen closely to distinguish similar sentences.
//
// Coverage: all 12 topic groups from sentences_data (s001–s300).

final List<Question> level3QuizData = [

  // ══════════════════════════════════════════════════════════════════════════
  // GREETINGS & FAREWELLS  (s001–s015)
  // ══════════════════════════════════════════════════════════════════════════

  Question(
    id: 'q3_001',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'ደሓን ኩን።',
      'ሰላም ከመይ ኣለኻ፧',
      'ብጣዕሚ የቅንየለይ።',
      'ካበይ ኢኻ፧',
    ],
    correctAnswer: 'ሰላም ከመይ ኣለኻ፧',
    level: 3,
    audioPath: 'assets/audio/sentences/s001.mp3',
  ),

  Question(
    id: 'q3_002',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'ጽቡቕ ለይቲ።',
      'ጽባሕ የራኽበና።',
      'ከመይ ሓዲርካ፧',
      'እንቋዕ ብድሓን መጻእኩም።',
    ],
    correctAnswer: 'ከመይ ሓዲርካ፧',
    level: 3,
    audioPath: 'assets/audio/sentences/s002.mp3',
  ),

  Question(
    id: 'q3_003',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'ከመይ ሓዲርካ፧',
      'ጽቡቕ ለይቲ።',
      'ደሓን ኩን።',
      'ከመይ ኣምሲኻ፧',
    ],
    correctAnswer: 'ከመይ ኣምሲኻ፧',
    level: 3,
    audioPath: 'assets/audio/sentences/s003.mp3',
  ),

  Question(
    id: 'q3_004',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'ከመይ ኣምሲኻ፧',
      'ጽባሕ የራኽበና።',
      'ከመይ ሓዲርካ፧',
      'ጽቡቕ ለይቲ።',
    ],
    correctAnswer: 'ጽቡቕ ለይቲ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s004.mp3',
  ),

  Question(
    id: 'q3_005',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'እንቋዕ ብድሓን መጻእኩም።',
      'ጽባሕ የራኽበና።',
      'ጽቡቕ ለይቲ።',
      'ደሓን ኩን።',
    ],
    correctAnswer: 'ደሓን ኩን።',
    level: 3,
    audioPath: 'assets/audio/sentences/s005.mp3',
  ),

  Question(
    id: 'q3_006',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'ደሓን ኩን።',
      'እንቋዕ ብድሓን መጻእኩም።',
      'ስለ ዝረኸብኩኻ ሕጉስ እየ።',
      'ጽባሕ የራኽበና።',
    ],
    correctAnswer: 'ጽባሕ የራኽበና።',
    level: 3,
    audioPath: 'assets/audio/sentences/s006.mp3',
  ),

  Question(
    id: 'q3_007',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'ስለ ዝረኸብኩኻ ሕጉስ እየ።',
      'ኣነ ጽቡቕ ኣለኹ፣ የቐንየለይ።',
      'መን ኢዩ ሽምካ፧',
      'እንቋዕ ብድሓን መጻእኩም።',
    ],
    correctAnswer: 'እንቋዕ ብድሓን መጻእኩም።',
    level: 3,
    audioPath: 'assets/audio/sentences/s007.mp3',
  ),

  Question(
    id: 'q3_008',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'ክንደይ ኢዩ ዕድሜኻ፧',
      'ካበይ ኢኻ፧',
      'መን ኢዩ ሽምካ፧',
      'ኣነ ጽቡቕ ኣለኹ፣ የቐንየለይ።',
    ],
    correctAnswer: 'ኣነ ጽቡቕ ኣለኹ፣ የቐንየለይ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s008.mp3',
  ),

  Question(
    id: 'q3_009',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'ካበይ ኢኻ፧',
      'ክንደይ ኢዩ ዕድሜኻ፧',
      'መን ኢዩ ሽምካ፧',
      'ስለ ዝረኸብኩኻ ሕጉስ እየ።',
    ],
    correctAnswer: 'መን ኢዩ ሽምካ፧',
    level: 3,
    audioPath: 'assets/audio/sentences/s009.mp3',
  ),

  Question(
    id: 'q3_010',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'ክንደይ ኢዩ ዕድሜኻ፧',
      'ካበይ ኢኻ፧',
      'ኣነ ካብ ኤርትራ ኢየ።',
      'ሽመይ ዮሃንስ ይባሃል።',
    ],
    correctAnswer: 'ሽመይ ዮሃንስ ይባሃል።',
    level: 3,
    audioPath: 'assets/audio/sentences/s010.mp3',
  ),

  // ══════════════════════════════════════════════════════════════════════════
  // FAMILY  (s016–s030)
  // ══════════════════════════════════════════════════════════════════════════

  Question(
    id: 'q3_011',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'እዚ ኣቦይ ኢዩ።',
      'ዓባየይ ኣረጊት ኢያ።',
      'እዚኣ ኣደይ ኢያ።',
      'ኣነ ክልተ ኣሓት ኣለዋኒ።',
    ],
    correctAnswer: 'እዚኣ ኣደይ ኢያ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s016.mp3',
  ),

  Question(
    id: 'q3_012',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'እዚኣ ኣደይ ኢያ።',
      'ኣቦሓጎይ ነዊሕ ኢዩ።',
      'ኣነ ሓደ ሓው ኣለኒ።',
      'እዚ ኣቦይ ኢዩ።',
    ],
    correctAnswer: 'እዚ ኣቦይ ኢዩ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s017.mp3',
  ),

  Question(
    id: 'q3_013',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'ኣነ ክልተ ኣሓት ኣለዋኒ።',
      'ኣነ ሓደ ሓው ኣለኒ።',
      'ስድራ ቤተይ ዓቢ ኢዩ።',
      'ወደይ ንእሽቶ እዩ።',
    ],
    correctAnswer: 'ኣነ ሓደ ሓው ኣለኒ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s018.mp3',
  ),

  Question(
    id: 'q3_014',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'ኣነ ሓደ ሓው ኣለኒ።',
      'ጓለይ በላሕ እያ።',
      'ስድራ ቤተይ ዓቢ ኢዩ።',
      'ኣነ ክልተ ኣሓት ኣለዋኒ።',
    ],
    correctAnswer: 'ኣነ ክልተ ኣሓት ኣለዋኒ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s019.mp3',
  ),

  Question(
    id: 'q3_015',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'ኣቦሓጎይ ነዊሕ ኢዩ።',
      'ወለደይ ሕያዎት እዮም።',
      'እቲ ህጻን ደቂሱ ኣሎ።',
      'ዓባየይ ኣረጊት ኢያ።',
    ],
    correctAnswer: 'ዓባየይ ኣረጊት ኢያ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s020.mp3',
  ),

  Question(
    id: 'q3_016',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'ዓባየይ ኣረጊት ኢያ።',
      'ስድራ ቤተይ ዓቢ ኢዩ።',
      'ኣቦሓጎይ ነዊሕ ኢዩ።',
      'እቲ ህጻን ደቂሱ ኣሎ።',
    ],
    correctAnswer: 'ኣቦሓጎይ ነዊሕ ኢዩ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s021.mp3',
  ),

  Question(
    id: 'q3_017',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'ወደይ ንእሽቶ እዩ።',
      'ንሕና ብሓባር ንበልዕ።',
      'ጓለይ በላሕ እያ።',
      'እቲ ህጻን ደቂሱ ኣሎ።',
    ],
    correctAnswer: 'እቲ ህጻን ደቂሱ ኣሎ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s022.mp3',
  ),

  Question(
    id: 'q3_018',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'ኣሞይ ጽቡቕ ምግቢ ትሰርሕ።',
      'ኣኮይ ኣብ ርሑቕ እዩ ዝነብር።',
      'ንሕና ብሓባር ንበልዕ።',
      'ወለደይ ሕያዎት እዮም።',
    ],
    correctAnswer: 'ንሕና ብሓባር ንበልዕ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s028.mp3',
  ),

  Question(
    id: 'q3_019',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'ኣኮይ ኣብ ርሑቕ እዩ ዝነብር።',
      'ወዲ ሓወቦይ መስሓቕ እዩ።',
      'ወለደይ ሕያዎት እዮም።',
      'ኣሞይ ጽቡቕ ምግቢ ትሰርሕ።',
    ],
    correctAnswer: 'ኣሞይ ጽቡቕ ምግቢ ትሰርሕ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s027.mp3',
  ),

  Question(
    id: 'q3_020',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'ወዲ ሓወቦይ መስሓቕ እዩ።',
      'ስድራ ቤተይ ዓቢ ኢዩ።',
      'ንሕና ብሓባር ንበልዕ።',
      'ወለደይ ሕያዎት እዮም።',
    ],
    correctAnswer: 'ወለደይ ሕያዎት እዮም።',
    level: 3,
    audioPath: 'assets/audio/sentences/s030.mp3',
  ),

  // ══════════════════════════════════════════════════════════════════════════
  // HOME & HOUSE  (s031–s045)
  // ══════════════════════════════════════════════════════════════════════════

  Question(
    id: 'q3_021',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'እቲ መስኮት ክፉት እዩ።',
      'እቲ ክሽነ ጽሩይ እዩ።',
      'እቲ ማዕጾ ክፉት እዩ።',
      'እዚ ገዛይ እዩ።',
    ],
    correctAnswer: 'እዚ ገዛይ እዩ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s031.mp3',
  ),

  Question(
    id: 'q3_022',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'እዚ ገዛይ እዩ።',
      'እቲ ክሽነ ጽሩይ እዩ።',
      'እቲ ዓራት ልስሉስ እዩ።',
      'እቲ ማዕጾ ክፉት እዩ።',
    ],
    correctAnswer: 'እቲ ማዕጾ ክፉት እዩ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s032.mp3',
  ),

  Question(
    id: 'q3_023',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'እቲ ማዕጾ ክፉት እዩ።',
      'እቲ ጠረጴዛ ዓቢ እዩ።',
      'እቲ መሬት ትርኩስ እዩ።',
      'እቲ ክሽነ ጽሩይ እዩ።',
    ],
    correctAnswer: 'እቲ ክሽነ ጽሩይ እዩ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s034.mp3',
  ),

  Question(
    id: 'q3_024',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'እቲ መንበር ሰባር ኢዩ።',
      'እቲ ዓራት ልስሉስ እዩ።',
      'እቲ ክሽነ ጽሩይ እዩ።',
      'እቲ ጠረጴዛ ዓቢ እዩ።',
    ],
    correctAnswer: 'እቲ ጠረጴዛ ዓቢ እዩ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s036.mp3',
  ),

  Question(
    id: 'q3_025',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'ኣነ ነቲ መሬት የጽሪ።',
      'እቲ መሬት ትርኩስ እዩ።',
      'እቲ ዓራት ልስሉስ እዩ።',
      'በጃኹም ኮፍ በሉ።',
    ],
    correctAnswer: 'እቲ ዓራት ልስሉስ እዩ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s042.mp3',
  ),

  Question(
    id: 'q3_026',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'እቲ ዓራት ልስሉስ እዩ።',
      'እቲ ናሕሲ ድልዱል እዩ።',
      'መብራህቲ ኣጥፍእዎ።',
      'በጃኹም ኮፍ በሉ።',
    ],
    correctAnswer: 'በጃኹም ኮፍ በሉ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s040.mp3',
  ),

  // ══════════════════════════════════════════════════════════════════════════
  // FOOD & DRINK  (s046–s065)
  // ══════════════════════════════════════════════════════════════════════════

  Question(
    id: 'q3_027',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'ጸሚአ ኣለኹ።',
      'እቲ መግቢ ጥዑም እዩ።',
      'ማይ እሰቲ እየ።',
      'ጠሚየ ኣለኹ።',
    ],
    correctAnswer: 'ጠሚየ ኣለኹ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s046.mp3',
  ),

  Question(
    id: 'q3_028',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'ጠሚየ ኣለኹ።',
      'ማይ እሰቲ እየ።',
      'እቲ ጸባ ዝሑል እዩ።',
      'ጸሚአ ኣለኹ።',
    ],
    correctAnswer: 'ጸሚአ ኣለኹ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s047.mp3',
  ),

  Question(
    id: 'q3_029',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'ሕብስቲ እበልዕ።',
      'ጠሚየ ኣለኹ።',
      'እቲ ጸብሒ ውዑይ እዩ።',
      'እቲ መግቢ ጥዑም እዩ።',
    ],
    correctAnswer: 'እቲ መግቢ ጥዑም እዩ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s048.mp3',
  ),

  Question(
    id: 'q3_030',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'ጸሚአ ኣለኹ።',
      'እቲ ጸባ ዝሑል እዩ።',
      'ሕብስቲ እበልዕ።',
      'ማይ እሰቲ እየ።',
    ],
    correctAnswer: 'ማይ እሰቲ እየ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s049.mp3',
  ),

  Question(
    id: 'q3_031',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'ማይ እሰቲ እየ።',
      'እቲ ጸባ ዝሑል እዩ።',
      'ቡን እፈቱ እየ።',
      'ሕብስቲ እበልዕ።',
    ],
    correctAnswer: 'ሕብስቲ እበልዕ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s050.mp3',
  ),

  Question(
    id: 'q3_032',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'ኢንጀራ ንበልዕ።',
      'ቡን እፈቱ እየ።',
      'ንሳ ጽሟቕ ትሰቲ።',
      'እቲ ጸባ ዝሑል እዩ።',
    ],
    correctAnswer: 'እቲ ጸባ ዝሑል እዩ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s051.mp3',
  ),

  Question(
    id: 'q3_033',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'እቲ ጸባ ዝሑል እዩ።',
      'ሻሂ ኣለና።',
      'ንሳ ጽሟቕ ትሰቲ።',
      'ቡን እፈቱ እየ።',
    ],
    correctAnswer: 'ቡን እፈቱ እየ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s053.mp3',
  ),

  Question(
    id: 'q3_034',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'ቡን እፈቱ እየ።',
      'እቲ ጸብሒ ውዑይ እዩ።',
      'ሩዝ ትሰርሕ።',
      'ኢንጀራ ንበልዕ።',
    ],
    correctAnswer: 'ኢንጀራ ንበልዕ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s054.mp3',
  ),

  Question(
    id: 'q3_035',
    prompt: '🔊 ድምጺ ስምዑ ፡ ዝሰማዕክምዎ ምሉእ ሓሳብ ምረጹ።',
    type: QuestionType.multipleChoice,
    options: [
      'ኢንጀራ ንበልዕ።',
      'እቲ ኣራንሺ ጥዑም እዩ።',
      'ንሳ ጽሟቕ ትሰቲ።',
      'እቲ ጸብሒ ውዑይ እዩ።',
    ],
    correctAnswer: 'እቲ ጸብሒ ውዑይ እዩ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s055.mp3',
  ),

  Question(
    id: 'q3_036',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ኣሕምልቲ ትገዝእ።',
      'ቱፋሕ እበልዕ።',
      'ኣነ ባናናታት እፈቱ።',
      'እቲ ዓሳ ሓድሽ ኢዩ።',
    ],
    correctAnswer: 'ኣሕምልቲ ትገዝእ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s057.mp3',
  ),

  // ══════════════════════════════════════════════════════════════════════════
  // BODY & HEALTH  (s066–s080)
  // ══════════════════════════════════════════════════════════════════════════

  Question(
    id: 'q3_037',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ሕቖይ የሕምመኒ።',
      'ረስኒ ኣለኒ።',
      'እግረይ ተሰቢራ።',
      'ርእሰይ የሕምመኒ።',
    ],
    correctAnswer: 'ርእሰይ የሕምመኒ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s066.mp3',
  ),

  Question(
    id: 'q3_038',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ርእሰይ የሕምመኒ።',
      'ሓሚሙ ኣሎ።',
      'ኣነ መድሃኒት እወስድ።',
      'ረስኒ ኣለኒ።',
    ],
    correctAnswer: 'ረስኒ ኣለኒ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s067.mp3',
  ),

  Question(
    id: 'q3_039',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ረስኒ ኣለኒ።',
      'ኣስናና ተጽሪ።',
      'ኣነ መድሃኒት እወስድ።',
      'ኣእዳወይ እሕጸብ።',
    ],
    correctAnswer: 'ኣእዳወይ እሕጸብ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s068.mp3',
  ),

  Question(
    id: 'q3_040',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ናብ ሓኪም እኸይድ።',
      'ኣነ መድሃኒት እወስድ።',
      'ሓሚሙ ኣሎ።',
      'እግረይ ተሰቢራ።',
    ],
    correctAnswer: 'ሓሚሙ ኣሎ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s070.mp3',
  ),

  Question(
    id: 'q3_041',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ሓሚሙ ኣሎ።',
      'ኣነ መድሃኒት እወስድ።',
      'እግረይ ተሰቢራ።',
      'ናብ ሓኪም እኸይድ።',
    ],
    correctAnswer: 'ናብ ሓኪም እኸይድ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s071.mp3',
  ),

  Question(
    id: 'q3_042',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ንግሆ ንግሆ እጎዪ።',
      'ሕቖይ የሕምመኒ።',
      'ድልዱል ቅልጽም ኣለዎ።',
      'ኣነ መድሃኒት እወስድ።',
    ],
    correctAnswer: 'ኣነ መድሃኒት እወስድ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s073.mp3',
  ),

  Question(
    id: 'q3_043',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ሸሞንተ ሰዓት እየ ዝድቅስ።',
      'ሓጺር ጸጉሪ ኣለዎ።',
      'ሕጂ ጽቡቕ ይስምዓ ኣሎ።',
      'ንግሆ ንግሆ እጎዪ።',
    ],
    correctAnswer: 'ንግሆ ንግሆ እጎዪ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s075.mp3',
  ),

  Question(
    id: 'q3_044',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ንግሆ ንግሆ እጎዪ።',
      'ሕጂ ጽቡቕ ይስምዓ ኣሎ።',
      'ሓጺር ጸጉሪ ኣለዎ።',
      'ሸሞንተ ሰዓት እየ ዝድቅስ።',
    ],
    correctAnswer: 'ሸሞንተ ሰዓት እየ ዝድቅስ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s079.mp3',
  ),

  // ══════════════════════════════════════════════════════════════════════════
  // NUMBERS & COLORS  (s081–s095)
  // ══════════════════════════════════════════════════════════════════════════

  Question(
    id: 'q3_045',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ሓሙሽተ ኣዕዋፍ ኣለዋ።',
      'ዓሰርተ መጻሕፍቲ ኣለዋ።',
      'ዓሰርተ ክልተ ከዋኽብቲ ይርኢ ኣለኹ።',
      'ሰለስተ ደማሙ ይርኢ ኣለኹ።',
    ],
    correctAnswer: 'ሰለስተ ደማሙ ይርኢ ኣለኹ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s081.mp3',
  ),

  Question(
    id: 'q3_046',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ሰለስተ ደማሙ ይርኢ ኣለኹ።',
      'ዓሰርተ መጻሕፍቲ ኣለዋ።',
      'ዓሰርተ ክልተ ከዋኽብቲ ይርኢ ኣለኹ።',
      'ሓሙሽተ ኣዕዋፍ ኣለዋ።',
    ],
    correctAnswer: 'ሓሙሽተ ኣዕዋፍ ኣለዋ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s082.mp3',
  ),

  Question(
    id: 'q3_047',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ሰማይ ሰማያዊ እዩ።',
      'እቲ ሳዕሪ ቀጠልያ እዩ።',
      'ጸሓይ ብጫ እያ።',
      'እታ መኪና ቀያሕ እያ።',
    ],
    correctAnswer: 'ሰማይ ሰማያዊ እዩ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s084.mp3',
  ),

  Question(
    id: 'q3_048',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ሰማይ ሰማያዊ እዩ።',
      'እታ መኪና ቀያሕ እያ።',
      'እታ ድሙ ጸላም እያ።',
      'እቲ ሳዕሪ ቀጠልያ እዩ።',
    ],
    correctAnswer: 'እቲ ሳዕሪ ቀጠልያ እዩ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s085.mp3',
  ),

  Question(
    id: 'q3_049',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'እቲ ሳዕሪ ቀጠልያ እዩ።',
      'እታ መኪና ቀያሕ እያ።',
      'እቲ ዕምባባ ሮዛ እዩ።',
      'ጸሓይ ብጫ እያ።',
    ],
    correctAnswer: 'ጸሓይ ብጫ እያ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s086.mp3',
  ),

  Question(
    id: 'q3_050',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ጸሓይ ብጫ እያ።',
      'ጻዕዳ ክዳን ትኽደን።',
      'እታ ድሙ ጸላም እያ።',
      'እታ መኪና ቀያሕ እያ።',
    ],
    correctAnswer: 'እታ መኪና ቀያሕ እያ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s087.mp3',
  ),

  Question(
    id: 'q3_051',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'እታ መኪና ቀያሕ እያ።',
      'እቲ ዕምባባ ሮዛ እዩ።',
      'ክልተ ኣእዳው ኣለኒ።',
      'እታ ድሙ ጸላም እያ።',
    ],
    correctAnswer: 'እታ ድሙ ጸላም እያ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s089.mp3',
  ),

  // ══════════════════════════════════════════════════════════════════════════
  // TIME & DAYS  (s096–s110)
  // ══════════════════════════════════════════════════════════════════════════

  Question(
    id: 'q3_052',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ትማሊ ሰንበት ኔሩ።',
      'ኣብ ሰሙን ሸውዓተ መዓልታት ኣሎ።',
      'ኣንጊሀ እበራበር።',
      'ሎሚ ሰኑይ እዩ።',
    ],
    correctAnswer: 'ሎሚ ሰኑይ እዩ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s096.mp3',
  ),

  Question(
    id: 'q3_053',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ሎሚ ሰኑይ እዩ።',
      'ሕጂ ክረምቲ እዩ።',
      'ኣብ ሰሙን ሸውዓተ መዓልታት ኣሎ።',
      'ትማሊ ሰንበት ኔሩ።',
    ],
    correctAnswer: 'ትማሊ ሰንበት ኔሩ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s097.mp3',
  ),

  Question(
    id: 'q3_054',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ሕጂ ክረምቲ እዩ።',
      'ሎሚ ሰኑይ እዩ።',
      'እቲ ኣኼባ ኣብ ፍርቂ መዓልቲ እዩ።',
      'ሳዓት ሹድሽተ ኣሎ።',
    ],
    correctAnswer: 'ሳዓት ሹድሽተ ኣሎ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s098.mp3',
  ),

  Question(
    id: 'q3_055',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ኣብ ሓጋይ ውዑይ እዩ።',
      'ጽድያ ጽቡቕ እዩ።',
      'ሳዓት ሹድሽተ ኣሎ።',
      'ሕጂ ክረምቲ እዩ።',
    ],
    correctAnswer: 'ሕጂ ክረምቲ እዩ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s100.mp3',
  ),

  Question(
    id: 'q3_056',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ሕጂ ክረምቲ እዩ።',
      'ደንጉያ ትድቅስ።',
      'ዓመት ዓሰርተ ክልተ ኣዋርሕ ኣለዋ።',
      'ኣንጊሀ እበራበር።',
    ],
    correctAnswer: 'ኣንጊሀ እበራበር።',
    level: 3,
    audioPath: 'assets/audio/sentences/s101.mp3',
  ),

  Question(
    id: 'q3_057',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ሎሚ ዝናብ ይዘንብ ኣሎ።',
      'ትማሊ ምሸት ቁሪ ኔሩ።',
      'ኣብ ቀዳመ ሰንበት ነዕርፍ።',
      'ኣብ ሓጋይ ውዑይ እዩ።',
    ],
    correctAnswer: 'ኣብ ሓጋይ ውዑይ እዩ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s104.mp3',
  ),

  Question(
    id: 'q3_058',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ኣብ ሓጋይ ውዑይ እዩ።',
      'ትማሊ ምሸት ቁሪ ኔሩ።',
      'ጸሓይ ብምብራቕ ትበርቕ።',
      'ሎሚ ዝናብ ይዘንብ ኣሎ።',
    ],
    correctAnswer: 'ሎሚ ዝናብ ይዘንብ ኣሎ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s108.mp3',
  ),

  Question(
    id: 'q3_059',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ሎሚ ዝናብ ይዘንብ ኣሎ።',
      'ጸሓይ ብምብራቕ ትበርቕ።',
      'ኣብ ሓጋይ ውዑይ እዩ።',
      'ትማሊ ምሸት ቁሪ ኔሩ።',
    ],
    correctAnswer: 'ትማሊ ምሸት ቁሪ ኔሩ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s109.mp3',
  ),

  // ══════════════════════════════════════════════════════════════════════════
  // SCHOOL & LEARNING  (s111–s125)
  // ══════════════════════════════════════════════════════════════════════════

  Question(
    id: 'q3_060',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'እቲ መምህር ኣብ ሰሌዳ ይጽሕፍ።',
      'ኣነ መጽሓፍ የንብብ።',
      'ናብ ቤት ትምህርቲ ይኸይድ።',
      'እቲ ክፍሊ መሊኡ ኣሎ።',
    ],
    correctAnswer: 'ናብ ቤት ትምህርቲ ይኸይድ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s111.mp3',
  ),

  Question(
    id: 'q3_061',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ናብ ቤት ትምህርቲ ይኸይድ።',
      'ስእሊ ይስእል።',
      'ብብርዒ ትጽሕፍ።',
      'እቲ መምህር ኣብ ሰሌዳ ይጽሕፍ።',
    ],
    correctAnswer: 'እቲ መምህር ኣብ ሰሌዳ ይጽሕፍ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s112.mp3',
  ),

  Question(
    id: 'q3_062',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'እቲ መምህር ኣብ ሰሌዳ ይጽሕፍ።',
      'ስእሊ ይስእል።',
      'እቲ ክፍሊ መሊኡ ኣሎ።',
      'ኣነ መጽሓፍ የንብብ።',
    ],
    correctAnswer: 'ኣነ መጽሓፍ የንብብ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s113.mp3',
  ),

  Question(
    id: 'q3_063',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ሓድሽ ቃል እመሃር።',
      'ሎሚ ፈተና ኣለና።',
      'ንሳ ጽቡቕ ነጥቢ ትረክብ።',
      'ለይቲ የጽንዕ።',
    ],
    correctAnswer: 'ሎሚ ፈተና ኣለና።',
    level: 3,
    audioPath: 'assets/audio/sentences/s118.mp3',
  ),

  Question(
    id: 'q3_064',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ዕዮ ገዛ ንውድእ።',
      'ቤተ ንባብ ጸጥታ ኣለዎ።',
      'ለይቲ የጽንዕ።',
      'እንግሊዝኛ ጽቡቕ ጌራ ትዛረብ።',
    ],
    correctAnswer: 'ቤተ ንባብ ጸጥታ ኣለዎ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s122.mp3',
  ),

  // ══════════════════════════════════════════════════════════════════════════
  // ANIMALS  (s126–s140)
  // ══════════════════════════════════════════════════════════════════════════

  Question(
    id: 'q3_065',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'እታ ድሙ ጸባ ትሰቲ።',
      'ላም ጸባ ትህብ።',
      'እታ ዑፍ ትዝምር።',
      'እቲ ከልቢ ይነብሕ።',
    ],
    correctAnswer: 'እቲ ከልቢ ይነብሕ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s126.mp3',
  ),

  Question(
    id: 'q3_066',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'እቲ ከልቢ ይነብሕ።',
      'ላም ጸባ ትህብ።',
      'እታ ድሙ ጸባ ትሰቲ።',
      'እቲ ፈረስ ብቕልጡፍ ይጎዪ።',
    ],
    correctAnswer: 'እታ ድሙ ጸባ ትሰቲ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s127.mp3',
  ),

  Question(
    id: 'q3_067',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'እታ ድሙ ጸባ ትሰቲ።',
      'እታ ዑፍ ትዝምር።',
      'እቲ ፈረስ ብቕልጡፍ ይጎዪ።',
      'ላም ጸባ ትህብ።',
    ],
    correctAnswer: 'ላም ጸባ ትህብ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s128.mp3',
  ),

  Question(
    id: 'q3_068',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ላም ጸባ ትህብ።',
      'እታ ዑፍ ትዝምር።',
      'እቲ ፈረስ ብቕልጡፍ ይጎዪ።',
      'ኣንበሳ ሓያል እዩ።',
    ],
    correctAnswer: 'እታ ዑፍ ትዝምር።',
    level: 3,
    audioPath: 'assets/audio/sentences/s129.mp3',
  ),

  Question(
    id: 'q3_069',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'እታ ዑፍ ትዝምር።',
      'ዓሳ ይሕንብስ።',
      'እታ ጤል ሳዕሪ ትበልዕ።',
      'እቲ ፈረስ ብቕልጡፍ ይጎዪ።',
    ],
    correctAnswer: 'እቲ ፈረስ ብቕልጡፍ ይጎዪ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s130.mp3',
  ),

  Question(
    id: 'q3_070',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ሓርማዝ ገዚፍ እዩ።',
      'ኣንበሳ ሓያል እዩ።',
      'ዓሳ ይሕንብስ።',
      'እቲ ህበይ ኣብ ገረብ ይሓኩር።',
    ],
    correctAnswer: 'ኣንበሳ ሓያል እዩ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s133.mp3',
  ),

  Question(
    id: 'q3_071',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ኣንበሳ ሓያል እዩ።',
      'እቲ ገመል ኣብ ምድረበዳ ይኸይድ።',
      'ማንቲለ ንእሽቶ እያ።',
      'ሓርማዝ ገዚፍ እዩ።',
    ],
    correctAnswer: 'ሓርማዝ ገዚፍ እዩ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s135.mp3',
  ),

  Question(
    id: 'q3_072',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ሓርማዝ ገዚፍ እዩ።',
      'እቲ ህበይ ኣብ ገረብ ይሓኩር።',
      'እቲ ገመል ኣብ ምድረበዳ ይኸይድ።',
      'እታ እንቁርዖብ ትዘልል።',
    ],
    correctAnswer: 'እቲ ገመል ኣብ ምድረበዳ ይኸይድ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s138.mp3',
  ),

  // ══════════════════════════════════════════════════════════════════════════
  // NATURE & WEATHER  (s141–s155)
  // ══════════════════════════════════════════════════════════════════════════

  Question(
    id: 'q3_073',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ንፋስ ይነፍስ ኣሎ።',
      'እቲ እምባ በሪኽ እዩ።',
      'እቲ ፈለግ ነዊሕ እዩ።',
      'ጸሓይ ትበርቕ ኣላ።',
    ],
    correctAnswer: 'ጸሓይ ትበርቕ ኣላ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s141.mp3',
  ),

  Question(
    id: 'q3_074',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ንፋስ ይነፍስ ኣሎ።',
      'ጸሓይ ትበርቕ ኣላ።',
      'እቲ ፈለግ ነዊሕ እዩ።',
      'እቲ ባሕሪ ገፊሕ እዩ።',
    ],
    correctAnswer: 'ንፋስ ይነፍስ ኣሎ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s142.mp3',
  ),

  Question(
    id: 'q3_075',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'እቲ እምባ በሪኽ እዩ።',
      'እቲ ባሕሪ ገፊሕ እዩ።',
      'ንፋስ ይነፍስ ኣሎ።',
      'እቲ ፈለግ ነዊሕ እዩ።',
    ],
    correctAnswer: 'እቲ ፈለግ ነዊሕ እዩ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s143.mp3',
  ),

  Question(
    id: 'q3_076',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'እቲ ፈለግ ነዊሕ እዩ።',
      'እቲ ባሕሪ ገፊሕ እዩ።',
      'እቲ እምባ በሪኽ እዩ።',
      'እቲ ጫካ ሓምላይ እዩ።',
    ],
    correctAnswer: 'እቲ እምባ በሪኽ እዩ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s144.mp3',
  ),

  Question(
    id: 'q3_077',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'እቲ ደበና ጸልማት እዩ።',
      'ኣብ ክረምቲ በረድ ይኸውን።',
      'እቲ ዝናብ ህድእ ኢሉ ይዘንብ።',
      'ሎሚ ምሸት ወርሒ መሊኣ ወጺኣ ኣላ።',
    ],
    correctAnswer: 'እቲ ደበና ጸልማት እዩ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s148.mp3',
  ),

  Question(
    id: 'q3_078',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'እቲ ደበና ጸልማት እዩ።',
      'እቲ ምድረበዳ ደረቕ እዩ።',
      'እቲ ቀላይ ህዱእ እዩ።',
      'ኣብ ክረምቲ በረድ ይኸውን።',
    ],
    correctAnswer: 'ኣብ ክረምቲ በረድ ይኸውን።',
    level: 3,
    audioPath: 'assets/audio/sentences/s149.mp3',
  ),

  // ══════════════════════════════════════════════════════════════════════════
  // TRAVEL & TRANSPORT  (s156–s170)
  // ══════════════════════════════════════════════════════════════════════════

  Question(
    id: 'q3_079',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'እታ ነፋሪት ትዓልብ።',
      'ንሳ መኪና ትዝውር።',
      'እታ ባቡር ቅልጥፍቲ እያ።',
      'ኣውቶቡስ እየ ዝወስድ።',
    ],
    correctAnswer: 'ኣውቶቡስ እየ ዝወስድ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s156.mp3',
  ),

  Question(
    id: 'q3_080',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ንሳ መኪና ትዝውር።',
      'ኣውቶቡስ እየ ዝወስድ።',
      'ንሱ ብሽክለታ ይዝውር።',
      'እታ ባቡር ቅልጥፍቲ እያ።',
    ],
    correctAnswer: 'ንሳ መኪና ትዝውር።',
    level: 3,
    audioPath: 'assets/audio/sentences/s158.mp3',
  ),

  Question(
    id: 'q3_081',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ንሳ መኪና ትዝውር።',
      'እታ ባቡር ቅልጥፍቲ እያ።',
      'እታ መናሃርያ ዕልቕልቕ ዝበለት እያ።',
      'ንሱ ብሽክለታ ይዝውር።',
    ],
    correctAnswer: 'ንሱ ብሽክለታ ይዝውር።',
    level: 3,
    audioPath: 'assets/audio/sentences/s159.mp3',
  ),

  Question(
    id: 'q3_082',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ንሱ ብሽክለታ ይዝውር።',
      'ናብ ስራሕ ብእግረይ እኸይድ።',
      'እቲ ጽርግያ ነዊሕ እዩ።',
      'እታ ባቡር ቅልጥፍቲ እያ።',
    ],
    correctAnswer: 'እታ ባቡር ቅልጥፍቲ እያ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s160.mp3',
  ),

  Question(
    id: 'q3_083',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ናብ ስራሕ ብእግረይ እኸይድ።',
      'እታ ባቡር ቅልጥፍቲ እያ።',
      'ነቲ ድልድል ንሰግር።',
      'እቲ ጽርግያ ነዊሕ እዩ።',
    ],
    correctAnswer: 'ናብ ስራሕ ብእግረይ እኸይድ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s161.mp3',
  ),

  // ══════════════════════════════════════════════════════════════════════════
  // SHOPPING & MONEY  (s171–s183)
  // ══════════════════════════════════════════════════════════════════════════

  Question(
    id: 'q3_084',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ክቡር እዩ።',
      'ብጥረ ገንዘብ እየ ዝኸፍል።',
      'ሕሱር እዩ።',
      'ዋጋኣ ክንደይ እዩ፧',
    ],
    correctAnswer: 'ዋጋኣ ክንደይ እዩ፧',
    level: 3,
    audioPath: 'assets/audio/sentences/s171.mp3',
  ),

  Question(
    id: 'q3_085',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ዋጋኣ ክንደይ እዩ፧',
      'ሕሱር እዩ።',
      'ክቡር እዩ።',
      'ለውጢ የድልየኒ ኣሎ።',
    ],
    correctAnswer: 'ክቡር እዩ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s172.mp3',
  ),

  Question(
    id: 'q3_086',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ክቡር እዩ።',
      'ገንዘበይ እዕቅብ።',
      'ናብ ዕዳጋ ትኸይድ።',
      'ሕሱር እዩ።',
    ],
    correctAnswer: 'ሕሱር እዩ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s173.mp3',
  ),

  Question(
    id: 'q3_087',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ናብ ዕዳጋ ትኸይድ።',
      'ፍሩታታት ይሸይጥ።',
      'ለውጢ የድልየኒ ኣሎ።',
      'ሓድሽ ማልያ እገዝእ።',
    ],
    correctAnswer: 'ናብ ዕዳጋ ትኸይድ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s175.mp3',
  ),

  // ══════════════════════════════════════════════════════════════════════════
  // WORK & DAILY ROUTINE  (s184–s198)
  // ══════════════════════════════════════════════════════════════════════════

  Question(
    id: 'q3_088',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ንሱ ናብ ስራሕ ይኸይድ።',
      'ኣብ ቤት ጽሕፈት እየ ዝሰርሕ።',
      'ንሳ ነርስ እያ።',
      'ደኺመ ኣለኹ።',
    ],
    correctAnswer: 'ንሱ ናብ ስራሕ ይኸይድ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s186.mp3',
  ),

  Question(
    id: 'q3_089',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ንሱ ናብ ስራሕ ይኸይድ።',
      'ንሳ ነርስ እያ።',
      'ንሱ ሓረስታይ እዩ።',
      'ኣብ ቤት ጽሕፈት እየ ዝሰርሕ።',
    ],
    correctAnswer: 'ኣብ ቤት ጽሕፈት እየ ዝሰርሕ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s187.mp3',
  ),

  Question(
    id: 'q3_090',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ኣብ ቤት ጽሕፈት እየ ዝሰርሕ።',
      'ንሱ ሓረስታይ እዩ።',
      'ደኺመ ኣለኹ።',
      'ንሳ ነርስ እያ።',
    ],
    correctAnswer: 'ንሳ ነርስ እያ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s188.mp3',
  ),

  Question(
    id: 'q3_091',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ንሱ ሓረስታይ እዩ።',
      'ንሳ ነርስ እያ።',
      'ደኺመ ኣለኹ።',
      'ንሱ ሙዚቃ ይሰምዕ።',
    ],
    correctAnswer: 'ንሱ ሓረስታይ እዩ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s189.mp3',
  ),

  Question(
    id: 'q3_092',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ንሱ ሓረስታይ እዩ።',
      'ንሳ ተለቪዥን ትርኢ።',
      'ንሱ ሙዚቃ ይሰምዕ።',
      'ደኺመ ኣለኹ።',
    ],
    correctAnswer: 'ደኺመ ኣለኹ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s193.mp3',
  ),

  // ══════════════════════════════════════════════════════════════════════════
  // EMOTIONS & FEELINGS  (s199–s210)
  // ══════════════════════════════════════════════════════════════════════════

  Question(
    id: 'q3_093',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ሓዚና ኣላ።',
      'ንሱ ሓሪቑ ኣሎ።',
      'ሕጉስ እየ።',
      'ፈሪሐ ኣለኹ።',
    ],
    correctAnswer: 'ሕጉስ እየ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s199.mp3',
  ),

  Question(
    id: 'q3_094',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ሕጉስ እየ።',
      'ንሱ ሓሪቑ ኣሎ።',
      'ፈሪሐ ኣለኹ።',
      'ሓዚና ኣላ።',
    ],
    correctAnswer: 'ሓዚና ኣላ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s200.mp3',
  ),

  Question(
    id: 'q3_095',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ሓዚና ኣላ።',
      'ንሱ ሓሪቑ ኣሎ።',
      'ፈሪሐ ኣለኹ።',
      'ተሓጒሳ ኣላ።',
    ],
    correctAnswer: 'ንሱ ሓሪቑ ኣሎ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s201.mp3',
  ),

  Question(
    id: 'q3_096',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ኣሰልቺዩዎ ኣሎ።',
      'ተሓጒሳ ኣላ።',
      'ንሳ ትበኪ።',
      'ጽምዋ ይስምዓኒ።',
    ],
    correctAnswer: 'ጽምዋ ይስምዓኒ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s205.mp3',
  ),

  Question(
    id: 'q3_097',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ጽምዋ ይስምዓኒ።',
      'ንሱ ሕቡን እዩ።',
      'ንሳ ትበኪ።',
      'ብሓባር ንስሕቕ።',
    ],
    correctAnswer: 'ብሓባር ንስሕቕ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s210.mp3',
  ),

  // ══════════════════════════════════════════════════════════════════════════
  // COMMUNICATION & SOCIAL  (s261–s275)
  // ══════════════════════════════════════════════════════════════════════════

  Question(
    id: 'q3_098',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'በጃኹም ቀስ ኢልኩም ተዛረቡ።',
      'ኣይርድኣንን እዩ።',
      'በጃኹም ድገምዎ።',
      'ክትሕግዘኒ ትኽእል ዲኻ፧',
    ],
    correctAnswer: 'በጃኹም ቀስ ኢልኩም ተዛረቡ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s261.mp3',
  ),

  Question(
    id: 'q3_099',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'በጃኹም ቀስ ኢልኩም ተዛረቡ።',
      'በጃኹም ድገምዎ።',
      'ክትሕግዘኒ ትኽእል ዲኻ፧',
      'ኣይርድኣንን እዩ።',
    ],
    correctAnswer: 'ኣይርድኣንን እዩ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s262.mp3',
  ),

  Question(
    id: 'q3_100',
    prompt: '🔊 ድምጺ ስምዕ — ቅኑዕ ትርጉም ምረጽ።',
    type: QuestionType.multipleChoice,
    options: [
      'ይቕሬታ።',
      'ጸገም የለን።',
      'ገንዘብካ።',
      'ብጣዕሚ የቅንየለይ።',
    ],
    correctAnswer: 'ብጣዕሚ የቅንየለይ።',
    level: 3,
    audioPath: 'assets/audio/sentences/s264.mp3',
  ),
];
 
// Level 4 Quiz - Paragraphs (100 questions)
final List<Question> level4QuizData = [
  Question(id: 'q4_001', context: 'ኣነን ስድራ ቤተይን', prompt: 'ኣብ ስድራ ቤት ዮሃንስ ክንደይ ሰብ ኣሎ፧', type: QuestionType.multipleChoice, options: ['ሰለስተ', 'ኣርባዕተ', 'ሓሙሽተ', 'ሽዱሽተ'], correctAnswer: 'ሓሙሽተ', level: 4),
  Question(id: 'q4_002', context: 'ኤርትራ', prompt: 'ርእሰ ከተማ ኤርትራ መን ኢያ፧', type: QuestionType.multipleChoice, options: ['ከረን', 'ምጽዋዕ', 'ኣስመራ', 'ዓዲ ቐይሕ'], correctAnswer: 'ኣስመራ', level: 4),
  Question(id: 'q4_003', context: 'ቤት ትምህርቲ', prompt: 'ቤት ትምህርቲ ምንታይ ዓይነት ቦታ እዩ፧', type: QuestionType.multipleChoice, options: ['ምብላዕ', 'ምምሃርን ምስትምሃርን', 'ምዝናይ', 'ምሕካም'], correctAnswer: 'ምምሃርን ምስትምሃርን', level: 4),
  // p001 - ኣነ ን ስድራ ቤተይ
  Question(id: 'pq001', context: 'ኣነን ስድራ ቤተይን', prompt: '"ኣነን ስድራ ቤተይን" መን ጽሒፍዋ፧', type: QuestionType.multipleChoice, options: ['ዮሃንስ', 'ተስፋ', 'ሚካኤል', 'ሃብቶም'], correctAnswer: 'ዮሃንስ', level: 4),
  Question(id: 'pq002', context: 'ኣነን ስድራ ቤተይን', prompt: 'ኣቦ ናይ ዮሃንስ እንታይ ይሰርሕ፧', type: QuestionType.multipleChoice, options: ['ሓኪም', 'መምህር', 'ነጋዳይ', 'ሓረስታይ'], correctAnswer: 'መምህር', level: 4),
  Question(id: 'pq003', context: 'ኣነን ስድራ ቤተይን', prompt: 'ኣደ ናይ ዮሃንስ እንታይ ትሰርሕ፧', type: QuestionType.multipleChoice, options: ['መምህር', 'ነጋዲት', 'ነርስ', 'ሓረስታይ'], correctAnswer: 'ነርስ', level: 4),
  Question(id: 'pq004', context: 'ኣነን ስድራ ቤተይን', prompt: 'ኣብ ስድራ ቤት ዮሃንስ ክንደይ ሰብ ኣሎ፧', type: QuestionType.multipleChoice, options: ['ሰለስተ', 'ኣርባዕተ', 'ሓሙሽተ', 'ሽዱሽተ'], correctAnswer: 'ሓሙሽተ', level: 4),
  Question(id: 'pq005', context: 'ኣነን ስድራ ቤተይን', prompt: 'ስድራ ቤት ዮሃንስ ብምንታይ ዝተመልአት ኢያ፧', type: QuestionType.multipleChoice, options: ['ሓዘንን ጸገምን', 'ሓጎስን ፍቕርን', 'ሰላምን ቃልስን', 'ጥዕናን ሃብትን'], correctAnswer: 'ሓጎስን ፍቕርን', level: 4),
 
  // p002 - ቤት ትምህርቲ
  Question(id: 'pq006', context: 'ቤት ትምህርቲ', prompt: 'ቤት ትምህርቲ እንታይ ዓይነት ቦታ እዩ፧', type: QuestionType.multipleChoice, options: ['ምጽዋት ዝካየደሉ', 'ምምሃርን ምስትምሃርን ዝካየደሉ', 'ምስራሕ ዝካየደሉ', 'ምብላዕ ዝካየደሉ'], correctAnswer: 'ምምሃርን ምስትምሃርን ዝካየደሉ', level: 4),
  Question(id: 'pq007', context: 'ቤት ትምህርቲ', prompt: 'ቆልዑ ኣብ ቤት ትምህርቲ እንታይ ይማሃሩ፧', type: QuestionType.multipleChoice, options: ['ምዝማር ጥራይ', 'ምጽዋት ጥራይ', 'ንባብ፡ ምጽሓፍ፡ ቁጽሪን', 'ምሕካም ጥራይ'], correctAnswer: 'ንባብ፡ ምጽሓፍ፡ ቁጽሪን', level: 4),
  Question(id: 'pq008', context: 'ቤት ትምህርቲ', prompt: "ኣብ ቤት ምህርቲ ኣገዳሲ ሰብ መን ኢዩ፧ ", type: QuestionType.multipleChoice, options: ['ተመሃራይ ', "መመህር ", "ወላዲ ", "ዳይረክተር "], correctAnswer:"መመህር ", level :4),
  // Question(id : "pq009", context : "ቤት ትምህርቲ", prompt : "ቤት 𝉵ምህርቲ ኣብ 𝌠ግና ", type :QuestionType.trueOrFalse , options : ["ቅኑዕ", "ጌጋ"], correctAnswer : "ቅኑዕ", level :4),
  // Question(id : "pq010", context : "ቤት ትምህርቲ", prompt : "ቤት 𝉵ምህርቲ 𝌠ብ 𝌠ግና ", type :QuestionType.trueOrFalse , options : ["ቅኑዕ", "ጌጋ"], correctAnswer : "ጌጋ", level :4),

  // p003 - ኤርትራ 
  Question(id: 'pq011', context: 'ኤርትራ', prompt: 'ኤርትራ ኣበይ ትርከብ፧', type: QuestionType.multipleChoice, options: ['ምዕራብ ኣፍሪቃ', 'ደቡብ ኣፍሪቃ', 'ቀርኒ ኣፍሪቃ', 'ሰሜን ኣፍሪቃ'], correctAnswer: 'ቀርኒ ኣፍሪቃ', level: 4),
  Question(id: 'pq012', context: 'ኤርትራ', prompt: 'ርእሰ ከተማ ኤርትራ መን ኢያ፧', type: QuestionType.multipleChoice, options: ['ከረን', 'ምጽዋዕ', 'ኣስመራ', 'ዓዲ ቐይሕ'], correctAnswer: 'ኣስመራ', level: 4),
  Question(id: 'pq013', context: 'ኤርትራ', prompt: 'ቀይሕ ባሕሪ ኣበይ ወገን ናይ ኤርትራ ይርከብ፧', type: QuestionType.multipleChoice, options: ['ምዕራብ', 'ሰሜን', 'ደቡብ', 'ምብራቕ'], correctAnswer: 'ምብራቕ', level: 4),
  Question(id: 'pq014', context: 'ኤርትራ', prompt: 'ኤርትራ ምስ ኢትዮጵያ ትዳወብ ኢያ።', type: QuestionType.trueOrFalse, options: ['ቅኑዕ', 'ጌጋ'], correctAnswer: 'ቅኑዕ', level: 4),
  Question(id: 'pq015', context: 'ኤርትራ', prompt: 'ህዝቢ ኤርትራ ሰላምን ሓርነትን ይፈቱ።', type: QuestionType.trueOrFalse, options: ['ቅኑዕ', 'ጌጋ'], correctAnswer: 'ቅኑዕ', level: 4),
 
  // p004 - ጸባ
  Question(id: 'pq016', context: 'ጸባ', prompt: 'ጸባ ዝህቡና እንስሳታት በዓል መን እዮም?', type: QuestionType.multipleChoice, options: ['ድሙ', 'ላም', 'ዓሳ', 'ኣዕዋፍ'], correctAnswer: 'ላም', level: 4),
  Question(id: 'pq017', context: 'ጸባ', prompt: 'ጸባ እንታይ ሕብሪ ኣለዎ?', type: QuestionType.multipleChoice, options: ['ቀይሕ', 'ሰማያዊ', 'ጻዕዳ', 'ቢጫ'], correctAnswer: 'ጻዕዳ', level: 4),
  Question(id: 'pq018', context: 'ጸባ', prompt: 'ኣብ ጸባ ዘሎ ኣዕጽምትና ንኽድልድል ዝሕግዝ መኣዛ እንታይ እዩ?', type: QuestionType.multipleChoice, options: ['ቫይታሚን C', 'ፕሮቲን', 'ካልሲየም', 'ኣይሮን'], correctAnswer: 'ካልሲየም', level: 4),
  Question(id: 'pq019', context: 'ጸባ', prompt: 'ጸባ ዘይፈትዉ ሰባት ኣብ ክንድኡ እንታይ ይሰትዩ?', type: QuestionType.multipleChoice, options: ['ጽሟቕ', 'ካብ ኣልሞንድ ወይ ሶያ ዝተሰርሐ ጸባ', 'ቡን', 'ማይ ጥራይ'], correctAnswer: 'ካብ ኣልሞንድ ወይ ሶያ ዝተሰርሐ ጸባ', level: 4),
  Question(id: 'pq020', context: 'ጸባ', prompt: 'ስለምንታይ እዮም ገሊኦም ሰባት ቅድሚ ምድቃሶም ውዑይ ጸባ ዝሰትዩ?', type: QuestionType.multipleChoice, options: ['ንምሕዋይ ሕማም', 'ጽቡቕ ድቃስ ክድቅሱ', 'ንምጽዋት', 'ጥሜት ስለዝስምዖም'], correctAnswer: 'ጽቡቕ ድቃስ ክድቅሱ', level: 4),
  Question(id: 'pq021', context: 'ጸባ', prompt: 'ሰባት ጸባ ካብ ዝሰትዩ ክንደይ ግዜ ኮይኑ?', type: QuestionType.multipleChoice, options: ['ሒደት ዓመታት', 'ዓሰርተ ዓመታት', 'ሚእቲ ዓመታት', 'ኣዝዩ ነዊሕ እዋን'], correctAnswer: 'ኣዝዩ ነዊሕ እዋን', level: 4),

// p005 - ርሳስ
  Question(id: 'pq022', context: 'ርሳስ', prompt: 'ርሳስ እንታይ ይጠቅም?', type: QuestionType.multipleChoice, options: ['ንምህሳስ', 'ንመጽሓፍን ምስኣልን', 'ንምቁራጽ', 'ንምዕጻው'], correctAnswer: 'ንመጽሓፍን ምስኣልን', level: 4),
  Question(id: 'pq023', context: 'ርሳስ', prompt: 'ቅርጺ ርሳስ ኸመይ እዩ?', type: QuestionType.multipleChoice, options: ['ሓጺርን ሰፊሕን', 'ነዊሕን ቀጢንን', 'ከቢብን ዓቢን', 'ሸሊሕን ጸፊሕን'], correctAnswer: 'ነዊሕን ቀጢንን', level: 4),
  Question(id: 'pq024', context: 'ርሳስ', prompt: 'ርሳስ ዝስራሕ ካብ ምንታይ እዩ?', type: QuestionType.multipleChoice, options: ['ካብ ሓጺን', 'ካብ ፕላስቲክ', 'ካብ ዕንጨይቲ', 'ካብ እምኒ'], correctAnswer: 'ካብ ዕንጨይቲ', level: 4),
  Question(id: 'pq025', context: 'ርሳስ', prompt: 'ክትጽሕፍ ወይ ክትስእል ከለኻ ርሳስ ብኸመይ ትሕዝ?', type: QuestionType.multipleChoice, options: ['ኣብ ላዕሊ ብኣርባዕተ ኣጻብዕቲ', 'ኣብ ታሕቲ ብሰለስተ ኣጻብዕቲ', 'ኣብ ማእከል ብሓንቲ ኣጻብዕቲ', 'ብኩሎም ኣጻብዕቲ'], correctAnswer: 'ኣብ ታሕቲ ብሰለስተ ኣጻብዕቲ', level: 4),
  Question(id: 'pq026', context: 'ርሳስ', prompt: 'ኣየናይ ክፋል ናይ ርሳስ እዩ በሊሕን ንምጽሓፍ ዝውዕልን?', type: QuestionType.multipleChoice, options: ['ርእሲ ርሳስ', 'ማእከል ርሳስ', 'ታሕቲ ርሳስ', 'መደምሰስ'], correctAnswer: 'ታሕቲ ርሳስ', level: 4),
  Question(id: 'pq027', context: 'ርሳስ', prompt: 'ርሳስ እንተ ጎዲሙ እንታይ ጌርካ ተብልሖ?', type: QuestionType.multipleChoice, options: ['ሓድሽ ርሳስ ትገዝእ', 'ብካራ ትጸርቦ', 'መጽረብ ጌርካ ተብልሖ', 'ኣብ ማይ ትኣልኮ'], correctAnswer: 'መጽረብ ጌርካ ተብልሖ', level: 4),
  Question(id: 'pq028', context: 'ርሳስ', prompt: 'መደምሰስ ናይ ርሳስ ኣበይ ንረኽቦ?', type: QuestionType.multipleChoice, options: ['ኣብ ታሕቲ ርሳስ', 'ኣብ ማእከል ርሳስ', 'ኣብ ላዕሊ ወይ ርእሲ ርሳስ', 'ኣብ ጎድኒ ርሳስ'], correctAnswer: 'ኣብ ላዕሊ ወይ ርእሲ ርሳስ', level: 4),
  Question(id: 'pq029', context: 'ርሳስ', prompt: 'መደምሰስ ንምንታይ ንጥቀመሉ?', type: QuestionType.multipleChoice, options: ['ንምጽሓፍ', 'ዝጻሓፍናዮ ነገር ክንቅይሮ ወይ ክንኣልዩ', 'ርሳስ ክነጽርብ', 'ንምስኣል'], correctAnswer: 'ዝጻሓፍናዮ ነገር ክንቅይሮ ወይ ክንኣልዩ', level: 4),
  Question(id: 'pq030', context: 'ርሳስ', prompt: 'ርሳስ ኣብ ቦርሳኻ ክትስከሞ ቀሊል ዝዀነ ስለምንታይ እዩ?', type: QuestionType.multipleChoice, options: ['ክቡር ስለዘይኮነ', 'ነዊሕን ቀጢንን ስለዝኾነ', 'ብዙሕ ዓይነት ሕብሪ ስለዘለዎ', 'ኩሉ ሰብ ዝፈልጦ ስለዝኾነ'], correctAnswer: 'ነዊሕን ቀጢንን ስለዝኾነ', level: 4),


 // p006 - ማይ
  Question(id: 'pq031', context: 'ማይ', prompt: 'ማይ እንታይ ሕብሪ ኣለዎ?', type: QuestionType.multipleChoice, options: ['ጻዕዳ', 'ሰማያዊ', 'ሕብሪ የብሉን', 'ቢጫ'], correctAnswer: 'ሕብሪ የብሉን', level: 4),
  Question(id: 'pq032', context: 'ማይ', prompt: 'ቀንዲ ኣካላትና ዘቖመ እንታይ እዩ?', type: QuestionType.multipleChoice, options: ['ዘይቲ', 'ማይ', 'ጠስሚ', 'ደም'], correctAnswer: 'ማይ', level: 4),
  Question(id: 'pq033', context: 'ማይ', prompt: 'ማይ ካበይ ክንረኽቦ ንኽእል?', type: QuestionType.multipleChoice, options: ['ካብ እንስሳ', 'ካብ ዒላ፥ ሩባ፥ ቀላይ፥ ባሕሪ፥ ውቅያኖስ', 'ካብ ሰማይ ጥራይ', 'ካብ ተኽሊ'], correctAnswer: 'ካብ ዒላ፥ ሩባ፥ ቀላይ፥ ባሕሪ፥ ውቅያኖስ', level: 4),
  Question(id: 'pq034', context: 'ማይ', prompt: 'ማይ ኣዝዩ እንተ ዝሒሉ ናብ እንታይ ይቕየር?', type: QuestionType.multipleChoice, options: ['ናብ ሃፋ', 'ናብ ዘይቲ', 'ናብ በረድ', 'ናብ ጭቃ'], correctAnswer: 'ናብ በረድ', level: 4),
  Question(id: 'pq035', context: 'ማይ', prompt: 'ማይ ኣዝዩ እንተ ውዕዩ ናብ እንታይ ይቕየር?', type: QuestionType.multipleChoice, options: ['ናብ በረድ', 'ናብ ሃፋ', 'ናብ ዘይቲ', 'ናብ ጭቃ'], correctAnswer: 'ናብ ሃፋ', level: 4),
  Question(id: 'pq036', context: 'ማይ', prompt: 'ማይ ንሰብ ብኸምዚ ዝስዕብ ይጠቕሞ፦', type: QuestionType.multipleChoice, options: ['ጥዕና ይህብ፣ ምብሳልን ምጽራይን ይሕግዝ', 'ንምሳሕ ጥራይ', 'ንምጽዋት ጥራይ', 'ክቡር ስለዝኾነ'], correctAnswer: 'ጥዕና ይህብ፣ ምብሳልን ምጽራይን ይሕግዝ', level: 4),
  Question(id: 'pq037', context: 'ማይ', prompt: 'ማይ ንኣትክልትን ንእንስሳታትን ኣገዳሲ እዩ።', type: QuestionType.trueOrFalse, options: ['ሓቂ', 'ሓሶት'], correctAnswer: 'ሓቂ', level: 4),
  Question(id: 'pq038', context: 'ማይ', prompt: 'ዓሳ ኣበይ ይነብር?', type: QuestionType.multipleChoice, options: ['ኣብ ምድረበዳ', 'ኣብ ምድሪ', 'ኣብ ማይ', 'ኣብ ሰማይ'], correctAnswer: 'ኣብ ማይ', level: 4),
  Question(id: 'pq039', context: 'ማይ', prompt: 'ንተኽልታት ማይ ንምንታይ የድልዮም?', type: QuestionType.multipleChoice, options: ['ንኽነቕጹ', 'ንኽዓብዩ', 'ንኸጽልሉ', 'ንክኣርጉ'], correctAnswer: 'ንኽዓብዩ', level: 4),

  // p007 - ሕብሪ
  Question(id: 'pq040', context: 'ሕብሪ', prompt: 'ሕብርታት ንዓለምና ብኸመይ ይጸልዋ?', type: QuestionType.multipleChoice, options: ['ጸልማት ይገብሩዋ', 'ጽብቕቲ ይገብሩዋ', 'ዝኸፍአ ይገብሩዋ', 'ዝሓሸ ኣይገብርዋን'], correctAnswer: 'ጽብቕቲ ይገብሩዋ', level: 4),
  Question(id: 'pq041', context: 'ሕብሪ', prompt: 'ቀይሕ ሕብሪ ምስ ምንታይ ይተሓሓዝ?', type: QuestionType.multipleChoice, options: ['ሓዘን', 'ቍጥዐ', 'ፍቕሪ', 'ፍርሒ'], correctAnswer: 'ፍቕሪ', level: 4),
  Question(id: 'pq042', context: 'ሕብሪ', prompt: 'ሰማያዊ ሕብሪ ንስምዒትና ብኸመይ ይጸልዎ?', type: QuestionType.multipleChoice, options: ['ቍጥዐ ይፈጥር', 'ሓዘን ይፈጥር', 'ህድኣትን ሰላምን ክስምዓና ይገብር', 'ፍርሒ ይፈጥር'], correctAnswer: 'ህድኣትን ሰላምን ክስምዓና ይገብር', level: 4),
  Question(id: 'pq043', context: 'ሕብሪ', prompt: 'ቀጠልያ ሕብሪ እንታይ እዩ ዘመልክት?', type: QuestionType.multipleChoice, options: ['ፍቕርን ሓዘንን', 'ቍጥዐን ፍርሕን', 'ተፈጥሮን ዕብየትን', 'ሰላምን ውግእን'], correctAnswer: 'ተፈጥሮን ዕብየትን', level: 4),
  Question(id: 'pq044', context: 'ሕብሪ', prompt: 'ሕብርታት ኣብ ስነጥበብ ንምንታይ ይጥቀሙ?', type: QuestionType.multipleChoice, options: ['ንምብሳል', 'ስምዒታት ንምግላጽ', 'ንምሓዝ', 'ንምጽዋት'], correctAnswer: 'ስምዒታት ንምግላጽ', level: 4),
  Question(id: 'pq045', context: 'ሕብሪ', prompt: 'ኩሎም ሰባት ሓደ ዓይነት ዝፈትውዎ ሕብሪ ኣለዎም።', type: QuestionType.trueOrFalse, options: ['ሓቂ', 'ሓሶት'], correctAnswer: 'ሓሶት', level: 4),
  Question(id: 'pq046', context: 'ሕብሪ', prompt: 'ህድኣትን ሰላምን ከም ዝስምዓካ ዝገብር ሕብሪ ኣየናይ እዩ?', type: QuestionType.multipleChoice, options: ['ቀይሕ', 'ቀጠልያ', 'ሰማያዊ', 'ቢጫ'], correctAnswer: 'ሰማያዊ', level: 4),

// p008 - ኣንበሳ
  Question(id: 'pq047', context: 'ኣንበሳ', prompt: 'ኣናብስ ብብዝሒ ኣብ ኣየነይቲ ኣህጉር እዮም ዝነብሩ?', type: QuestionType.multipleChoice, options: ['ኤስያ', 'ኣውሮጳ', 'ኣፍሪቃ', 'ኣሜሪካ'], correctAnswer: 'ኣፍሪቃ', level: 4),
  Question(id: 'pq048', context: 'ኣንበሳ', prompt: 'መን እዩ ብኣካል ዝዓበየ — ተባዕታይ ድዩ ወይስ ኣንስተይቲ ኣንበሳ?', type: QuestionType.multipleChoice, options: ['ኣንስተይቲ ኣንበሳ', 'ተባዕታይ ኣንበሳ', 'ማዕረ ግዝፊ ኣለዎም', 'መን ከምዝዓቢ ክትፈልጥ ኣይካኣልን'], correctAnswer: 'ተባዕታይ ኣንበሳ', level: 4),
  Question(id: 'pq049', context: 'ኣንበሳ', prompt: 'ኣናብስ ካብቶም ዝበልዕዎም እንስሳታት ኣየኖት እዮም?', type: QuestionType.multipleChoice, options: ['ዓሳን ዑፍን', 'ኣድጊ በረኻን ላምን', 'ሓሰማን ኣናጹን', 'ሓራምዝን ኣናብርን'], correctAnswer: 'ኣድጊ በረኻን ላምን', level: 4),
  Question(id: 'pq050', context: 'ኣንበሳ', prompt: 'ኣናብስ ኣብ ነንሕድሕዶም ብኸምዚ ይረዳድኡ፦', type: QuestionType.multipleChoice, options: ['ብምጽሓፍ', 'ዓው ኢሎም ብምንቃው', 'ብምዝማር', 'ብምስኣል'], correctAnswer: 'ዓው ኢሎም ብምንቃው', level: 4),
  Question(id: 'pq051', context: 'ኣንበሳ', prompt: 'ምስ ኣናብስ ዝተሓሓዝ ባህርያት ኣየናይ እዩ?', type: QuestionType.multipleChoice, options: ['ድኻምን ፍርሕን', 'ህድኣትን ስቕታን', 'ሓይልን ትብዓትን', 'ዝይቅኑዕነትን ዛሕልን'], correctAnswer: 'ሓይልን ትብዓትን', level: 4),
  Question(id: 'pq052', context: 'ኣንበሳ', prompt: 'ቁጽሪ ኣናብስ ኣብ ዓለም ይውስኽ ድዩ ወይስ ይጎድል?', type: QuestionType.multipleChoice, options: ['ይውስኽ', 'ማዕረ ይቕጽል', 'እንዳዋሓደ ይኸይድ', 'ቀዋሚ ኢዩ'], correctAnswer: 'እንዳዋሓደ ይኸይድ', level: 4),

// p009 - መጽሓፍ ቅዱስ
  Question(id: 'pq053', context: 'መጽሓፍ ቅዱስ', prompt: 'መጽሓፍ ቅዱስ ከም ቅድስቲ መጽሓፎም ዝቖጽርዎ መን እዮም?', type: QuestionType.multipleChoice, options: ['ምስልምና', 'ክርስትያናት', 'ቡዲስታት', 'ሂንዱታት'], correctAnswer: 'ክርስትያናት', level: 4),
  Question(id: 'pq054', context: 'መጽሓፍ ቅዱስ', prompt: 'ኣብ መጽሓፍ ቅዱስ ክንደይ ክፋላት ኣሎ?', type: QuestionType.multipleChoice, options: ['ሓደ', 'ክልተ', 'ሰለስተ', 'ኣርባዕተ'], correctAnswer: 'ክልተ', level: 4),
  Question(id: 'pq055', context: 'መጽሓፍ ቅዱስ', prompt: 'ክልተ ክፋላት መጽሓፍ ቅዱስ መን ኢዮም?', type: QuestionType.multipleChoice, options: ['ካህናትን ነቢያትን', 'ብሉይ ኪዳንን ሓድሽ ኪዳንን', 'ፍጥረትን ምድሓንን', 'ሰማይን ምድርን'], correctAnswer: 'ብሉይ ኪዳንን ሓድሽ ኪዳንን', level: 4),
  Question(id: 'pq056', context: 'መጽሓፍ ቅዱስ', prompt: 'ብሉይ ኪዳን ኣብ ምንታይ ግዜ ዘተኩር እዩ?', type: QuestionType.multipleChoice, options: ['ድሕሪ ልደት ኢየሱስ', 'ቅድሚ ልደት ኢየሱስ ክርስቶስ', 'ኣብ ዘመን ሕጂ', 'ኣብ መጻኢ'], correctAnswer: 'ቅድሚ ልደት ኢየሱስ ክርስቶስ', level: 4),
  Question(id: 'pq057', context: 'መጽሓፍ ቅዱስ', prompt: 'ቀንዲ ኣርእስቲ ሓድሽ ኪዳን እንታይ እዩ?', type: QuestionType.multipleChoice, options: ['ፍጥረት ዓለም', 'ህይወት የሱስን ትምህርቱን', 'ዛንታ ሙሴ', 'ዛንታ ኖህ'], correctAnswer: 'ህይወት የሱስን ትምህርቱን', level: 4),
  Question(id: 'pq058', context: 'መጽሓፍ ቅዱስ', prompt: 'ክርስትያናት መጽሓፍ ቅዱስ ዘንብቡ ስለምንታይ እዮም?', type: QuestionType.multipleChoice, options: ['ንምዝናይ ጥራይ', 'ብዛዕባ ኣምላኽን ጽቡቕ ህይወትን ንምፍላጥ', 'ትምህርቲ ንምምሃር', 'ታሪኽ ንምፍላጥ ጥራይ'], correctAnswer: 'ብዛዕባ ኣምላኽን ጽቡቕ ህይወትን ንምፍላጥ', level: 4),
  Question(id: 'pq059', context: 'መጽሓፍ ቅዱስ', prompt: 'ካብ ፍሉጣት ዛንታታት መጽሓፍ ቅዱስ ኣየናይ ኣብዚ ጠቒሱ?', type: QuestionType.multipleChoice, options: ['ዛንታ ሰሎሞን', 'ዛንታ ዮሴፍ', 'መርከብ ኖህን ዳዊትን ጎልያድን', 'ዛንታ ሙሴ ጥራይ'], correctAnswer: 'መርከብ ኖህን ዳዊትን ጎልያድን', level: 4),
  Question(id: 'pq060', context: 'መጽሓፍ ቅዱስ', prompt: 'ኣብ መዝሙር ዳዊትን ምሳሌን እንታይ ዓይነት ጽሑፋት ይርከብ?', type: QuestionType.multipleChoice, options: ['ዛንታታትን ታሪኽን', 'ሕግታትን ስርዓታትን', 'ጽቡቕ መዝሙራትን ጥበባዊ ኣበሃህላታትን', 'ትንቢታትን ራእይታትን'], correctAnswer: 'ጽቡቕ መዝሙራትን ጥበባዊ ኣበሃህላታትን', level: 4),
  Question(id: 'pq061', context: 'መጽሓፍ ቅዱስ', prompt: 'ኩሎም ሰባት መጽሓፍ ቅዱስ ኣብ ሓደ ፍሉይ ኣጋጣሚ ጥራይ የንብቡ።', type: QuestionType.trueOrFalse, options: ['ሓቂ', 'ሓሶት'], correctAnswer: 'ሓሶት', level: 4),
  Question(id: 'pq062', context: 'መጽሓፍ ቅዱስ', prompt: 'መጽሓፍ ቅዱስ ኣብ መላእ ዓለም ንዝርከቡ ሰባት ብኸመይ ይጸልዎም?', type: QuestionType.multipleChoice, options: ['ሓዘን ይፈጥረሎም', 'ምንጪ ምጽንናዕን ምትብባዕን ይኸውን', 'ፍርሒ የምጽኣሎም', 'ኣይጸልዎምን'], correctAnswer: 'ምንጪ ምጽንናዕን ምትብባዕን ይኸውን', level: 4),

// p010 - ከተማ
  Question(id: 'pq063', context: 'ከተማ', prompt: 'ከተማ ብኸመይ ትግለጽ?', type: QuestionType.multipleChoice, options: ['ሒደት ህዝቢ ዘለዋ ሰፋሕ ቦታ', 'ብዙሕ ህንጻታትን ጽዑቕ ህዝቢን ዝነብርሉ ቦታ', 'ኣትክልቲ ጥራይ ዘለዋ ቦታ', 'ባሕሪ ዝከቦ ቦታ'], correctAnswer: 'ብዙሕ ህንጻታትን ጽዑቕ ህዝቢን ዝነብርሉ ቦታ', level: 4),
  Question(id: 'pq064', context: 'ከተማ', prompt: 'ሰማይ ጠቀስ ህንጻታት ኣበይ ክትረኽቦም ትኽእል?', type: QuestionType.multipleChoice, options: ['ኣብ ገጠር', 'ኣብ ምድረ በዳ', 'ኣብ ከተማ', 'ኣብ ጫካ'], correctAnswer: 'ኣብ ከተማ', level: 4),
  Question(id: 'pq065', context: 'ከተማ', prompt: 'ሰባት ኣብ ከተማታት ብኸምዚ ይዛወሩ?', type: QuestionType.multipleChoice, options: ['ብእግሮም ጥራይ', 'ብፈረስ ጥራይ', 'ብመካይንን ኣውቶቡሳትን', 'ብባቡር ጥራይ'], correctAnswer: 'ብመካይንን ኣውቶቡሳትን', level: 4),
  Question(id: 'pq066', context: 'ከተማ', prompt: 'ኣብ ከተማታት ካብ ዝርከቡ ኣገደስቲ መሳለጥያታት ኣየኖት እዮም?', type: QuestionType.multipleChoice, options: ['ቤተ መቕደሳት', 'ኣብያተ ትምህርትን ሆስፒታላትን', 'ጫካታትን', 'ወደባት'], correctAnswer: 'ኣብያተ ትምህርትን ሆስፒታላትን', level: 4),
  Question(id: 'pq067', context: 'ከተማ', prompt: 'ኣብ ከተማታት ዝርከቡ ንግዳዊ ትካላት ኣየኖት እዮም?', type: QuestionType.multipleChoice, options: ['ሩባታትን ዒላታትን', 'ድኳናትን ቤት መግብታትን', 'ኣትክልትን ዓሳን', 'ዕዳጋ ዓሳ ጥራይ'], correctAnswer: 'ድኳናትን ቤት መግብታትን', level: 4),
  Question(id: 'pq068', context: 'ከተማ', prompt: 'ከተማታት ብለይቲ ከመይ ይመስላ?', type: QuestionType.multipleChoice, options: ['ኩሉ ጸልማት', 'ብድሙቕ መብራህቲ ዝበርሃ', 'ጭቃውን ዝሑልን', 'ጸጥታ ዝሰፈነን'], correctAnswer: 'ብድሙቕ መብራህቲ ዝበርሃ', level: 4),
  Question(id: 'pq069', context: 'ከተማ', prompt: 'ከተማታት ካብ ገጠራት ብኸምዚ ይፍለያ?', type: QuestionType.multipleChoice, options: ['ኣብ ከተማ ብዝሒ ህዝቢን ህንጻታትን ይዛይድ', 'ኣብ ከተማ ገዛ ዘይተሰርሐ ኣብ  ኩሉ ቦታታት ይርከብ', 'ኣብ ከተማ ኣትክልቲ ጥራይ ይርከብ', 'ኣብ ገጠር ብዝሒ ህዝቢ ዝዓበየ እዩ'], correctAnswer: 'ኣብ ከተማ ብዝሒ ህዝቢን ህንጻታትን ይዛይድ', level: 4),

// p011 - ሕርሻ
  Question(id: 'pq070', context: 'ሕርሻ', prompt: 'ሕርሻ ስለምንታይ ኣገዳሲ እዩ?', type: QuestionType.multipleChoice, options: ['ሰባት ዝዘናግዕሉ ቦታ ስለዝኾነ', 'ሰባት መግቢ ዘፍርዩሉ ቦታ ስለዝኾነ', 'ሰባት ዝዕቀብሉ ቦታ ስለዝኾነ', 'ሰባት ዝጻወቱሉ ቦታ ስለዝኾነ'], correctAnswer: 'ሰባት መግቢ ዘፍርዩሉ ቦታ ስለዝኾነ', level: 4),
  Question(id: 'pq071', context: 'ሕርሻ', prompt: 'ካብ ሕርሻ ዝርከቡ ገለ መግብታት ኣየኖት እዮም?', type: QuestionType.multipleChoice, options: ['ኬክን ቸኮሌትን', 'ጸባ፣ እንቋቑሖ፣ ፍሩታን ኣሕምልትን', 'ሻሂን ቡንን', 'ባኒን ፓስታን ጥራይ'], correctAnswer: 'ጸባ፣ እንቋቑሖ፣ ፍሩታን ኣሕምልትን', level: 4),
  Question(id: 'pq072', context: 'ሕርሻ', prompt: 'ኣብ ሕርሻ ዝርከቡ እንስሳታት ኣየኖት እዮም?', type: QuestionType.multipleChoice, options: ['ኣናብስን ነብርን', 'ዓሳን ዑፍን', 'ላም፣ ደርሆን ሓሰማታትን', 'ዝብእን ወኻሩን'], correctAnswer: 'ላም፣ ደርሆን ሓሰማታትን', level: 4),
  Question(id: 'pq073', context: 'ሕርሻ', prompt: 'ሓረስቶት ኣብ ግራት ንምሕጋዝ ዝጥቀሙሉ ዓባይ ማሽን እንታይ እያ?', type: QuestionType.multipleChoice, options: ['ኣውቶቡስ', 'ትራክተር', 'ነፋሪት', 'ክሬን'], correctAnswer: 'ትራክተር', level: 4),
  Question(id: 'pq074', context: 'ሕርሻ', prompt: 'ኣብ ሕርሻ ዝርከቡ ፍረ ዘፍርዩ ኣግራብ ኣየኖት እዮም?', type: QuestionType.multipleChoice, options: ['ሓጺንን ዕጨይቲን', 'ቱፋሕን ባናናን', 'ስርናይን ጣፍን', 'ደርሆን ዑፍን'], correctAnswer: 'ቱፋሕን ባናናን', level: 4),
  Question(id: 'pq075', context: 'ሕርሻ', prompt: 'ሓረስቶት መዓስ ተሲኦም ስርሖም ይጅምሩ?', type: QuestionType.multipleChoice, options: ['ድሕሪ ቀትሪ', 'ምሸት', 'ንግሆ', 'ለይቲ'], correctAnswer: 'ንግሆ', level: 4),

// p012 - ክሊማ
  Question(id: 'pq076', context: 'ክሊማ', prompt: 'ክሊማ እንታይ እዩ?', type: QuestionType.multipleChoice, options: ['ዓይነት ምግቢ', 'ኩነታት ኣየር ናይ ሓደ ቦታ', 'ዓይነት ኣትክልቲ', 'ዓይነት ልብሲ'], correctAnswer: 'ኩነታት ኣየር ናይ ሓደ ቦታ', level: 4),
  Question(id: 'pq077', context: 'ክሊማ', prompt: 'ኣየናይ ቦታ ውዑይን ጸሓያውን ክሊማ ንርኢ?', type: QuestionType.multipleChoice, options: ['ኣብ ጥቓ ዋልታ', 'ኣብ ጥቓ ምድረበዳ', 'ኣብ ኣፍ ባሕሪ', 'ኣብ ጫካ'], correctAnswer: 'ኣብ ጥቓ ምድረበዳ', level: 4),
  Question(id: 'pq078', context: 'ክሊማ', prompt: 'ኣብ ጥቓ ዋልታ ዝርከቡ ቦታታት እንታይ ዓይነት ክሊማ ኣለዎም?', type: QuestionType.multipleChoice, options: ['ውዑይን ጸሓያውን', 'ዝሑልን በረድን', 'ዉዑይን ብርሃንን', 'ዝናባውን ጸልማትን'], correctAnswer: 'ዝሑልን በረድን', level: 4),
  Question(id: 'pq079', context: 'ክሊማ', prompt: 'ኣብ ጥቓ ምድረበዳ ዝርከቡ ቦታታት እንታይ ዓይነት ኩነታት ኣየር ኣለዎም?', type: QuestionType.multipleChoice, options: ['ዝሑል', 'ዝናባዊ', 'ውዑይ', 'ደባን'], correctAnswer: 'ውዑይ', level: 4),
  Question(id: 'pq080', context: 'ክሊማ', prompt: 'ኣብ ጥቓ ዋልታ ዝርከቡ ቦታታት እንታይ ዓይነት ኩነታት ኣየር ኣለዎም?', type: QuestionType.multipleChoice, options: ['ውዑይ', 'ዝሑል', 'ጸሓያዊ', 'ደባን'], correctAnswer: 'ዝሑል', level: 4),
  Question(id: 'pq081', context: 'ክሊማ', prompt: 'ክሊማ ቀስ ብቐስ ክቕየር ከሎ እንታይ ይበሃል?', type: QuestionType.multipleChoice, options: ['ዝናብ', 'ለውጢ ክሊማ', 'ሓጋይ', 'ክረምቲ'], correctAnswer: 'ለውጢ ክሊማ', level: 4),
  Question(id: 'pq082', context: 'ክሊማ', prompt: 'ሓጋይ ምስ ዝኸውን ክሊማ ከመይ ይመስል?', type: QuestionType.multipleChoice, options: ['ዝሑልን ዝናባውን', 'ውዑይን ጸሓያውን', 'ጸልማት', 'ብርሃን'], correctAnswer: 'ውዑይን ጸሓያውን', level: 4),
  Question(id: 'pq083', context: 'ክሊማ', prompt: 'ሓጋይ ምስ ዝኸውን እንታይ ዓይነት ክዳን ንኽደን?', type: QuestionType.multipleChoice, options: ['ጃኬት', 'ረጉድ ክዳን', 'ረቂቕ ክዳን', 'ጅንስ'], correctAnswer: 'ረቂቕ ክዳን', level: 4),
  Question(id: 'pq084', context: 'ክሊማ', prompt: 'ኣብ ክረምቲ ንኽንመውቕ እንታይ ንኽደን?', type: QuestionType.multipleChoice, options: ['ረቂቕ ክዳን', 'ረቂቕ ማልያ', 'ጃኬት'], correctAnswer: 'ጃኬት', level: 4),
  Question(id: 'pq085', context: 'ክሊማ', prompt: 'ዝተፈላለየ ክፋላት ዓለም ሓደ ዓይነት ክሊማ ኣለዎ።', type: QuestionType.trueOrFalse, options: ['ሓቂ', 'ሓሶት'], correctAnswer: 'ሓሶት', level: 4),

  // p013 - ጻጸ
  Question(id: 'pq086', context: 'ጻጸ', prompt: 'ጻጸ ኣበይ ይነብር?', type: QuestionType.multipleChoice, options: ['ኣብ ውሽጢ ጉንዲ', 'ኣብ ጕላ', 'ኣብ ባሕሪ', 'ኣብ ሰማይ'], correctAnswer: 'ኣብ ጕላ', level: 4),
  Question(id: 'pq087', context: 'ጻጸ', prompt: 'ጻጸ ክንደይ ዓይኒ ኣለዎ?', type: QuestionType.multipleChoice, options: ['ሓደ', 'ክልተ', 'ሰለስተ', 'ኣርባዕተ'], correctAnswer: 'ክልተ', level: 4),
  Question(id: 'pq088', context: 'ጻጸ', prompt: 'ጻጸ ይናኸስ ኢዩ።', type: QuestionType.trueOrFalse, options: ['ሓቂ', 'ሓሶት'], correctAnswer: 'ሓቂ', level: 4),
  Question(id: 'pq089', context: 'ጻጸ', prompt: 'ጻጸ ዘይርከበሉ ቦታ ኣብ ዓለም ኣሎ።', type: QuestionType.trueOrFalse, options: ['ሓቂ', 'ሓሶት'], correctAnswer: 'ሓሶት', level: 4),
  Question(id: 'pq090', context: 'ጻጸ', prompt: 'ጻጸ ክንደይ እግሪ ኣለዎ?', type: QuestionType.multipleChoice, options: ['ኣርባዕተ', 'ሹድሽተ', 'ሸሞንተ', 'ክልተ'], correctAnswer: 'ሹድሽተ', level: 4),

  // p014 - ሓርማዝ
  Question(id: 'pq091', context: 'ሓርማዝ', prompt: 'ሓርማዝ ካብ ህልዋት እንስሳታት እቲ ዝገዘፈ ኢዩ።', type: QuestionType.trueOrFalse, options: ['ሓቂ', 'ሓሶት'], correctAnswer: 'ሓቂ', level: 4),
  Question(id: 'pq092', context: 'ሓርማዝ', prompt: 'ሓርማዝ ክንደይ ጉጭ ኣለዎ?', type: QuestionType.multipleChoice, options: ['ሓደ', 'ክልተ', 'ሰለስተ', 'ኣርባዕተ'], correctAnswer: 'ክልተ', level: 4),
  Question(id: 'pq093', context: 'ሓርማዝ', prompt: 'ሓርማዝ ስጋ ይብልዕ።', type: QuestionType.trueOrFalse, options: ['ሓቂ', 'ሓሶት'], correctAnswer: 'ሓሶት', level: 4),
  Question(id: 'pq094', context: 'ሓርማዝ', prompt: 'ጭራ ናይ ሓርማዝ ከመይ ኢያ?', type: QuestionType.multipleChoice, options: ['ነዋሕ', 'ሓጻር', 'ክትፈልጣ ኣይካኣልን', 'ጭራ የብሉን'], correctAnswer: 'ሓጻር', level: 4),
  Question(id: 'pq095', context: 'ሓርማዝ', prompt: 'ሓርማዝ ዝፈትዋ ፍሩታ እንታይ ትበሃል?', type: QuestionType.multipleChoice, options: ['ቱፋሕ', 'ዕምባባ', 'በናና', 'ለሚን'], correctAnswer: 'በናና', level: 4),

// p015 - ገመል
  Question(id: 'pq096', context: 'ገመል', prompt: 'ገመል ሰብ ይበልዕ።', type: QuestionType.trueOrFalse, options: ['ሓቂ', 'ሓሶት'], correctAnswer: 'ሓሶት', level: 4),
  Question(id: 'pq097', context: 'ገመል', prompt: 'ገመል ካብ ናይ ሰብ ዝሓጽር ክሳድ ኣለዎ።', type: QuestionType.trueOrFalse, options: ['ሓቂ', 'ሓሶት'], correctAnswer: 'ሓሶት', level: 4),
  Question(id: 'pq098', context: 'ገመል', prompt: 'ገመል መንጉዳ ኣለዎ።', type: QuestionType.trueOrFalse, options: ['ሓቂ', 'ሓሶት'], correctAnswer: 'ሓቂ', level: 4),
  Question(id: 'pq099', context: 'ገመል', prompt: 'ገመል ማይ ከይሰተየ እንተደኣ ውዒሉ ብኡ ንብኡ ይመውት።', type: QuestionType.trueOrFalse, options: ['ሓቂ', 'ሓሶት'], correctAnswer: 'ሓሶት', level: 4),
  Question(id: 'pq100', context: 'ገመል', prompt: 'ገመል "መርከብ ምድረበዳ" ተባሂሉ ስለዝጽዋዕ ኣብ ባሕሪ የንሳፍፍ።', type: QuestionType.trueOrFalse, options: ['ሓቂ', 'ሓሶት'], correctAnswer: 'ሓሶት', level: 4),

// p016 - ፈረስ
  Question(id: 'pq101', context: 'ፈረስ', prompt: 'ሰማያዊ ሕብሪ ዘለዎ ፈረስ ኣሎ።', type: QuestionType.trueOrFalse, options: ['ሓቂ', 'ሓሶት'], correctAnswer: 'ሓሶት', level: 4),
  Question(id: 'pq102', context: 'ፈረስ', prompt: 'ሽኾና ፈረስ ንምንታይ ይጠቅም?', type: QuestionType.multipleChoice, options: ['ንምጎያይ ጥራይ', 'ንእግሪ ፈረስ ይከላኸለሉ', 'ፈረስ ንኽዓቢ', 'ምቁር ስለዝኾነ'], correctAnswer: 'ንእግሪ ፈረስ ይከላኸለሉ', level: 4),
  Question(id: 'pq103', context: 'ፈረስ', prompt: 'ፈረስ በላዒ ሳዕሪ ድዩ በላዒ ስጋ?', type: QuestionType.multipleChoice, options: ['በላዒ ስጋ', 'በላዒ ሳዕሪ', 'ክልቲኡ', 'ኣይበልዕን ኢዩ'], correctAnswer: 'በላዒ ሳዕሪ', level: 4),
  Question(id: 'pq104', context: 'ፈረስ', prompt: 'ፈረስ ንወዲ ሰብ ብዙሕ ጥቕሚ ይህብ።', type: QuestionType.trueOrFalse, options: ['ሓቂ', 'ሓሶት'], correctAnswer: 'ሓቂ', level: 4),

// p017 - ከልቢ
  Question(id: 'pq105', context: 'ከልቢ', prompt: 'ከልቢ ዋርድያ ኮይኑ ኣይሰርሕን እዩ።', type: QuestionType.trueOrFalse, options: ['ሓቂ', 'ሓሶት'], correctAnswer: 'ሓሶት', level: 4),
  Question(id: 'pq106', context: 'ከልቢ', prompt: 'ከልቢ ክልተ ጭራ ኣለዎ።', type: QuestionType.trueOrFalse, options: ['ሓቂ', 'ሓሶት'], correctAnswer: 'ሓሶት', level: 4),
  Question(id: 'pq107', context: 'ከልቢ', prompt: 'ከልቢ ይነክስ እዩ።', type: QuestionType.trueOrFalse, options: ['ሓቂ', 'ሓሶት'], correctAnswer: 'ሓቂ', level: 4),
  Question(id: 'pq108', context: 'ከልቢ', prompt: 'ከልቢ ሳዕሪ ይበልዕ።', type: QuestionType.trueOrFalse, options: ['ሓቂ', 'ሓሶት'], correctAnswer: 'ሓሶት', level: 4),
  Question(id: 'pq109', context: 'ከልቢ', prompt: 'ከልቢ ብቐሊሉ ክስልጥን ዝኽእል እንስሳ እዩ።', type: QuestionType.trueOrFalse, options: ['ሓቂ', 'ሓሶት'], correctAnswer: 'ሓቂ', level: 4),

 // p018 - ኮኾብ
  Question(id: 'pq110', context: 'ኮኾብ', prompt: 'ኮኾብን ወርሕን ሓደ ዓይነት እዮም።', type: QuestionType.trueOrFalse, options: ['ሓቂ', 'ሓሶት'], correctAnswer: 'ሓሶት', level: 4),
  Question(id: 'pq111', context: 'ኮኾብ', prompt: 'ኮኾብ ብማይ ዝቖመ እዩ።', type: QuestionType.trueOrFalse, options: ['ሓቂ', 'ሓሶት'], correctAnswer: 'ሓሶት', level: 4),
  Question(id: 'pq112', context: 'ኮኾብ', prompt: 'ጸሓይ ኮኾብ እያ።', type: QuestionType.trueOrFalse, options: ['ሓቂ', 'ሓሶት'], correctAnswer: 'ሓቂ', level: 4),
  Question(id: 'pq113', context: 'ኮኾብ', prompt: 'ቴሌስኮፕ ተጠቒምና ብዙሓት ከዋኽብቲ ክንርኢ ንኽእል።', type: QuestionType.trueOrFalse, options: ['ሓቂ', 'ሓሶት'], correctAnswer: 'ሓቂ', level: 4),
  Question(id: 'pq114', context: 'ኮኾብ', prompt: 'ንሓደ ኮኾብ ንብዙሓት ከኣ ኮኾባት ንብል።', type: QuestionType.trueOrFalse, options: ['ሓቂ', 'ሓሶት'], correctAnswer: 'ሓሶት', level: 4),

// p019 - ሻሂ ብኸመይ ነዳሉ (ordering)
  Question(
    id: 'pq115',
    context: 'ሻሂ ብኸመይ ነዳሉ',
    prompt: 'መስርሕ ምድላው ሻሂ ብቅደም ተኸተል ስርዓዮም:',
    type: QuestionType.ordering,
    options: [
      'ነቲ ሽኮር ክሓቅቕ ማንካ ጌርካ ኣኹሶ',
      'በራድ ማይ ምላኣዮ',
      'በራድ ኣጽርዮ',
      'ኣብ ኩባያ ሽኮር ኣእቱ',
      'ኣብ ቴርሙስ ገምጥሎ',
      'ቀጠፍ ኣእቱ',
      'ማይ ኣፍልሓዮ',
      'ካብቲ ቴርሙስ ናብቲ ኩባያ ቅዳሕ',
      'ሻሂ ስተ',
    ],
    correctAnswer: 'በራድ ኣጽርዮ|በራድ ማይ ምላኣዮ|ማይ ኣፍልሓዮ|ቀጠፍ ኣእቱ|ኣብ ቴርሙስ ገምጥሎ|ካብቲ ቴርሙስ ናብቲ ኩባያ ቅዳሕ|ኣብ ኩባያ ሽኮር ኣእቱ|ነቲ ሽኮር ክሓቅቕ ማንካ ጌርካ ኣኹሶ|ሻሂ ስተ',
    level: 4,
  ),


// p020 - ትኬት መገሻ ባቡር (antonym wordMatch)
  Question(
    id: 'pq116',
    context: 'ትኬት መገሻ ባቡር',
    prompt: 'ኣንጻር ቃል ርኸብ:',
    type: QuestionType.wordMatch,
    options: [
      'ነዊሕ',
      'ኣብዚ',
      'ካብ',
      'ምኻድ',
      'ክትሕዝ',
      'ከፋት',
      'ሓጺር',
      'ኣብ\'ቲ',
      'ናብ',
      'ምምጻእ',
      'ክትገድፍ',
      'ዕጹው',
    ],
    correctAnswer: 'ነዊሕ:ሓጺር|ኣብዚ:ኣብ\'ቲ|ካብ:ናብ|ምኻድ:ምምጻእ|ክትሕዝ:ክትገድፍ|ከፋት:ዕጹው',
    level: 4,
  ),

Question(
    id: 'pq117',
    context: 'ምምራሕ መኪና',
    prompt: 'ባዶ ቦታ ምላእ - Fill in the blanks:§ምምራሕ መኪና ___ እዩ።§ምምራሕ መኪና ___ የውህብ።§ብቑዕ መራሒ ክትከውን ___ ምግባር የድሊ።§ዘድሊ መርመራ ኣብ ቅድሚ ___ ትወስድ።§ናብ ___ ምምራሕ መኪና ትምዝገብ።',
    type: QuestionType.fillBank,
    options: ['ደስታ', 'ጥበብ', 'ቤት ትምህርቲ', 'ልምምድ', 'መርመርቲ'],
    correctAnswer: 'ጥበብ|ደስታ|ልምምድ|መርመርቲ|ቤት ትምህርቲ',
    level: 4,
  ),
  // p022 - ሰመረ (antonym wordMatch)
  Question(
    id: 'pq118',
    context: 'ሰመረ: ኣላዪ ጀርዲን ቤት ትምህርተይ',
    prompt: 'ኣንጻር ርኸብ - Find the antonym:',
    type: QuestionType.wordMatch,
    options: [
      'ብዙሕ',
      'ጽቡቕ',
      'ጻዕረኛ',
      'ዕጉስ',
      'ሒደት',
      'ሕማቕ',
      'ሃካይ',
      'ዘይዕጉስ',
    ],
    correctAnswer: 'ብዙሕ:ሒደት|ጽቡቕ:ሕማቕ|ጻዕረኛ:ሃካይ|ዕጉስ:ዘይዕጉስ',
    level: 4,
  ),
  // p023 - ተመሃራይ ምዃን (fill bank - 5 blanks across 2 sentences)
  // Question(
  //   id: 'pq119',
  //   context: 'ተመሃራይ ምዃን',
  //   prompt: 'ባዶ ቦታ ምላእ - Fill in the blanks:§ኣብ ግዜ ናይ ትምህርቲ ግዜና ነዚ ንማሃር፣ _________§ናይ ትምህርቲ ግዜ ዕድመኡ ብግቡእ ዝተጠቕመ ተማሃራይ፣ መጻኢ ዕድመኡ ነዚ ይመስል፣ __________',
  //   type: QuestionType.fillBank,
  //   options: ['ጽቡቕ ስነምግባር, ባህርያት, ልምምድ', 'ውሑስን ዕዉትን'],
  //   correctAnswer: 'ጽቡቕ ስነምግባር, ባህርያት, ልምምድ|ውሑስን ዕዉትን',
  //   level: 4,
  // ),
  Question(
    id: 'pq119',
    context: 'ተመሃራይ ምዃን',
    prompt: 'ባዶ ቦታ ምላእ - Fill in the blanks:§ኣብ ግዜ ናይ ትምህርቲ ግዜና ጽቡቕ ___ ክንመሃር የድልየና።§ናይ ትምህርቲ ግዜ ዕድመኡ ብግቡእ ዝተጠቕመ ተማሃራይ፣መጻኢ ዕድመኡ ___ን ከምዝኸውን ኣየጠራጥርን።',
    type: QuestionType.fillBank,
    options: ['ስነምግባር','ዕዉት'],
    correctAnswer: 'ስነምግባር|ዕዉት',
    level: 4,
  ),
  // p024 - ሬድዮ (singular/plural wordMatch)
  Question(
    id: 'pq120',
    context: 'ሬድዮ',
    prompt: 'ንጽል ወይ ድርብ ርኸብ - Find singular or plural:',
    type: QuestionType.wordMatch,
    options: [
      'ሬድዮ', 'ምህዞ', 'መራኸቢ', 'ምሁር', 'መሳርሒ',
      'ሰብ', 'ደርፊ', 'ዜና', 'ርእይቶ', 'መደብ',
      'ዘተታት', 'መደባት', 'ክትዓት', 'መዛናግዒ', 'ሓበሬታታት',
      'ትምህርቲታት', 'ኣእዳው', 'ቦታታት',
      'ሬድዮታት', 'ውጽኢታት', 'መራኸብቲ', 'ምሁራት', 'መሳርሒታት',
      'ሰባት', 'ደርፍታት', 'ዜናታት', 'ርእይቶታት', 'መደባت',
      'ዘተ', 'መደብ', 'ክትዕ', 'መዘናግዕታት', 'ሓበሬታ',
      'ትምህርቲ', 'ኢድ', 'ቦታ',
    ],
    correctAnswer: 'ሬድዮ:ሬድዮታት|ምህዞ:ምህዞታት|መራኸቢ:መራኸቢታት|ምሁር:ምሁራት|መሳርሒ:መሳርሒታት|ሰብ:ሰባት|ደርፊ:ደርፍታት|ዜና:ዜናታት|ርእይቶ:ርእይቶታት|መደብ:መደባት|ዘተ:ዘተታት|መደብ:መደባት|ክትዕ:ክትዓት|መዛናግዒ:መዘናግዕታት|ሓበሬታ:ሓበሬታታት|ትምህርቲ:ትምህርቲታት|ኢድ:ኣእዳው|ቦታ:ቦታታት',
    level: 4,
  ),
  // p025 - ማይ ባህርያዊ ሃብቲ
  Question(id: 'pq121', context: 'ማይ - ባህርያዊ ሃብቲ', prompt: 'ማይ ንምንታይ ይጠቅም?', type: QuestionType.multipleChoice, options: ['ንመሕጸቢ፣ ንጽሬት፣ መስተን መስርሒ መግብን', 'ንምጽዋት ጥራይ', 'ንምሕካም ጥራይ', 'ንምርኣይ ጥራይ'], correctAnswer: 'ንመሕጸቢ፣ ንጽሬት፣ መስተን መስርሒ መግብን', level: 4),
  Question(id: 'pq122', context: 'ማይ - ባህርያዊ ሃብቲ', prompt: 'ኣብ ዓለም ማይ ዶ ይበዝሕ ንቑጽ መሬት?', type: QuestionType.multipleChoice, options: ['ንቑጽ መሬት ይበዝሕ', 'ማይ ይበዝሕ', 'ማዕረ ማዕረ እዩ', 'ኣይፍለጥን'], correctAnswer: 'ማይ ይበዝሕ', level: 4),
// p026 - ቤት ጽሕፈተይ (antonym wordMatch)
  Question(
    id: 'pq123',
    context: 'ቤት ጽሕፈተይ',
    prompt: 'ኣንጻር ርኸብ - Find the antonym:',
    type: QuestionType.wordMatch,
    options: ['ጸጋም', 'ላዕሊ', 'ንእሽቶ', 'ቅድሚት', 'የማን', 'ታሕቲ', 'ዓቢ', 'ድሕሪት'],
    correctAnswer: 'ጸጋም:የማን|ላዕሊ:ታሕቲ|ንእሽቶ:ዓቢ|ቅድሚት:ድሕሪት',
    level: 4,
  ),
  // p027 - ዓባይ ጻዕዳ ደርሆ
  Question(id: 'pq124', context: 'ዓባይ ጻዕዳ ደርሆ', prompt: 'እታ ደርሆ ክንደይ ጨቓዊት ኔሮማ?', type: QuestionType.multipleChoice, options: ['ሸሞንተ', 'ዓሰርተ', 'ዓሰርተ ክልተ', 'ዓሰርተ ሓሙሽተ'], correctAnswer: 'ዓሰርተ ክልተ', level: 4),
  Question(id: 'pq125', context: 'ዓባይ ጻዕዳ ደርሆ', prompt: 'እታ ደርሆ ኣብቲ ወሓዚ ሩባ እንታይ ረኺባ?', type: QuestionType.multipleChoice, options: ['ዓሳ', 'ካልእ ደርሆ', 'ሓደ እምኒ', 'ዕምባባ'], correctAnswer: 'ሓደ እምኒ', level: 4),
  Question(id: 'pq126', context: 'ዓባይ ጻዕዳ ደርሆ', prompt: 'እቶም ጨቓዊት ንኽነጥሩ ዘኽእሎም እንታይ እዩ?', type: QuestionType.multipleChoice, options: ['ምሕዳር', 'ምጎያይ', 'ምንግብጋብ ናይ መንገብገቦም', 'ምስዓብ ደርሆ'], correctAnswer: 'ምንግብጋብ ናይ መንገብገቦም', level: 4),
  Question(id: 'pq127', context: 'ዓባይ ጻዕዳ ደርሆ', prompt: 'እቶም ጨቓዊት ስለምንታይ ነታ ደርሆ ዝበለቶም ኣይገበሩን?', type: QuestionType.multipleChoice, options: ['ስለዘይፈትዉዋ', 'ምንጣር ከምዘይክእሉ ስለዝፈለጡ', 'ጽምኢ ስለዝሓዞም', 'ሻቕሎት ስለዝሓዞም'], correctAnswer: 'ምንጣር ከምዘይክእሉ ስለዝፈለጡ', level: 4),

// p028 - ደበና
  Question(id: 'pq128', context: 'ደበና', prompt: 'ኣብ ሰማይ ነጠብጣባት ማይ ናብ ምንታይ ይልወጡ?', type: QuestionType.multipleChoice, options: ['ናብ ዝናብ', 'ናብ ደበና', 'ናብ በረድ', 'ናብ ንፋስ'], correctAnswer: 'ናብ ደበና', level: 4),
  Question(id: 'pq129', context: 'ደበና', prompt: 'ኣሰማምያ ናይ ደበና ኣብ ኣየኖት ክልተ ነገራት ምርኩስ ይገብር?', type: QuestionType.multipleChoice, options: ['ሕብሪ', 'ብራኸን ቅርጽን', 'ዋዒ', 'ብዝሒ ማይን ቀዝሕን'], correctAnswer: 'ብራኸን ቅርጽን', level: 4),
  Question(id: 'pq130', context: 'ደበና', prompt: 'ኣብ በሪኽ ሰማይ ዝርከቡ ደበናታት እንታይ ይበሃሉ?', type: QuestionType.multipleChoice, options: ['ስትራታስ', 'ክዩሙላስ', 'ሳይራስ', 'ግመ'], correctAnswer: 'ሳይራስ', level: 4),
  Question(id: 'pq131', context: 'ደበና', prompt: 'ዓበይቲ ኩዕሶ መሰል ናይ ጡጥ ጥንግናጋት ዝመስሉ ደበናታት እንታይ ይበሃሉ?', type: QuestionType.multipleChoice, options: ['ሳይራስ', 'ስትራታስ', 'ግመ', 'ክዩሙላስ'], correctAnswer: 'ክዩሙላስ', level: 4),

// p029 - ቤት ንባብ
  Question(id: 'pq132', context: 'ቤት ንባብ', prompt: 'ቤት ንባብ ንምንታይ ይጠቅም?', type: QuestionType.multipleChoice, options: ['ንምብላዕን ምስታይን', 'ንምዝናጋዕን ናይ ትምህርቲ ሓገዝ ንምርካብን', 'ንምህዞ ስራሕ ጥራይ', 'ንምጽዋት ጥራይ'], correctAnswer: 'ንምዝናጋዕን ናይ ትምህርቲ ሓገዝ ንምርካብን', level: 4),
  Question(id: 'pq133', context: 'ቤት ንባብ', prompt: 'ሰራሕተኛ ቤት ንባብ ናብ ምንታይ ይመርሓካ?', type: QuestionType.multipleChoice, options: ['ናብ መብልዒ ቦታ', 'ናብ ዝደለኻዮ ዓይነት መጽሓፍ፣ ጋዜጣታት ወይ ኮምፕዩተር', 'ናብ ስፖርት ቦታ', 'ናብ ናይ ፊልም ቦታ'], correctAnswer: 'ናብ ዝደለኻዮ ዓይነት መጽሓፍ፣ ጋዜጣታት ወይ ኮምፕዩተር', level: 4),
  Question(id: 'pq134', context: 'ቤት ንባብ', prompt: 'ኣብ ቤት ንባብ ኣብ ምንታይ ኮፍ ኢልካ ተንብብ?', type: QuestionType.multipleChoice, options: ['ኣብ ባይታ', 'ኣብ ምቹእ ኮፍ መበሊታት', 'ኣብ ደረጃ', 'ኣብ ናይ ደገ ቦታ'], correctAnswer: 'ኣብ ምቹእ ኮፍ መበሊታት', level: 4),

// p030 - ጸሓይ፣ ከዋኽብቲ፣ ወርሒ (antonym wordMatch)
  Question(
    id: 'pq135',
    context: 'ጸሓይ፣ ከዋኽብቲ፣ ወርሒ',
    prompt: 'ኣንጻር ርኸብ - Find the antonym:',
    type: QuestionType.wordMatch,
    options: [
      'ሰማይ', 'ቀትሪ', 'ውዑይ', 'ብርሃን', 'ዋዒ', 'ዝቐረበ', 'ብዙሓት',
      'ምድሪ', 'ለይቲ', 'ዝሑል', 'ጸልማት', 'ዛሕሊ', 'ዝረሓቐ', 'ውሑዳት',
    ],
    correctAnswer: 'ሰማይ:ምድሪ|ቀትሪ:ለይቲ|ውዑይ:ዝሑል|ብርሃን:ጸልማት|ዋዒ:ዛሕሊ|ዝቐረበ:ዝረሓቐ|ብዙሓት:ውሑዳት',
    level: 4,
  ),
// p031 - ዝምድናታት (antonym wordMatch: family gender pairs)
  Question(
    id: 'pq136',
    context: 'ዝምድናታት',
    prompt: 'ኣንጻር ርኸብ - Find the opposite:',
    type: QuestionType.wordMatch,
    options: [
      'ኣቦ', 'ሓው', 'ኣኮ', 'ሓውኣቦ', 'ንዕልቲ', 'ሓማት', 'ኣቦሓጎ',
      'ኣደ', 'ሓውቲ', 'ሓውቲ እኖ', 'ኣሞ', 'ዞማ', 'ሓሙ', 'ዓባይ',
    ],
    correctAnswer: 'ኣቦ:ኣደ|ሓው:ሓውቲ|ኣኮ:ሓውቲ እኖ|ሓውኣቦ:ኣሞ|ንዕልቲ:ዞማ|ሓማት:ሓሙ|ኣቦሓጎ:ዓባይ',
    level: 4,
  ),

  // p031 - ዝምድናታት (fillBank: kinship terms)
  Question(
    id: 'pq137',
    context: 'ዝምድናታት',
    prompt: 'ባዶ ቦታ ምላእ - Fill in the blanks:§ሓዉ ንኣቦኻ ___ ይበሃል።§ሓዋ ንኣዴኻ ___ ይበሃል።§ሓብቱ ንኣቦኻ ___ ትበሃል።§ሓብታ ንኣዴኻ ___ ትበሃል።§ኣቡኡ ንኣቦኻ ___ ይበሃል።§ኣዲኡ ንኣቦኻ ___ ትበሃል።§ኣቡኡ/ኣ ንሰብኣይካ/ሰበይትኻ ___ ይበሃል።§ኣዲኡ/ኣ ንሰብኣይካ/ሰበይትኻ ___ ትበሃል።§ሓው/ዋ ንሰብኣይካ/ንሰበይትኻ ___ ይ/ትበሃል።§ሓብቲ ሰብኣይካ/ሰበይትኻ ___ ትበሃል።',
    type: QuestionType.fillBank,
    options: ['ሓውኣቦ', 'ኣኮ', 'ኣሞ', 'ሓውቲ እኖ', 'ኣቦሓጎ', 'ዓባይ', 'ሓሙ', 'ሓማት', 'ዞማ', 'ንዕልቲ'],
    correctAnswer: 'ሓውኣቦ|ኣኮ|ኣሞ|ሓውቲ እኖ|ኣቦሓጎ|ዓባይ|ሓሙ|ሓማት|ዞማ|ንዕልቲ',
    level: 4,
  ),
  // p032 - ሓርማዝን ኣዕርኽቱን (fillBank)
  Question(
    id: 'pq138',
    context: 'ሓርማዝን ኣዕርኽቱን',
    prompt: 'ባዶ ቦታ ምላእ - Fill in the blanks:§ሓርማዝ መጀመርታ ዝረኸቦ እንስሳ ___ ኢዩ።§ሓርማዝ ካልኣይ ዝረኸቦ እንስሳ ___ ኢዩ።§ሓርማዝ ሳልሳይ ዝረኸቦ እንስሳ ___ ኢዩ።§እንስሳታት ክሃድሙ ከለዉ ርእዩ ሓርማዝ ዝሓተቶ እንስሳ ___ ኢዩ።§ነቶም እንስሳታት ዝጎዮም ዝነበረ እንስሳ ___ ኢዩ።',
    type: QuestionType.fillBank,
    options: ['ህበይ', 'ማንቲለ', 'ዕንቅርዖብ', 'ድቢ', 'ነብሪ'],
    correctAnswer: 'ህበይ|ማንቲለ|ዕንቅርዖብ|ድቢ|ነብሪ',
    level: 4,
  ), 
  // p033 - ናይ ዘቤት እንስሳይ
  Question(id: 'pq139', context: 'ናይ ዘቤት እንስሳይ', prompt: 'ናይ ሳራ እንስሳ ዘቤት እንታይ እያ?', type: QuestionType.multipleChoice, options: ['ከልቢ', 'ድሙ', 'ዑፍ', 'ዓሳ'], correctAnswer: 'ድሙ', level: 4),
  Question(id: 'pq140', context: 'ናይ ዘቤት እንስሳይ', prompt: 'ድሙ ናይ ሳራ መን ትበሃል?', type: QuestionType.multipleChoice, options: ['ሉና', 'ሊሊ', 'ሌና', 'ላራ'], correctAnswer: 'ሊሊ', level: 4),
  Question(id: 'pq141', context: 'ናይ ዘቤት እንስሳይ', prompt: 'ሊሊ እንታይ ሕብሪ ኣለዋ?', type: QuestionType.multipleChoice, options: ['ጸሊም', 'ቀይሕ', 'ጻዕዳ', 'ቡናዊ'], correctAnswer: 'ጻዕዳ', level: 4),
 
  // p034 - ጀርዲን
  Question(id: 'pq142', context: 'ጀርዲን', prompt: 'እቲ ጀርዲን ኣበይ ይርከብ?', type: QuestionType.multipleChoice, options: ['ኣብ ርሑቕ ቦታ', 'ኣብ ጥቓ ገዛ', 'ኣብ ቤት ትምህርቲ', 'ኣብ ጫካ'], correctAnswer: 'ኣብ ጥቓ ገዛ', level: 4),
  Question(id: 'pq143', context: 'ጀርዲን', prompt: 'እቶም ዕምባባታት እንታይ ሕብሪ ኣለዎም?', type: QuestionType.multipleChoice, options: ['ሰማያዊን ጻዕዳን', 'ቀይሕን ብጫን', 'ቀጠልያን ጸሊምን', 'ቡናዊ'], correctAnswer: 'ቀይሕን ብጫን', level: 4),
  Question(id: 'pq144', context: 'ጀርዲን', prompt: 'ኣብቲ ኣግራብ ኮይነን ኣዕዋፍ እንታይ ይገብራ?', type: QuestionType.multipleChoice, options: ['ይድቅሳ', 'ይበልዓ', 'ይዝምራ', 'ይጻወታ'], correctAnswer: 'ይዝምራ', level: 4),
 
  // p035 - ናይ ቤት ትምህርቲ ቦርሳይ
  Question(id: 'pq145', context: 'ናይ ቤት ትምህርቲ ቦርሳይ', prompt: 'ቦርሳ ናይ ቤት ትምህርቲ እንታይ ሕብሪ ኣለዎ?', type: QuestionType.multipleChoice, options: ['ቀይሕ', 'ቀጠልያ', 'ሰማያዊ', 'ቢጫ'], correctAnswer: 'ሰማያዊ', level: 4),
  Question(id: 'pq146', context: 'ናይ ቤት ትምህርቲ ቦርሳይ', prompt: 'ኣብ ውሽጢ ቦርሳ ዝርከቡ ክልተ ነገራት ስመ።', type: QuestionType.multipleChoice, options: ['ዕምባባታት', 'መጻሕፍትን ርሳስን', 'ልብስን ሳእንን', 'መግብን ጸባን'], correctAnswer: 'መጻሕፍትን ርሳስን', level: 4),
  Question(id: 'pq147', context: 'ናይ ቤት ትምህርቲ ቦርሳይ', prompt: 'እቲ ቆልዓ መዓስ እዩ ቦርሳኡ ዘዳሉ?', type: QuestionType.multipleChoice, options: ['ለይቲ', 'ድሕሪ ቤት ትምህርቲ', 'ንግሆ', 'ምሸት'], correctAnswer: 'ንግሆ', level: 4),
 
  // p036 - ጸሓይ
  Question(id: 'pq148', context: 'ጸሓይ', prompt: 'ጸሓይ መዓስ እያ ትበርቕ?', type: QuestionType.multipleChoice, options: ['ለይቲ', 'ምሸት', 'ንግሆ', 'ቀትሪ ጥራይ'], correctAnswer: 'ንግሆ', level: 4),
  Question(id: 'pq149', context: 'ጸሓይ', prompt: 'ጸሓይ እንታይ ትህበና?', type: QuestionType.multipleChoice, options: ['ዝናብን ንፋስን', 'ብርሃንን ሙቐትን', 'በረድን ቀዝሕን', 'ደበናን ጽልማትን'], correctAnswer: 'ብርሃንን ሙቐትን', level: 4),
  Question(id: 'pq150', context: 'ጸሓይ', prompt: 'ብዘይ ጸሓይ እንታይ ክዓቢ ዘይክእል?', type: QuestionType.multipleChoice, options: ['እንስሳ', 'ሩባ', 'ተኽሊ', 'ደበና'], correctAnswer: 'ተኽሊ', level: 4),
 
  // p037 - ቁርሲ
  Question(id: 'pq151', context: 'ቁርሲ', prompt: 'ቁርሲ እንታይ እዩ?', type: QuestionType.multipleChoice, options: ['ናይ መወዳእታ መግቢ', 'ናይ ቀትሪ መግቢ', 'ናይ መጀመርታ መግቢ ናይታ መዓልቲ', 'መስተ ጥራይ'], correctAnswer: 'ናይ መጀመርታ መግቢ ናይታ መዓልቲ', level: 4),
  Question(id: 'pq152', context: 'ቁርሲ', prompt: 'እቲ ቆልዓ ንቁርሲ ዝበልዖ ሓደ መግቢ ስመ።', type: QuestionType.multipleChoice, options: ['ስጋን ሩዝን', 'ባኒ፣ እንቋቑሖን ጸባን', 'ሻሂን ቡንን', 'ፍሩታ ጥራይ'], correctAnswer: 'ባኒ፣ እንቋቑሖን ጸባን', level: 4),
  Question(id: 'pq153', context: 'ቁርሲ', prompt: 'ቁርሲ መን ይሰርሕ ንስድራ?', type: QuestionType.multipleChoice, options: ['ኣቦ', 'ቆልዓ', 'ኣደ', 'ኣቦሓጎ'], correctAnswer: 'ኣደ', level: 4),
 
  // p038 - ዝናብ
  Question(id: 'pq154', context: 'ዝናብ', prompt: 'ዝናብ ካበይ እዩ ዝመጽእ?', type: QuestionType.multipleChoice, options: ['ካብ ባሕሪ', 'ካብ መሬት', 'ካብ ደበናታት', 'ካብ ሩባ'], correctAnswer: 'ካብ ደበናታት', level: 4),
  Question(id: 'pq155', context: 'ዝናብ', prompt: 'ዝናብ ክዘንብ ከሎ ሓረስቶት ስለምንታይ ይሕጎሱ?', type: QuestionType.multipleChoice, options: ['ክዕረፉ ስለዝኽእሉ', 'ዘራእቶም ስለዝዓቢ', 'እንስሳቶም ስለዝድቅሱ'], correctAnswer: 'ዘራእቶም ስለዝዓቢ', level: 4),
  Question(id: 'pq156', context: 'ዝናብ', prompt: 'ድሕሪ ዝናብ ኣየር ከመይ ይጨኑ?', type: QuestionType.multipleChoice, options: ['ሕማቕ', 'ናይ ትኪ', 'ጥዑም', 'ናይ ዕምባባ'], correctAnswer: 'ጥዑም', level: 4),
 
  // p039 - ስድራይ
  Question(id: 'pq157', context: 'ስድራይ', prompt: 'ኣብታ ስድራቤት ክንደይ ሰባት ኣለዉ?', type: QuestionType.multipleChoice, options: ['ሰለስተ', 'ኣርባዕተ', 'ሓሙሽተ', 'ሽዱሽተ'], correctAnswer: 'ሓሙሽተ', level: 4),
  Question(id: 'pq158', context: 'ስድራይ', prompt: 'እቲ ኣቦ እንታይ ይገብር ኩሉ መዓልቲ?', type: QuestionType.multipleChoice, options: ['ኣብ ገዛ ይጸንሕ', 'ናብ ስራሕ ይኸይድ', 'ናብ ቤት ትምህርቲ ይኸይድ', 'መግቢ ይሰርሕ'], correctAnswer: 'ናብ ስራሕ ይኸይድ', level: 4),
  Question(id: 'pq159', context: 'ስድራይ', prompt: 'መን እዩ መግቢ ዝሰርሕ ንስድራ?', type: QuestionType.multipleChoice, options: ['ኣቦ', 'ኣሕዋት', 'ቆልዓ', 'ኣደ'], correctAnswer: 'ኣደ', level: 4),
 
  // p040 - ገረብ
  Question(id: 'pq160', context: 'ገረብ', prompt: 'ኣግራብ ዝህቡና ክልተ ጥቕሚ ስመ።', type: QuestionType.multipleChoice, options: ['ዝናብን ንፋስን', 'ጽላልን ጽሩይ ኣየርን', 'ማይን ሓዊን', 'ጸሓይን ወርሕን'], correctAnswer: 'ጽላልን ጽሩይ ኣየርን', level: 4),
  Question(id: 'pq161', context: 'ገረብ', prompt: 'ኣዕዋፍ ኣብ ኣግራብ እንታይ ይገብራ?', type: QuestionType.multipleChoice, options: ['ኣግራብ ይበልዓ', 'ሰፈር ይሰርሓ', 'ጨናፍር ይቖርጻ', 'ኣብ መሬት ይድቅሳ'], correctAnswer: 'ሰፈር ይሰርሓ', level: 4),
  Question(id: 'pq162', context: 'ገረብ', prompt: 'ንኣግራብ እንታይ ክንገብሮም የብልናን?', type: QuestionType.multipleChoice, options: ['ምትካል', 'ምቑራጽ', 'ምኽናኻን'], correctAnswer: 'ምቑራጽ', level: 4),
 

]; 
 
// Combined list of all questions (for comprehension lookup)
final List<Question> allQuizQuestions = [
  ...level1QuizData,
  ...level2QuizData,
  ...level3QuizData,
  ...level4QuizData,
];
 
Map<int, List<Question>> getQuizByLevel(int level) {
  switch (level) {
    case 1: return {1: level1QuizData};
    case 2: return {2: level2QuizData};
    case 3: return {3: level3QuizData};
    case 4: return {4: level4QuizData};
    default: return {};
  }
}
 
List<Question> getQuizQuestions(int level) {
  final all = getQuizByLevel(level)[level] ?? [];
  all.shuffle();
  return all.take(100).toList();
}