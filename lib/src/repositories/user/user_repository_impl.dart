import 'dart:developer';
import 'dart:io';

import 'package:barbearia_tcc/src/core/exceptions/auth_exception.dart';
import 'package:barbearia_tcc/src/core/exceptions/repository_exception.dart';
import 'package:barbearia_tcc/src/core/fp_funcional_program/eitheri.dart';
import 'package:barbearia_tcc/src/core/fp_funcional_program/nil.dart';
import 'package:barbearia_tcc/src/core/restClient/rest_client.dart';
import 'package:barbearia_tcc/src/model/user_model.dart';
import 'package:dio/dio.dart';

import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient _restClient;

  UserRepositoryImpl({required RestClient restClient})
      : _restClient = restClient;

  @override
  Future<Either<AuthExecption, String>> login(
      String email, String password) async {
    try {
      final Response(:data) = await _restClient.unAuth.post(
        '/auth',
        data: {
          'email': email,
          'password': password,
        },
      );

      return Success(data['access_token'].toString());
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response(:statusCode) = e.response!;
        if (statusCode == HttpStatus.forbidden) {
          log('Login ou senha inválidos', error: e, stackTrace: s);
          return Failure(AuthUnauthorizedException());
        }
      }
      log('Erro ao realizar login', error: e, stackTrace: s);
      return Failure(AuthError(message: 'Erro ao realizar login'));
    }
  }

  @override
  Future<Either<RepositoryException, UserModel>> me() async {
    try {
      final Response(:data) = await _restClient.auth.get('/me');

      return Success(UserModel.fromMap(data));
    } on DioException catch (e, s) {
      log('Erro ao buscar usuário logado', error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: 'Erro ao buscar usuário logado'));
    } on ArgumentError catch (e, s) {
      log('Invalid Json', error: e, stackTrace: s);
      return Failure(RepositoryException(message: e.message));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerAdmin(
      ({String email, String name, String password}) userData) async {
    try {
      await _restClient.unAuth.post(
        '/users',
        data: {
          'name': userData.name,
          'email': userData.email,
          'password': userData.password,
          'profile': 'ADM'
        },
      );
      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao registrar usuário admin', error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: 'Erro ao registrar usuário admin'));
    }
  }

  @override
  Future<Either<RepositoryException, List<UserModel>>> getEmployees(
      int barbershopId) async {
    try {
      final Response(:List data) = await _restClient.auth
          .get('/users', queryParameters: {'barbershop_id': barbershopId});

      final employees = data.map((e) => UserModelADM.fromMap(e)).toList();
      return Success(employees);
    } on DioException catch (e, s) {
      log('Erro ao buscar colaboradores', error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: 'Erro ao buscar colaboradores'));
    } on ArgumentError catch (e, s) {
      log('Erro ao converter colaboradores (Invalid Json)',
          error: e, stackTrace: s);
      return Failure(RepositoryException(
          message: 'Erro ao converter colaboradores (Invalid Json)'));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerAdmAsEmployee(
      ({List<String> workDays, List<int> workHours}) userModel) async {
    try {
      final userModelResult = await me();

      final int userId;

      switch (userModelResult) {
        case Success(value: UserModel(:var id)):
          userId = id;
        case Failure(:var exception):
          return Failure(exception);
      }

      await _restClient.auth.put('/users/$userId', data: {
        'work_days': userModel.workDays,
        'work_hours': userModel.workHours,
      });

      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao inserir administrador como colaborador',
          error: e, stackTrace: s);
      return Failure(RepositoryException(
          message: 'Erro ao inserir administrador como colaborador'));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerEmployee(
      ({
        int barbershopId,
        String email,
        String name,
        String password,
        List<String> workDays,
        List<int> workHours
      }) userModel) async {
    try {
      await _restClient.auth.post('/users/', data: {
        'name': userModel.name,
        'email': userModel.email,
        'password': userModel.password,
        'barbershop_id': userModel.barbershopId,
        'profile': 'EMPLOYEE',
        'work_days': userModel.workDays,
        'work_hours': userModel.workHours,
      });

      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao inserir administrador como colaborador',
          error: e, stackTrace: s);
      return Failure(RepositoryException(
          message: 'Erro ao inserir administrador como colaborador'));
    }
  }
}
