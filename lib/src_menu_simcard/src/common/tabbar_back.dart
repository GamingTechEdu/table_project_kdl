import 'package:flutter/material.dart';

class TabBarBack extends StatelessWidget {
  final VoidCallback onBack;
  final String title;

  const TabBarBack({super.key,
    required this.onBack,
    required this.title
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.02),
        border: const Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: onBack,
            child: SizedBox(
              height: 45,
              child: Row(
                children: [
                  const Icon(Icons.arrow_back_outlined),
                  const SizedBox(width: 10),
                  Text(title, style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
          ),
          const Spacer(),
          Container(
            color: Colors.red,
            width: 45,
            height: 45,
          ),
        ],
      ),
    );

  }
}
