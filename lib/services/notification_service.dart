// lib/services/notification_service.dart
//
// "Come back" reminders: whenever the learner leaves the app, any pending
// reminder is cancelled and a new one is scheduled 7 days later (plus a
// gentler one at 14 days). If they return within the week the timer simply
// restarts, so active learners never see it.
//
// Local notifications only: no server, no push, no exact-alarm permission.

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;
import '../providers/progress_provider.dart';

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _ready = false;

  static const _id7Days = 7001;
  static const _id14Days = 7002;

  // Set to true ONLY while testing: reminders fire after 5 and 10 minutes
  // instead of 7 and 14 days. Must be false in release builds.
  static const bool _testMode = false;

  static const _channelId = 'memhrey_reminders';
  static const _channelName = 'Learning reminders';
  static const _channelDesc = 'Reminds you where you left off in Memhrey';

  // ── Setup (call once in main) ────────────────────────────────────────────
  Future<void> init() async {
    if (_ready) return;
    try {
      tzdata.initializeTimeZones(); // reminders are relative (now + 7 days)
      const settings = InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/launcher_icon'),
        iOS: DarwinInitializationSettings(
          // Ask later, at a friendly moment (see requestPermission).
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      );
      await _plugin.initialize(settings);
      _ready = true;
      debugPrint('NotificationService: ready');
    } catch (e) {
      debugPrint('NotificationService.init error: $e');
    }
  }

  // ── Ask permission (Android 13+ and iOS) ─────────────────────────────────
  // Call once the learner has started (e.g. after they enter their name),
  // not on the very first screen.
  Future<void> requestPermission() async {
    if (!_ready) return;
    try {
      await _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
      await _plugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: false, sound: true);
    } catch (e) {
      debugPrint('NotificationService.requestPermission error: $e');
    }
  }

  // ── Reschedule (call whenever the app goes to the background) ────────────
  Future<void> scheduleComeBackReminders(ProgressProvider progress) async {
    if (!_ready) {
      debugPrint('NotificationService: not ready, nothing scheduled');
      return;
    }
    try {
      await _plugin.cancel(_id7Days);
      await _plugin.cancel(_id14Days);

      final msg = _buildMessage(progress);
      final now = tz.TZDateTime.now(tz.UTC);
      const first =
          _testMode ? Duration(minutes: 5) : Duration(days: 7);
      const second =
          _testMode ? Duration(minutes: 10) : Duration(days: 14);

      await _schedule(_id7Days, msg.title, msg.body, now.add(first));
      await _schedule(_id14Days, msg.title, msg.secondBody, now.add(second));
      final pending = await _plugin.pendingNotificationRequests();
      debugPrint('NotificationService: scheduled ${pending.length} reminder(s), '
          'first in ${first.inMinutes} min: "${msg.body}"');
    } catch (e) {
      debugPrint('NotificationService.schedule error: $e');
    }
  }

  Future<void> cancelAll() => _plugin.cancelAll();

  Future<void> _schedule(
      int id, String title, String body, tz.TZDateTime when) {
    return _plugin.zonedSchedule(
      id,
      title,
      body,
      when,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDesc,
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
          styleInformation: BigTextStyleInformation(body),
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      // Inexact: no SCHEDULE_EXACT_ALARM permission needed (Play-policy safe).
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  // ── Message: where the learner stopped ───────────────────────────────────
  ({String title, String body, String secondBody}) _buildMessage(
      ProgressProvider p) {
    const title = 'መምህረይ · Memhrey 📖';
    final name = p.studentName.trim();
    final hi = name.isEmpty ? 'ሰላም!' : 'ሰላም $name!';

    // Current level = first unlocked level not yet completed.
    final levels = p.levels;
    int current = -1;
    for (int i = 0; i < levels.length; i++) {
      if (levels[i].isUnlocked && !levels[i].isCompleted) {
        current = i;
        break;
      }
    }

    if (current == -1) {
      return (
        title: title,
        body: '$hi ኩሎም ደረጃታት ወዲእኩም! 🏆 '
            'You finished every level. Come back and review anytime!',
        secondBody: '$hi ትግርኛኹም ከይትርስዑ ንድገሞ! '
            'Keep your Tigrigna fresh with a quick review.',
      );
    }

    const tiNames = ['ፊደላት', 'ቃላት', 'ምሉእ ሓሳባት', 'ሕጡብ ጽሑፋት'];
    const enNames = ['Alphabet', 'Words', 'Sentences', 'Paragraphs'];
    final pct = (_levelProgress(p, current) * 100).round().clamp(0, 100);
    final lvl = current + 1;

    return (
      title: title,
      body: '$hi ኣብ ደረጃ $lvl (${tiNames[current]}) $pct% በጺሕኩም ኣለኹም። ንቐጽል! '
          'You\'re $pct% through Level $lvl – ${enNames[current]}. '
          'Let\'s keep going!',
      secondBody: '$hi ደረጃ $lvl (${tiNames[current]}) ይጽበየኩም ኣሎ። '
          'Level $lvl – ${enNames[current]} is waiting for you. '
          'Just 5 minutes today?',
    );
  }

  double _levelProgress(ProgressProvider p, int levelIndex) {
    switch (levelIndex) {
      case 0:
        return p.alphabetLevelProgress;
      case 1:
        return p.wordLevelProgress;
      case 2:
        return p.sentenceLevelProgress;
      default:
        return p.paragraphLevelProgress;
    }
  }
}