import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key, required this.onChanched});

  final void Function(String val) onChanched;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hint: Text('Search for posts'),
        suffixIcon: Icon(Icons.search),

        border: InputBorder.none,
      ),
      onChanged: onChanched,
    );
  }
}
