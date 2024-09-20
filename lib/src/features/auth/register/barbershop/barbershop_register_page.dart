import 'package:barbearia_tcc/src/core/ui/widgets/weekdays_panel.dart';
import 'package:flutter/material.dart';

class BarbershopRegisterPage extends StatelessWidget {
  const BarbershopRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar estabelecimento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 19,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Nome'),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('E-mail'),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const WeekdaysPanel(),
              const SizedBox(
                height: 24,
              ),
              const SizedBox(
                height: 178,
                child: Placeholder(),
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56)),
                  onPressed: () {},
                  child: const Text('CADASTRAR ESTABELECIMENTO'))
            ],
          ),
        ),
      ),
    );
  }
}
