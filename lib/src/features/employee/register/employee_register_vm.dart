import 'package:asyncstate/asyncstate.dart';
import 'package:barbearia_tcc/src/core/providers/application_providers.dart';
import 'package:barbearia_tcc/src/features/employee/register/employee_register_state.dart';
import 'package:barbearia_tcc/src/repositories/user/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'employee_register_vm.g.dart';

@riverpod
class EmployeeRegisterVm extends _$EmployeeRegisterVm {
  @override
  EmployeeRegisterState build() => EmployeeRegisterState.initial();

  void setRegisterADM(bool isRegisterADM) {
    state = state.copyWith(registerADM: isRegisterADM);
  }

  void addOrREmoveWorkdays(String weekDay) {
    final EmployeeRegisterState(:workdays) = state;
    if (workdays.contains(weekDay)) {
      workdays.remove(weekDay);
    } else {
      workdays.add(weekDay);
    }
    state = state.copyWith(workdays: workdays);
  }

  void addOrREmoveWorkhours(int hour) {
    final EmployeeRegisterState(:worhours) = state;
    if (worhours.contains(hour)) {
      worhours.remove(hour);
    } else {
      worhours.add(hour);
    }
    state = state.copyWith(worhours: worhours);
  }


  // Future<void> register({String? name, String? email,String? password}){

  //   final EmployeeRegisterState(:registerADM,:workdays,:worhours) = state;
  //   final asyncLoaderHandler = AsyncLoaderHandler()..start();

  //   final UserRepository() = ref.read;

  // }
}
