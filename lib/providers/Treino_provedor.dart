import 'package:flutter/foundation.dart';

class WorkoutModel {
  final String id;
  final String name;
  final String category;
  final String duration;
  final String difficulty;
  final String description;
  final String icon;
  bool isFavorite;

  WorkoutModel({
    required this.id,
    required this.name,
    required this.category,
    required this.duration,
    required this.difficulty,
    required this.description,
    required this.icon,
    this.isFavorite = false,
  });
}

class WorkoutProvider extends ChangeNotifier {
  final List<WorkoutModel> _workouts = [
    WorkoutModel(
      id: '1',
      name: 'Musculação Upper Body',
      category: 'Musculação',
      duration: '60 min',
      difficulty: 'Intermediário',
      description:
          'Treino focado em peitoral, costas, ombros e braços com exercícios compostos e isolados.',
      icon: '💪',
    ),
    WorkoutModel(
      id: '2',
      name: 'Jiu-Jitsu',
      category: 'Coletiva',
      duration: '120 min',
      difficulty: 'Avançado',
      description:
          'Treinamento completo de Jiu-Jitsu com técnicas de posição, transição e finalização.',
      icon: '🥋',
    ),
    WorkoutModel(
      id: '3',
      name: 'Musculação Lower Body',
      category: 'Musculação',
      duration: '60 min',
      difficulty: 'Intermediário',
      description:
          'Treino de pernas completo: agachamento, leg press, cadeira extensora, rosca femoral e panturrilha.',
      icon: '🦵',
    ),
    WorkoutModel(
      id: '4',
      name: 'Personal Training',
      category: 'Personal',
      duration: '45 min',
      difficulty: 'Personalizado',
      description:
          'Treino personalizado com acompanhamento individual de personal trainer certificado.',
      icon: '🏆',
    ),
  ];

  List<WorkoutModel> get workouts => List.unmodifiable(_workouts);

  List<WorkoutModel> get favorites =>
      _workouts.where((w) => w.isFavorite).toList();

  List<WorkoutModel> getByCategory(String category) {
    if (category == 'Todos') return _workouts;
    return _workouts.where((w) => w.category == category).toList();
  }

  void toggleFavorite(String id) {
    final index = _workouts.indexWhere((w) => w.id == id);
    if (index != -1) {
      _workouts[index].isFavorite = !_workouts[index].isFavorite;
      notifyListeners();
    }
  }

  List<String> get categories =>
      ['Todos', 'Musculação', 'Coletiva', 'Personal'];
}
