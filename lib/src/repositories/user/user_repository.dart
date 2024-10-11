import 'package:barbearia_tcc/src/core/exceptions/auth_exception.dart';
import 'package:barbearia_tcc/src/core/exceptions/repository_exception.dart';
import 'package:barbearia_tcc/src/core/fp_funcional_program/eitheri.dart';
import 'package:barbearia_tcc/src/core/fp_funcional_program/nil.dart';
import 'package:barbearia_tcc/src/model/user_model.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);

  Future<Either<RepositoryException, UserModel>> me();

  Future<Either<RepositoryException, Nil>> registerAdmin(
      ({String name, String email, String password}) userData);

  Future<Either<RepositoryException, List<UserModel>>> getEmployees(
      int barbershopId);
}
