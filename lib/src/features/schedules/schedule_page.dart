import 'package:barbearia_tcc/src/core/ui/barbershop_icons.dart';
import 'package:barbearia_tcc/src/core/ui/constants.dart';
import 'package:barbearia_tcc/src/core/ui/helpers/form_helper.dart';
import 'package:barbearia_tcc/src/core/ui/helpers/messages.dart';
import 'package:barbearia_tcc/src/core/ui/widgets/avatar_widget.dart';
import 'package:barbearia_tcc/src/core/ui/widgets/hours_panel.dart';
import 'package:barbearia_tcc/src/features/schedules/widgets/schedule_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  var dateFOrmat = DateFormat('dd/MM/yyyy');
  var showCalendar = false;
  final formKey = GlobalKey<FormState>();
  final clientEC = TextEditingController();
  final dateEC = TextEditingController();

  @override
  void dispose() {
    clientEC.dispose();
    dateEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendar Cliente'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                children: [
                  const AvatarWidget(
                    hideUploadButton: true,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    'Nome e Sobrenome',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 37,
                  ),
                  TextFormField(
                    controller: clientEC,
                    validator: Validatorless.required('Cliente obrigatório'),
                    decoration: const InputDecoration(label: Text('Cliente')),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: dateEC,
                    validator: Validatorless.required(
                        'selecione a data do agendamento'),
                    onTap: () {
                      setState(() {
                        showCalendar = true;
                      });
                      context.unfocus();
                    },
                    decoration: const InputDecoration(
                      label: Text('Selecione uma data'),
                      hintText: 'selecione uma data',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      suffixIcon: Icon(
                        BarbershopIcons.calendar,
                        color: ColorsConstants.brow,
                        size: 18,
                      ),
                    ),
                  ),
                  Offstage(
                    offstage: !showCalendar,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        ScheduleCalendar(
                          cancelPressed: () {
                            setState(() {
                              showCalendar = false;
                            });
                          },
                          okPressed: (DateTime value) {
                            setState(() {
                              dateEC.text = dateFOrmat.format(value);
                              showCalendar = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  HoursPanel(
                    starTime: 6,
                    endTime: 23,
                    onHourPressed: (hour) {},
                    enableTimes: const [6, 7, 8],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(56),
                      ),
                      onPressed: () {
                        switch (formKey.currentState?.validate()) {
                          case null || false:
                            Messages.showError('Dados incompletos', context);
                          case true:
                        }
                      },
                      child: const Text('AGENDAR'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}