import 'package:sqlite3/sqlite3.dart';
import '../db/db.dart';
import '../models/user_model.dart';

class UserRepository {
  final _db = DatabaseHelper().db;

  // Método para obter todos os usuários
  List<UserModel> getAllUsers() {
    final result = _db.select('SELECT * FROM users');
    return result.map((row) => _mapRowToUser(row)).toList();
  }

  // Método para adicionar um novo usuário
  void addUser(UserModel user) {
    final stmt = _db.prepare('''
      INSERT INTO users (name, email, avatar, profile, work_days, work_hours, barbershop_id)
      VALUES (?, ?, ?, ?, ?, ?, ?)
    ''');

    stmt.execute([
      user.name,
      user.email,
      user.avatar,
      user is UserModelADM ? 'ADM' : 'EMPLOYEE',
      user is UserModelADM ? user.workDays?.join(',') : (user as UserModelEmployee).workDays.join(','),
      user is UserModelADM ? user.workHours?.join(',') : (user as UserModelEmployee).workHours.join(','),
      user is UserModelEmployee ? user.barbershopId : null,
    ]);

    stmt.dispose();
  }

  // Converter linha da tabela para UserModel
  UserModel _mapRowToUser(Row row) {
    return row['profile'] == 'ADM'
        ? UserModelADM(
            id: row['id'],
            name: row['name'],
            email: row['email'],
            avatar: row['avatar'],
            workDays: row['work_days']?.split(','),
            workHours: row['work_hours']?.split(',').map(int.parse).toList(),
          )
        : UserModelEmployee(
            id: row['id'],
            name: row['name'],
            email: row['email'],
            avatar: row['avatar'],
            barbershopId: row['barbershop_id'],
            workDays: row['work_days']?.split(','),
            workHours: row['work_hours']?.split(',').map(int.parse).toList(),
          );
  }
}
