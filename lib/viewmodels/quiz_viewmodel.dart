import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/question.dart';
import '../services/quiz_service.dart';

final quizServiceProvider = Provider<QuizService>((ref) => QuizService());

final questionsProvider = Provider<List<Question>>((ref) {
  final svc = ref.read(quizServiceProvider);
  return svc.loadQuestions(count: 10);
});

final currentIndexProvider = StateProvider<int>((ref) => 0);

final selectedAnswersProvider = StateProvider<Map<String, int>>((ref) => {});

final scoreProvider = Provider<int>((ref) {
  final questions = ref.watch(questionsProvider);
  final selected = ref.watch(selectedAnswersProvider);
  int score = 0;
  for (var q in questions) {
    final sel = selected[q.id];
    if (sel != null && sel == q.correctIndex) score++;
  }
  return score;
});

class QuizViewModel {
  final Ref ref;

  QuizViewModel(this.ref);

  List<Question> get questions => ref.read(questionsProvider);

  int get currentIndex => ref.read(currentIndexProvider);

  void goTo(int index) {
    if (index < 0) index = 0;
    if (index >= questions.length) index = questions.length - 1;
    ref.read(currentIndexProvider.notifier).state = index;
  }

  void next() {
    goTo(currentIndex + 1);
  }

  void previous() {
    goTo(currentIndex - 1);
  }

  void selectAnswer(String questionId, int optionIndex) {
    final map = Map<String, int>.from(ref.read(selectedAnswersProvider));
    map[questionId] = optionIndex;
    ref.read(selectedAnswersProvider.notifier).state = map;
  }

  int? selectedFor(String questionId) =>
      ref.read(selectedAnswersProvider)[questionId];

  int get score => ref.read(scoreProvider);
}

final quizViewModelProvider = Provider<QuizViewModel>(
  (ref) => QuizViewModel(ref),
);
