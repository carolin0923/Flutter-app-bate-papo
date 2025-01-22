//autenticar  usuários, como login, logout, registro, e manutenção de sessões de usuários.

class AuthService {
  static final List<Map<String, String>> _users = [
    {'username': 'Caroline', 'password': 'carol234'},
    {'username': 'Miguel', 'password': 'Miguel1234'}
  ];

  static List<Map<String, String>> get users => _users;
}
