import 'package:flutter/material.dart';
import 'package:flutter_nikeapp/presentation/misc/nike_font.dart';

import '../misc/debouncer.dart';

class SearchForm extends StatelessWidget {
  final TextEditingController searchC;
  final String hintText;
  final String label;
  final VoidCallback debouncerFunc;
  final VoidCallback suffixOnPressed;
  final Function(String value) onSubmitted;
  const SearchForm({
    super.key,
    required this.searchC,
    required this.hintText,
    required this.label,
    required this.debouncerFunc,
    required this.suffixOnPressed,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final Debouncer debouncer = Debouncer(duration: const Duration(milliseconds: 800));

    return TextField(
      controller: searchC,
      onSubmitted: onSubmitted,
      onChanged: (value) {
        debouncer.run(debouncerFunc);
      },
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: suffixOnPressed,
          icon: const Icon(
            Icons.search_rounded,
            size: 28,
            color: Colors.black87,
          ),
        ),
        hintText: hintText,
        hintStyle: NikeFont.h5Regular(),
        label: Text(
          label,
          style: NikeFont.h5Regular(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        focusColor: Colors.black54,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
