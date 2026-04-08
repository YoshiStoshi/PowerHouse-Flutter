import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/Agendar_provedor.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  String _selectedDay = 'Segunda';

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ScheduleProvider>();
    final entries = provider.getByDay(_selectedDay);

    return Column(
      children: [
        // Seletor de dia
        Container(
          color: const Color(0xFF1A1A1A),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: provider.days.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final day = provider.days[index];
                final isSelected = _selectedDay == day;
                return GestureDetector(
                  onTap: () => setState(() => _selectedDay = day),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFE10600)
                          : const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      day,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey[400],
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        // Lista de aulas (RF007 - ListView)
        Expanded(
          child: entries.isEmpty
              ? const Center(
                  child: Text(
                    'Sem aulas neste dia.',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: entries.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final entry = entries[index];
                    final isFull = entry.spotsAvailable == 0;

                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: entry.isBooked
                              ? Colors.green.withOpacity(0.4)
                              : const Color(0xFF2A2A2A),
                        ),
                      ),
                      child: Row(
                        children: [
                          // Horário
                          Container(
                            width: 56,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE10600).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  entry.time.split(':')[0],
                                  style: const TextStyle(
                                    color: Color(0xFFE10600),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  ':${entry.time.split(':')[1]}',
                                  style: TextStyle(
                                      color: Colors.grey[500], fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 14),

                          // Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entry.workoutName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  entry.instructor,
                                  style: TextStyle(
                                      color: Colors.grey[400], fontSize: 12),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Icon(Icons.people_outline,
                                        size: 13, color: Colors.grey[500]),
                                    const SizedBox(width: 4),
                                    Text(
                                      isFull
                                          ? 'Lotado'
                                          : '${entry.spotsAvailable}/${entry.spotsTotal} vagas',
                                      style: TextStyle(
                                        color: isFull
                                            ? Colors.red
                                            : Colors.grey[400],
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Botão
                          Column(
                            children: [
                              if (entry.isBooked) ...[
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'Inscrito ✓',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                GestureDetector(
                                  onTap: () => _cancelBooking(
                                      context, entry.id, provider),
                                  child: Text(
                                    'Cancelar',
                                    style: TextStyle(
                                        color: Colors.red[300], fontSize: 11),
                                  ),
                                ),
                              ] else
                                SizedBox(
                                  height: 36,
                                  child: ElevatedButton(
                                    onPressed: isFull
                                        ? null
                                        : () => _bookClass(
                                            context, entry.id, provider),
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14),
                                      textStyle: const TextStyle(fontSize: 12),
                                    ),
                                    child: const Text('Inscrever'),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  void _bookClass(BuildContext context, String id, ScheduleProvider provider) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text('Confirmar inscrição',
            style: TextStyle(color: Colors.white)),
        content: const Text(
          'Deseja se inscrever nesta aula?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancelar', style: TextStyle(color: Colors.grey[400])),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              final error = provider.bookClass(id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(error ?? '✅ Inscrição realizada com sucesso!'),
                  backgroundColor:
                      error != null ? Colors.red[700] : Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  void _cancelBooking(
      BuildContext context, String id, ScheduleProvider provider) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text('Cancelar inscrição',
            style: TextStyle(color: Colors.white)),
        content: const Text(
          'Deseja cancelar sua inscrição nesta aula?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Não', style: TextStyle(color: Colors.grey[400])),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              final error = provider.cancelBooking(id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(error ?? 'Inscrição cancelada.'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red[700]),
            child: const Text('Cancelar aula'),
          ),
        ],
      ),
    );
  }
}
