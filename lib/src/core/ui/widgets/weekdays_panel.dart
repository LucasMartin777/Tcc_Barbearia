import 'package:barbearia_tcc/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class WeekdaysPanel extends StatelessWidget {
  const WeekdaysPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Selecione os dias da semana',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Container(
              width: 40,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                border: Border.all(color: ColorsConstants.grey),
              ),
              child: const Center(
                child: Text(
                  'Seg',
                  style: TextStyle(
                      fontSize: 12,
                      color: ColorsConstants.grey,
                      fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
