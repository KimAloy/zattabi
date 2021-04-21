import 'package:flutter/material.dart';
import 'package:zattabi/config/config.dart';
import 'package:zattabi/widgets/widgets.dart';

class Location extends StatelessWidget {
  final TextEditingController districtController;
  final TextEditingController parishController;
  final Function districtValidator;
  final Function parishValidator;

  const Location({
    Key? key,
    required this.districtController,
    required this.districtValidator,
    required this.parishController,
    required this.parishValidator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kGrey50,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CardTitleText(title: 'Uganda location*'),
            // _Region(),
            const SizedBox(height: 8),
            MyTextFormField(
                labelText: 'District*',
                controller: districtController,
                validator: districtValidator),
            const SizedBox(height: 8),
            MyTextFormField(
                labelText: 'Parish*',
                controller: parishController,
                validator: parishValidator),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
