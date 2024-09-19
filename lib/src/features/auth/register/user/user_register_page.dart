import 'package:barbearia_tcc/src/core/ui/helpers/form_helper.dart';
import 'package:barbearia_tcc/src/core/ui/helpers/messages.dart';
import 'package:barbearia_tcc/src/features/auth/register/user/user_register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class UserRegisterPage extends ConsumerStatefulWidget {
  const UserRegisterPage({super.key});

  @override
  ConsumerState<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends ConsumerState<UserRegisterPage> {
  final formKey = GlobalKey<FormState>();
  final nameEc = TextEditingController();
  final emailEc = TextEditingController();
  final passwordEc = TextEditingController();

  @override
  void dispose() {
    nameEc.dispose();
    emailEc.dispose();
    passwordEc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userRegisterVm = ref.watch(userRegisterVmProvider.notifier);

    ref.listen(userRegisterVmProvider, (_, state) {
      switch (state) {
        case UserRegisterStateStatus.initial:
          break;
        case UserRegisterStateStatus.success:
          Navigator.of(context).pushNamed('/auth/register/barbershop');
        case UserRegisterStateStatus.error:
          Messages.showError(
            'Erro ao registrar usuário administrador',
            context,
          );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
            child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onTapOutside: (_) => context.unfocus(),
                controller: nameEc,
                validator: Validatorless.required('Nome obrigatório'),
                decoration: const InputDecoration(label: Text('nome')),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                onTapOutside: (_) => context.unfocus(),
                controller: emailEc,
                validator: Validatorless.multiple([
                  Validatorless.required('E-mail obrigatório'),
                  Validatorless.email('E-mail inválido'),
                ]),
                decoration: const InputDecoration(label: Text('E-mail')),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                onTapOutside: (_) => context.unfocus(),
                controller: passwordEc,
                validator: Validatorless.multiple([
                  Validatorless.required('Senha obrigatória'),
                  Validatorless.min(6, 'Senha deve ter no minimo 6 caracteres')
                ]),
                obscureText: true,
                decoration: const InputDecoration(label: Text('Senha')),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                onTapOutside: (_) => context.unfocus(),
                validator: Validatorless.multiple([
                  Validatorless.required('Senha obrigatória'),
                  Validatorless.compare(passwordEc, 'Senha diferente ')
                ]),
                obscureText: true,
                decoration:
                    const InputDecoration(label: Text('Confirmar Senha')),
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56)),
                  onPressed: () {
                    switch (formKey.currentState?.validate()) {
                      case null || false:
                        Messages.showError('Formulário inválido', context);
                      case true:
                        userRegisterVm.register(
                            name: nameEc.text,
                            email: emailEc.text,
                            password: passwordEc.text);
                    }
                  },
                  child: const Text('CRIAR CONTA'))
            ],
          ),
        )),
      ),
    );
  }
}