import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const _highScoresKey = 'high_scores';

  Future<void> saveScore(int score, int total) async {
    final prefs = await SharedPreferences.getInstance();
    final listJson = prefs.getStringList(_highScoresKey) ?? [];
    final record = jsonEncode({
      'score': score,
      'total': total,
      'ts': DateTime.now().toIso8601String(),
    });
    listJson.insert(0, record);
    // keep only last 20
    if (listJson.length > 20) listJson.removeRange(20, listJson.length);
    await prefs.setStringList(_highScoresKey, listJson);
  }

  Future<List<Map<String, dynamic>>> loadScores() async {
    final prefs = await SharedPreferences.getInstance();
    final listJson = prefs.getStringList(_highScoresKey) ?? [];
    return listJson
        .map((j) => Map<String, dynamic>.from(jsonDecode(j)))
        .toList();
  }
}
