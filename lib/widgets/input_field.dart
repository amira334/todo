import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  const InputField(
      {Key? key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Title',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.tertiary,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                      autofocus: false,
                      cursorColor:
                          Theme.of(context).textSelectionTheme.cursorColor,
                      controller: controller,
                      style: Theme.of(context).textTheme.bodyText1,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: const TextStyle(
                      color: Colors.black12,
                      //color: Theme.of(context).colorScheme.secondary,
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 0,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 0
                        )
                      )
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
