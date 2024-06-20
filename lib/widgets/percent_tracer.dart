import 'package:flutter/material.dart';

class PercentIndicator extends StatelessWidget {
  const PercentIndicator({required this.percentage, super.key});

  final double percentage;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
      child: Stack(
            alignment: Alignment.center, 
            children: [
              Text(
                '${(percentage * 100).toInt()}%',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 120, 
                height: 120, 
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
