import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/Planos_provedor.dart';

class PlansScreen extends StatelessWidget {
  const PlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PlanProvider>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Planos e Preços',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            'Escolha o plano ideal para você.',
            style: TextStyle(color: Colors.grey[400]),
          ),
          const SizedBox(height: 24),

          // Seletor de período
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: provider.periods.map((period) {
                final isSelected = provider.selectedPeriod == period;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => provider.selectPeriod(period),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFE10600)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        period,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey[400],
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          if (provider.selectedPeriod != 'Mensal') ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.savings_outlined,
                      color: Colors.green, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    provider.selectedPeriod == 'Trimestral'
                        ? '💰 Economize pagando trimestral!'
                        : '💰 Maior economia no plano anual!',
                    style: const TextStyle(color: Colors.green, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 20),

          // Cards de plano (RF007 - ListView)
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: provider.plans.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final plan = provider.plans[index];
              final price = provider.getPriceForPlan(plan);
              final isSelected = provider.selectedPlanId == plan.id;

              return GestureDetector(
                onTap: () => provider.selectPlan(plan.id),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: plan.isHighlighted
                          ? const Color(0xFFE10600)
                          : isSelected
                              ? Colors.white30
                              : const Color(0xFF2A2A2A),
                      width: plan.isHighlighted ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            plan.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (plan.badge.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: plan.isHighlighted
                                    ? const Color(0xFFE10600)
                                    : Colors.amber[800],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                plan.badge,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'R\$ ',
                              style: TextStyle(
                                  color: Colors.grey[400], fontSize: 14),
                            ),
                            TextSpan(
                              text:
                                  price.toStringAsFixed(2).replaceAll('.', ','),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: '/mês',
                              style: TextStyle(
                                  color: Colors.grey[400], fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Divider(color: Color(0xFF2A2A2A)),
                      const SizedBox(height: 12),
                      ...plan.benefits.map(
                        (b) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              const Icon(Icons.check_circle,
                                  color: Color(0xFFE10600), size: 16),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  b,
                                  style: TextStyle(
                                      color: Colors.grey[300], fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            provider.selectPlan(plan.id);
                            _showSubscribeDialog(context, plan.name, price);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: plan.isHighlighted
                                ? const Color(0xFFE10600)
                                : const Color(0xFF2A2A2A),
                            foregroundColor: Colors.white,
                          ),
                          child: Text('Quero o ${plan.name}'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _showSubscribeDialog(
      BuildContext context, String planName, double price) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: Text(
          'Plano $planName',
          style: const TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 48),
            const SizedBox(height: 12),
            Text(
              'Você selecionou o plano $planName por R\$ ${price.toStringAsFixed(2).replaceAll('.', ',')}/mês.',
              style: const TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Entre em contato pelo WhatsApp para finalizar sua matrícula!',
              style: TextStyle(color: Colors.grey[500], fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Fechar', style: TextStyle(color: Colors.grey[400])),
          ),
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(ctx),
            icon: const Icon(Icons.message, size: 16),
            label: const Text('WhatsApp'),
          ),
        ],
      ),
    );
  }
}
