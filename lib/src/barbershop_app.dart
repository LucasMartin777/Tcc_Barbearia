import 'package:asyncstate/asyncstate.dart';
import 'package:barbearia_tcc/src/core/ui/barbershop_nav_global_key.dart';
import 'package:barbearia_tcc/src/core/ui/barbershop_theme.dart';
import 'package:barbearia_tcc/src/core/ui/widgets/barbershop_loader.dart';
import 'package:barbearia_tcc/src/features/auth/login/login_page.dart';
import 'package:barbearia_tcc/src/features/auth/register/barbershop/barbershop_register_page.dart';
import 'package:barbearia_tcc/src/features/auth/register/user/user_register_page.dart';
import 'package:barbearia_tcc/src/features/home/adm/home_adm_page.dart';
import 'package:barbearia_tcc/src/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

class BarbershopApp extends StatelessWidget {
  const BarbershopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
        customLoader: const BarbershopLoader(),
        builder: (asyncNavigatorObserver) {
          return MaterialApp(
            theme: BarbershopTheme.themeData,
            title: 'Barbearia',
            navigatorObservers: [asyncNavigatorObserver],
            navigatorKey: BarbershopNavGlobalKey.instance.navKey,
            routes: {
              '/': (_) => const SplashPage(),
              '/auth/login': (_) => const LoginPage(),
              '/auth/register/user': (_) => const UserRegisterPage(),
              '/auth/register/barbershop': (_) =>
                  const BarbershopRegisterPage(),
              '/home/adm': (_) => const HomeAdmPage(),
              '/home/employee': (_) => const Text('EMPLOYEE'),
            },
          );
        });
  }
}
