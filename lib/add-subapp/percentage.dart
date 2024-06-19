import 'package:flutter/material.dart';
import 'package:fusion_ease_app/add-subapp/functions.dart';


class PercentageIndicator extends StatefulWidget {
  const PercentageIndicator({super.key, required this.subData,required this.context, required this.index});

  final dynamic subData;
  final int index;
  final BuildContext context;

  @override
  State<PercentageIndicator> createState() => _PercentageIndicatorState();
}

class _PercentageIndicatorState extends State<PercentageIndicator> {

  @override
  Widget build(BuildContext context) {

    var attendedClass = widget.subData['attended'];
    var totClass = widget.subData['total'];
    final subject = widget.subData['subject'];

    double percentage;
    if(totClass == 0) {
      percentage = 0.0;
    }else{
      percentage = attendedClass / totClass;
    }

    return Container(
      alignment: Alignment.center,
      color: Colors.purple[200],
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
        children: [
          const SizedBox(width: 20), 
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(subject,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: const TextStyle(fontSize: 20),
                        maxLines: 2),
                  ),
                ),
                FilledButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  onPressed: () {
                    presentButtonFunction(subject);
                  },
                  child: const Text('Present'),
                ),
                FilledButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  onPressed: () {
                    absentButtonFunction(subject);
                  },
                  child: const Text('Absent'),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10), 
          Stack(
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
          const SizedBox(width: 20), 
          Container(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                deleteItem(context, totClass, attendedClass ,subject);
              },
              icon: const Icon(Icons.delete_rounded, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}