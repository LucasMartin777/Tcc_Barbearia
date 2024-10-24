

import 'package:barbearia_tcc/src/core/exceptions/repository_execption.dart';
import 'package:barbearia_tcc/src/core/fp_funcional_program/eitheri.dart';
import 'package:barbearia_tcc/src/core/fp_funcional_program/nil.dart';
import 'package:barbearia_tcc/src/model/schedule_model.dart';

abstract interface class ScheduleRepository {
  Future<Either<RepositoryException, Nil>> sheduleClient(
    ({
      int barbershopId,
      int userId,
      String clientName,
      DateTime date,
      int time
    }) scheduleData
  );

  Future<Either<RepositoryException, List<ScheduleModel>>> findScheduleByDate(
    ({
      DateTime date,
      int userId,
    }) filter );
}