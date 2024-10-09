import 'package:barbearia_tcc/src/core/ui/barbershop_icons.dart';
import 'package:barbearia_tcc/src/core/ui/constants.dart';
import 'package:barbearia_tcc/src/features/home/adm/widgets/home_employee_title.dart';
import 'package:barbearia_tcc/src/features/home/widgets/home_header.dart';
import 'package:flutter/material.dart';

class HomeAdmPage extends StatelessWidget {
  const HomeAdmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: ColorsConstants.brow,
        onPressed: () {},
        child: const CircleAvatar(
          backgroundColor: Colors.white,
          maxRadius: 12,
          child: Icon(
            BarbershopIcons.addEmployee,
            color: ColorsConstants.brow,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: HomeHeader(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => const HomeEmployeeTitle(),
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
