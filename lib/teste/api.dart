import './user_model.dart';

class ApiService {
  static Future<List<UserModel>> getUsers() async {
    await Future.delayed(Duration(seconds: 2));

    return [
      UserModel(id: 1, name: 'João', email: 'joao@example.com'),
      UserModel(id: 2, name: 'Maria', email: 'maria@example.com'),
      UserModel(id: 3, name: 'Pedro', email: 'pedro@example.com'),
      UserModel(id: 4, name: 'Ana', email: 'ana@example.com'),
      UserModel(id: 5, name: 'Carlos', email: 'carlos@example.com'),
    ];
  }
}
