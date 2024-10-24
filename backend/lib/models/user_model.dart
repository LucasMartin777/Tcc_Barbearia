class UserModel {
  final int id;
  final String name;
  final String email;
  final String? avatar;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
  });

  // Método para converter JSON em UserModel
  factory UserModel.fromMap(Map<String, dynamic> json) {
    switch (json['profile']) {
      case 'ADM':
        return UserModelADM.fromMap(json);
      case 'EMPLOYEE':
        return UserModelEmployee.fromMap(json);
      default:
        throw FormatException('Invalid UserModel JSON: $json');
    }
  }

  // Método para converter UserModel em JSON
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
    };
  }
}

class UserModelADM extends UserModel {
  final List<String>? workDays;
  final List<int>? workHours;

  UserModelADM({
    required int id,
    required String name,
    required String email,
    String? avatar,
    this.workDays,
    this.workHours,
  }) : super(id: id, name: name, email: email, avatar: avatar);

  // Método para converter JSON em UserModelADM
  factory UserModelADM.fromMap(Map<String, dynamic> json) {
    return UserModelADM(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
      workDays: json['work_days']?.cast<String>(),
      workHours: json['work_hours']?.cast<int>(),
    );
  }

  // Método para converter UserModelADM em JSON
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'work_days': workDays,
      'work_hours': workHours,
    });
    return map;
  }
}

class UserModelEmployee extends UserModel {
  final int barbershopId;
  final List<String> workDays;
  final List<int> workHours;

  UserModelEmployee({
    required int id,
    required String name,
    required String email,
    String? avatar,
    required this.barbershopId,
    required this.workDays,
    required this.workHours,
  }) : super(id: id, name: name, email: email, avatar: avatar);

  // Método para converter JSON em UserModelEmployee
  factory UserModelEmployee.fromMap(Map<String, dynamic> json) {
    return UserModelEmployee(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
      barbershopId: json['barbershop_id'],
      workDays: json['work_days'].cast<String>(),
      workHours: json['work_hours'].cast<int>(),
    );
  }

  // Método para converter UserModelEmployee em JSON
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'barbershop_id': barbershopId,
      'work_days': workDays,
      'work_hours': workHours,
    });
    return map;
  }
}
