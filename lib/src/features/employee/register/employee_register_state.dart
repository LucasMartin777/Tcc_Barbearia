enum EmployeeRegisterStateStatus {
  initial,
  sucess,
  error,
}

class EmployeeRegisterState {
  final EmployeeRegisterStateStatus status;
  final bool registerADM;
  final List<String> workdays;
  final List<int> worhours;

  EmployeeRegisterState.initial()
      : this(
          status: EmployeeRegisterStateStatus.initial,
          registerADM: false,
          workdays: <String>[],
          worhours: <int>[],
        );

  EmployeeRegisterState({
    required this.status,
    required this.registerADM,
    required this.workdays,
    required this.worhours,
  });

  EmployeeRegisterState copyWith({
    EmployeeRegisterStateStatus? status,
    bool? registerADM,
    List<String>? workdays,
    List<int>? worhours,
  }) {
    return EmployeeRegisterState(
      status: status ?? this.status,
      registerADM: registerADM ?? this.registerADM,
      workdays: workdays ?? this.workdays,
      worhours: worhours ?? this.worhours,
    );
  }
}
