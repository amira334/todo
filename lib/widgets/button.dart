import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final Function()? onTap;

  const Button({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        width: 110,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyText2
          ),
        ),
      ),
    );
  }
}
