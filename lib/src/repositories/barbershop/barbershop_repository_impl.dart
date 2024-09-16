import 'package:dio/dio.dart';

import 'package:barbearia_tcc/src/core/exceptions/repository_exception.dart';
import 'package:barbearia_tcc/src/core/fp_funcional_program/eitheri.dart';
import 'package:barbearia_tcc/src/core/restClient/rest_client.dart';
import 'package:barbearia_tcc/src/model/barbershop_model.dart';
import 'package:barbearia_tcc/src/model/user_model.dart';

import './barbershop_repository.dart';

class BarbershopRepositoryImpl implements BarbershopRepository {
  final RestClient restClient;
  BarbershopRepositoryImpl({
    required this.restClient,
  });

  @override
  Future<Either<RepositoryException, BarbershopModel>> getMyBarbershop(
      UserModel userModel) async {
    switch (userModel) {
      case UserModelADM():
        final Response(data: List(first: data)) = await restClient.auth.get(
          '/barbershop',
          queryParameters: {'user_id': '#userAuthRef'},
        );
        return Success(BarbershopModel.fromMap(data));
        
      case UserModelEmployee():
        final Response(:data) = await restClient.auth.get(
          '/barbershop/${userModel.barbershopId}',
        );
        return Success(BarbershopModel.fromMap(data));
    }
  }
}
