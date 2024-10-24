import 'package:barbearia_tcc/src/core/ui/constants.dart';
import 'package:barbearia_tcc/src/model/schedule_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource({
    required this.schedules,
  });

  final List<ScheduleModel> schedules;

  @override
  List<dynamic>? get appointments => schedules.map((e) {
        final ScheduleModel(
          date: DateTime(:year, :month, :day),
          :hour,
          :clientName,
        ) = e;

        final startTime = DateTime(year, month, day, hour, 0, 0);
        final endTime = DateTime(year, month, day, hour + 1, 0, 0);

        return Appointment(
          color: ColorsConstants.brow,
          startTime: startTime,
          endTime: endTime,
          subject: clientName,
        );
      }).toList();
}
