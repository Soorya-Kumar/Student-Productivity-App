import 'package:flutter/material.dart';

class PercentIndicator extends StatelessWidget {
  const PercentIndicator({required this.percentage, super.key});

  final double percentage;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
            alignment: Alignment.center, 
            children: [
              Text(
                '${(percentage * 100).toStringAsFixed(1)}%',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 90, 
                height: 90, 
                child: CircularProgressIndicator(
                  value: percentage,
                  strokeWidth: 10,
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.purple),
                ),
              ),
            ],
          ),
    );
  }
}
