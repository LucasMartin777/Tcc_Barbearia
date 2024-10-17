import 'dart:developer';

import 'package:barbearia_tcc/src/core/providers/application_providers.dart';
import 'package:barbearia_tcc/src/core/ui/widgets/avatar_widget.dart';
import 'package:barbearia_tcc/src/core/ui/widgets/barbershop_loader.dart';
import 'package:barbearia_tcc/src/core/ui/widgets/hours_panel.dart';
import 'package:barbearia_tcc/src/core/ui/widgets/weekdays_panel.dart';
import 'package:barbearia_tcc/src/features/employee/register/employee_register_vm.dart';
import 'package:barbearia_tcc/src/model/barbershop_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class EmployeeRegisterPage extends ConsumerStatefulWidget {
  const EmployeeRegisterPage({super.key});

  @override
  ConsumerState<EmployeeRegisterPage> createState() =>
      _EmployeeRegisterPageState();
}

class _EmployeeRegisterPageState extends ConsumerState<EmployeeRegisterPage> {
  var registerAdm = false;
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final employeeRegisterVM = ref.watch(employeeRegisterVmProvider.notifier);
    final barbershopAsyncValue = ref.watch(getMyBarbershopProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Colaborador'),
      ),
      body: barbershopAsyncValue.when(
        error: (error, stackTrace) {
          log('Erro ao carregar a pagina',
              error: error, stackTrace: stackTrace);
          return const Center(
            child: Text('Erro ao carregar a página'),
          );
        },
        loading: () => const BarbershopLoader(),
        data: (barbershopModel) {
          final BarbershopModel(:openingDays, :openingHours) = barbershopModel;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Center(
                  child: Column(
                    children: [
                      const AvatarWidget(),
                      const SizedBox(
                        height: 32,
                      ),
                      Row(
                        children: [
                          Checkbox.adaptive(
                              value: registerAdm,
                              onChanged: (value) {
                                setState(() {
                                  registerAdm = !registerAdm;
                                  employeeRegisterVM
                                      .setRegisterADM(registerAdm);
                                });
                              }),
                          const Expanded(
                            child: Text(
                              'Sou administrador e quero me cadastrar como colaborador',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          )
                        ],
                      ),
                      Offstage(
                        offstage: registerAdm,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            TextFormField(
                              controller: nameEC,
                              validator:
                                  Validatorless.required('Nome Obrigatório'),
                              decoration:
                                  const InputDecoration(label: Text('Nome')),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            TextFormField(
                              controller: emailEC,
                              validator: Validatorless.multiple([
                                Validatorless.required('E-mail obrigatório'),
                                Validatorless.email('E-mail inválido'),
                              ]),
                              decoration:
                                  const InputDecoration(label: Text('E-mail')),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            TextFormField(
                              controller: passwordEC,
                              validator: Validatorless.multiple([
                                Validatorless.required('Senha obrigatória'),
                                Validatorless.min(6,
                                    'Senha deve conter pelo menos 6 caracteres')
                              ]),
                              obscureText: true,
                              decoration:
                                  const InputDecoration(label: Text('Senha')),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      WeekdaysPanel(
                        enableDays: openingDays,
                        onDayPressed: employeeRegisterVM.addOrREmoveWorkdays,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      HoursPanel(
                        starTime: 6,
                        endTime: 23,
                        onHourPressed: employeeRegisterVM.addOrREmoveWorkhours,
                        enableTimes: openingHours,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(56)),
                        onPressed: () {},
                        child: const Text('Cadastrar colaborador'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
