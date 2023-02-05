import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
        decoration: InputDecoration(
          //labelText: 'Search',
            contentPadding: const EdgeInsets.all(0),
            suffixIcon: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.secondary,
              size: 24,

            ),
            suffixIconConstraints: const BoxConstraints(
              maxHeight: 20,
              minWidth: 20,
            ),
            border: InputBorder.none,
            hintText: 'Find Your task',
            hintStyle: const TextStyle(
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