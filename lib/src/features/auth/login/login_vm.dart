import 'package:asyncstate/asyncstate.dart';
import 'package:barbearia_tcc/src/core/exceptions/service_exception.dart';
import 'package:barbearia_tcc/src/core/fp_funcional_program/eitheri.dart';
import 'package:barbearia_tcc/src/core/providers/application_providers.dart';
import 'package:barbearia_tcc/src/features/auth/login/login_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_vm.g.dart';

@riverpod
class LoginVm extends _$LoginVm {
  @override
  LoginState build() => LoginState.initial();
  final loaderHandler = AsyncLoaderHandler()..start();

  Future<void> login(String email, String password) async {
    final loginService = ref.watch(userLoginServiceProvider);

    final result = await loginService.execute(email, password);

    switch (result) {
      case Sucess():
        break;
      case Failure(exception: ServiceException(:final message)):
        state = state.copyWith(
          status: LoginStateStatus.error,
          errorMessage: () => message,
        );
    }
    loaderHandler.close();
  }
}
