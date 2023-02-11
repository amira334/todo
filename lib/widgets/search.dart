import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  final runFilter;

  const Search({Key? key, required this.runFilter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
        onChanged: (value) => runFilter(value),
        decoration: const InputDecoration(
            //labelText: 'Search',
            contentPadding: const EdgeInsets.all(0),
            // suffixIcon: Icon(
            //   Icons.search,
            //   color: Theme.of(context).colorScheme.tertiary,
            //   size: 24,
            // ),
            suffixIconConstraints: BoxConstraints(
              maxHeight: 20,
              minWidth: 20,
            ),
            border: InputBorder.none,
            hintText: 'Find Your task',
            hintStyle: TextStyle(
              color: Colors.black12,
              //color: Theme.of(context).colorScheme.secondary,
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w600,
            )),
      ),
    );
  }
}
