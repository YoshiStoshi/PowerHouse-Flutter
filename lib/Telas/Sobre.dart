import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo
            ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Image.asset(
                  'assets/logo.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'POWER HOUSE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w900,
                letterSpacing: 4,
              ),
            ),
            const Text(
              'FITNESS GYM',
              style: TextStyle(
                color: Color(0xFFE10600),
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 6,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Versão Beta',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
            const SizedBox(height: 32),

            // Objetivo
            _SectionCard(
              icon: Icons.flag_outlined,
              title: 'Objetivo do Aplicativo',
              content:
                  'O Power House GYM é um aplicativo multiplataforma desenvolvido para facilitar a experiência dos alunos da academia Power House Fitness GYM. '
                  'Através do app, os usuários podem visualizar treinos disponíveis, consultar a grade de aulas coletivas, gerenciar inscrições nas aulas e explorar os planos de matrícula disponíveis.',
            ),
            const SizedBox(height: 16),

            // Equipe
            _SectionCard(
              icon: Icons.group_outlined,
              title: 'Equipe de Desenvolvimento',
              child: Column(
                children: [
                  _TeamMember(
                      name: 'Rodrigo de Azevedo Junior', role: 'Desenvolvedor'),
                  _TeamMember(name: 'Davi Sousa Cirilo', role: 'Desenvolvedor'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Disciplina/Instituição
            _SectionCard(
              icon: Icons.school_outlined,
              title: 'Informações Acadêmicas',
              child: Column(
                children: [
                  _InfoRow(
                      label: 'Disciplina', value: 'Desenvolvimento Mobile'),
                  const Divider(color: Color(0xFF2A2A2A), height: 20),
                  _InfoRow(label: 'Instituição', value: 'FATEC Ribeirão Preto'),
                  const Divider(color: Color(0xFF2A2A2A), height: 20),
                  _InfoRow(
                      label: 'Professor(a)', value: 'Prof. Rodrigo Plotze'),
                  const Divider(color: Color(0xFF2A2A2A), height: 20),
                  _InfoRow(label: 'Semestre', value: '4º Semestre / 2026'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Tecnologias
            _SectionCard(
              icon: Icons.code_outlined,
              title: 'Tecnologias Utilizadas',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _TechChip(label: 'Flutter SDK'),
                  _TechChip(label: 'Dart'),
                  _TechChip(label: 'Provider'),
                  _TechChip(label: 'Material Design 3'),
                  _TechChip(label: 'ChangeNotifier'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Funcionalidades
            _SectionCard(
              icon: Icons.check_circle_outline,
              title: 'Funcionalidades',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _FeatureItem(text: 'Autenticação de usuário (Login)'),
                  _FeatureItem(text: 'Cadastro de novos usuários'),
                  _FeatureItem(text: 'Recuperação de senha'),
                  _FeatureItem(text: 'Dashboard com resumo personalizado'),
                  _FeatureItem(text: 'Catálogo de treinos com filtros'),
                  _FeatureItem(text: 'Grade de aulas coletivas semanal'),
                  _FeatureItem(text: 'Inscrição e cancelamento em aulas'),
                  _FeatureItem(text: 'Visualização de planos e preços'),
                  _FeatureItem(text: 'Favoritar treinos'),
                ],
              ),
            ),
            const SizedBox(height: 28),

            Text(
              '© 2025 Power House Fitness GYM\nTodos os direitos reservados.',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? content;
  final Widget? child;

  const _SectionCard({
    required this.icon,
    required this.title,
    this.content,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF2A2A2A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFFE10600), size: 20),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (content != null)
            Text(
              content!,
              style:
                  TextStyle(color: Colors.grey[400], fontSize: 13, height: 1.6),
            ),
          if (child != null) child!,
        ],
      ),
    );
  }
}

class _TeamMember extends StatelessWidget {
  final String name;
  final String role;

  const _TeamMember({required this.name, required this.role});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xFFE10600).withOpacity(0.2),
            child: Text(
              name.substring(0, 1),
              style: const TextStyle(
                color: Color(0xFFE10600),
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600)),
              Text(role,
                  style: TextStyle(color: Colors.grey[500], fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 13)),
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _TechChip extends StatelessWidget {
  final String label;

  const _TechChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE10600).withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: const TextStyle(
            color: Color(0xFFE10600),
            fontSize: 12,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String text;

  const _FeatureItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFFE10600), size: 15),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text,
                style: TextStyle(color: Colors.grey[300], fontSize: 13)),
          ),
        ],
      ),
    );
  }
}
