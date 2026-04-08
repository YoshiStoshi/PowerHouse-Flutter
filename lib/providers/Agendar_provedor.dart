import 'package:flutter/foundation.dart';

class ScheduleEntry {
  final String id;
  final String workoutName;
  final String dayOfWeek;
  final String time;
  final String instructor;
  final int spotsTotal;
  int spotsAvailable;
  bool isBooked;

  ScheduleEntry({
    required this.id,
    required this.workoutName,
    required this.dayOfWeek,
    required this.time,
    required this.instructor,
    required this.spotsTotal,
    required this.spotsAvailable,
    this.isBooked = false,
  });
}

class ScheduleProvider extends ChangeNotifier {
  final List<ScheduleEntry> _entries = [
    ScheduleEntry(
        id: 's1',
        workoutName: 'Jiu-Jitsu',
        dayOfWeek: 'Segunda',
        time: '20:00',
        instructor: 'Danilo',
        spotsTotal: 20,
        spotsAvailable: 8),
    ScheduleEntry(
        id: 's2',
        workoutName: 'Jiu-Jitsu',
        dayOfWeek: 'Quarta',
        time: '20:00',
        instructor: 'Danilo',
        spotsTotal: 20,
        spotsAvailable: 12),
  ];

  List<ScheduleEntry> get entries => List.unmodifiable(_entries);

  List<String> get days =>
      ['Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado'];

  List<ScheduleEntry> getByDay(String day) =>
      _entries.where((e) => e.dayOfWeek == day).toList();

  String? bookClass(String id) {
    final index = _entries.indexWhere((e) => e.id == id);
    if (index == -1) return 'Aula não encontrada.';
    if (_entries[index].isBooked) return 'Você já está inscrito nesta aula.';
    if (_entries[index].spotsAvailable == 0) return 'Não há vagas disponíveis.';

    _entries[index].isBooked = true;
    _entries[index].spotsAvailable--;
    notifyListeners();
    return null;
  }

  String? cancelBooking(String id) {
    final index = _entries.indexWhere((e) => e.id == id);
    if (index == -1) return 'Aula não encontrada.';
    if (!_entries[index].isBooked) return 'Você não está inscrito nesta aula.';

    _entries[index].isBooked = false;
    _entries[index].spotsAvailable++;
    notifyListeners();
    return null;
  }

  List<ScheduleEntry> get myBookings =>
      _entries.where((e) => e.isBooked).toList();
}
