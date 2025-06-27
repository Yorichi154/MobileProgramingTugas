import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Statistik Pengguna')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 100,
            barTouchData: BarTouchData(enabled: true),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 30),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final labels = ['Jan', 'Feb', 'Mar', 'Apr'];
                    return Text(labels[value.toInt()]);
                  },
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
            barGroups: [
              BarChartGroupData(x: 0, barRods: [
                BarChartRodData(toY: 40, color: Colors.indigo),
              ]),
              BarChartGroupData(x: 1, barRods: [
                BarChartRodData(toY: 65, color: Colors.indigo),
              ]),
              BarChartGroupData(x: 2, barRods: [
                BarChartRodData(toY: 55, color: Colors.indigo),
              ]),
              BarChartGroupData(x: 3, barRods: [
                BarChartRodData(toY: 80, color: Colors.indigo),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
