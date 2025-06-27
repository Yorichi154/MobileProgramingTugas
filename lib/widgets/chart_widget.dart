import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartWidget extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  const ChartWidget({
    super.key,
    required this.seriesList,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: charts.BarChart(
          seriesList,
          animate: animate,
          defaultRenderer: charts.BarRendererConfig(
            cornerStrategy: const charts.ConstCornerStrategy(10),
          ),
          behaviors: [
            charts.ChartTitle(
              'Performance',
              behaviorPosition: charts.BehaviorPosition.top,
              titleStyleSpec: charts.TextStyleSpec(
                fontSize: 14,
                color: charts.MaterialPalette.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
