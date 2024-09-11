import 'package:barbearia_tcc/src/core/exceptions/auth_exception.dart';
import 'package:barbearia_tcc/src/core/fp_funcional_program/eitheri.dart';

abstract interface class UserRepository {
  Future<Either<AuthException,String>> login(String email,String password);

}