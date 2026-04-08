import 'package:flutter/foundation.dart';

class UserModel {
  final String name;
  final String email;
  final String phone;

  UserModel({required this.name, required this.email, required this.phone});
}

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  UserModel? _currentUser;
  final List<Map<String, String>> _registeredUsers = [];

  bool get isLoggedIn => _isLoggedIn;
  UserModel? get currentUser => _currentUser;

  // RF001 - Login
  String? login(String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      return 'Preencha todos os campos.';
    }
    if (!_isValidEmail(email)) {
      return 'E-mail inválido.';
    }

    // Mock: aceita qualquer usuário cadastrado ou admin padrão
    final found = _registeredUsers.firstWhere(
      (u) => u['email'] == email && u['password'] == password,
      orElse: () => {},
    );

    if (found.isNotEmpty) {
      _currentUser = UserModel(
        name: found['name']!,
        email: found['email']!,
        phone: found['phone']!,
      );
      _isLoggedIn = true;
      notifyListeners();
      return null;
    }

    // Admin padrão para demo
    if (email == 'admin@powerhouse.com' && password == '123456') {
      _currentUser = UserModel(
        name: 'Admin Power House',
        email: email,
        phone: '(16) 99999-9999',
      );
      _isLoggedIn = true;
      notifyListeners();
      return null;
    }

    return 'Credenciais inválidas. Verifique e-mail e senha.';
  }

  // RF002 - Cadastro
  String? register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
  }) {
    if (name.isEmpty || email.isEmpty || phone.isEmpty ||
        password.isEmpty || confirmPassword.isEmpty) {
      return 'Preencha todos os campos obrigatórios.';
    }
    if (!_isValidEmail(email)) {
      return 'E-mail inválido.';
    }
    if (password != confirmPassword) {
      return 'As senhas não coincidem.';
    }
    if (password.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres.';
    }
    if (_registeredUsers.any((u) => u['email'] == email)) {
      return 'E-mail já cadastrado.';
    }

    _registeredUsers.add({
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    });

    _currentUser = UserModel(name: name, email: email, phone: phone);
    _isLoggedIn = true;
    notifyListeners();
    return null;
  }

  // RF003 - Esqueceu a senha
  String? forgotPassword(String email) {
    if (email.isEmpty) {
      return 'Informe seu e-mail.';
    }
    if (!_isValidEmail(email)) {
      return 'E-mail inválido.';
    }
    // Mock: simula envio
    return null;
  }

  void logout() {
    _isLoggedIn = false;
    _currentUser = null;
    notifyListeners();
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
