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
      margin: const EdgeInsets.symmetric(
        vertical: 5
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Container(
            height: 42,
            margin: const EdgeInsets.only(top: 8),
            padding: EdgeInsets.only(left:15),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFd0e0de),
                width: 1,
              ),
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget==null?false:true,
                      autofocus: false,
                      cursorColor:
                          Theme.of(context).textSelectionTheme.cursorColor,
                      controller: controller,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: const TextStyle(
                      color: Colors.black26,
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      //fontWeight: FontWeight.w600,
                    ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFF5d8e8a),
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(15),

                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 0
                        ),
                        borderRadius: BorderRadius.circular(15),
                      )
                    ),
                  ),
                ),
                widget==null?Container():Container(child: widget,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
