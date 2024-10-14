import 'package:barbearia_tcc/src/core/ui/widgets/avatar_widget.dart';
import 'package:flutter/material.dart';

class EmployeeRegisterPage extends StatelessWidget {
  const EmployeeRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Colaborador'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const AvatarWidget(),
              const SizedBox(
                height: 32,
              ),
              Row(
                children: [
                  Checkbox.adaptive(value: false, onChanged: (value) {}),
                  const Expanded(
                    child: Text(
                      'Sou administrador e quero me cadastrar como colaborador',
                      style: TextStyle(fontSize: 14),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  TextFormField(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
