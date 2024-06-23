import 'package:flutter/material.dart';

class PercentIndicator extends StatelessWidget {
  const PercentIndicator({required this.completed, required this.total, super.key});

  final int completed;
  final int total;
  @override
  Widget build(BuildContext context) {

    double percentage;
    if(total == 0){
      percentage = 0.0;
    } else {
      percentage = completed / total;
    }

    return SizedBox(
      height: 200,
      width: 200,
      child: Stack(
            alignment: Alignment.center, 
            children: [
                
            if (total == 0)
              const Text(
                '- % -',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

            if (total != 0)
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
