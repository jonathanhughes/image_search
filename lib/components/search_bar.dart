import 'dart:async';

import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final Function onChanged;

  const SearchBar({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late Timer _searchTimer = Timer(Duration.zero, () {});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (text) {
        _searchTimer.cancel();
        _searchTimer = Timer(const Duration(milliseconds: 700), () {
          widget.onChanged(text);
        });
      },
      decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Enter a search term'),
    );
  }
}
