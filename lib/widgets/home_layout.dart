import 'package:assignment_custom_randomiser/utils/graph_visualization.dart';
import 'package:assignment_custom_randomiser/widgets/action_cards.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeExplorer extends StatelessWidget {
  const HomeExplorer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GridView.count(
            crossAxisCount: 1,
            childAspectRatio: 3.0,
            children: [
              ActionCard(
                cardTopic: "Contacts",
              ),
              ActionCard(
                cardTopic: "Assignments",
              ),
              ActionCard(
                cardTopic: "SomeCoolFeature",
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 35.0, horizontal: 10.0),
                child: LineChartSample1(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
