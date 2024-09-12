import 'package:barbearia_tcc/src/core/exceptions/repository_exception.dart';
import 'package:barbearia_tcc/src/core/fp_funcional_program/eitheri.dart';
import 'package:barbearia_tcc/src/model/barbershop_model.dart';
import 'package:barbearia_tcc/src/model/user_model.dart';

abstract interface class BarbershopRepository {
  Future<Either<RepositoryException, BarbershopModel>> getMyBarbershop(
      UserModel userModel);
}
