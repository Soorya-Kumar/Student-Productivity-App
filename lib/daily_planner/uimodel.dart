import 'package:flutter/material.dart';

class Special extends StatelessWidget {
  const Special({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Column(
        children: [
          SizedBox(
            height: 24, // Set a fixed height for the VerticalDivider
            child: VerticalDivider(
              thickness: 2,              
              color: Color.fromARGB(255, 15, 3, 255), // Set color for VerticalDivider
            ),
          ),
          Icon(
            Icons.circle_outlined,
            size: 12,
              color: Color.fromARGB(255, 15, 3, 255),
          ),
          SizedBox(
            height: 24, // Set a fixed height for the VerticalDivider
            child: VerticalDivider(
              thickness: 2,
              color: Color.fromARGB(255, 15, 3, 255),
            ),
          ),
        ],
      ),
    );
  }
}