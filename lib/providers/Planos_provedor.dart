import 'package:flutter/foundation.dart';

class PlanModel {
  final String id;
  final String name;
  final double monthlyPrice;
  final double quarterlyPrice;
  final double yearlyPrice;
  final List<String> benefits;
  final bool isHighlighted;
  final String badge;

  PlanModel({
    required this.id,
    required this.name,
    required this.monthlyPrice,
    required this.quarterlyPrice,
    required this.yearlyPrice,
    required this.benefits,
    this.isHighlighted = false,
    this.badge = '',
  });
}

class PlanProvider extends ChangeNotifier {
  String _selectedPeriod = 'Mensal';
  String? _selectedPlanId;

  String get selectedPeriod => _selectedPeriod;
  String? get selectedPlanId => _selectedPlanId;

  final List<PlanModel> _plans = [
    PlanModel(
      id: 'basic',
      name: 'Básico',
      monthlyPrice: 89.90,
      quarterlyPrice: 79.90,
      yearlyPrice: 69.90,
      benefits: [
        'Acesso à área de musculação',
        'Horário comercial (6h–22h)',
        'Vestiário completo',
        'Avaliação física inicial',
      ],
    ),
    PlanModel(
      id: 'pro',
      name: 'Pro',
      monthlyPrice: 129.90,
      quarterlyPrice: 109.90,
      yearlyPrice: 89.90,
      benefits: [
        'Tudo do plano Básico',
        'Aulas coletivas ilimitadas',
        'Acesso 24h',
        'App de treinos exclusivo',
        '1 sessão de personal/mês',
      ],
      isHighlighted: true,
      badge: 'Mais Popular',
    ),
    PlanModel(
      id: 'elite',
      name: 'Power',
      monthlyPrice: 249.90,
      quarterlyPrice: 219.90,
      yearlyPrice: 189.90,
      benefits: [
        'Tudo do plano Pro',
        'Personal trainer 2x/semana',
        'Consulta nutricional mensal',
        'Acesso ao spa e sauna',
        'Estacionamento gratuito',
        'Convidado grátis às sextas',
      ],
      badge: 'Promoção',
    ),
  ];

  List<PlanModel> get plans => List.unmodifiable(_plans);

  double getPriceForPlan(PlanModel plan) {
    switch (_selectedPeriod) {
      case 'Trimestral':
        return plan.quarterlyPrice;
      case 'Anual':
        return plan.yearlyPrice;
      default:
        return plan.monthlyPrice;
    }
  }

  void selectPeriod(String period) {
    _selectedPeriod = period;
    notifyListeners();
  }

  void selectPlan(String planId) {
    _selectedPlanId = planId;
    notifyListeners();
  }

  List<String> get periods => ['Mensal', 'Trimestral', 'Anual'];
}
