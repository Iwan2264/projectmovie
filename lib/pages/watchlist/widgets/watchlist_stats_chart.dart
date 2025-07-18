import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class WatchlistStatsChart extends StatelessWidget {
  final int watched;
  final int planToWatch;
  final int rewatched;
  final int dropped;

  const WatchlistStatsChart({
    super.key,
    required this.watched,
    required this.planToWatch,
    required this.rewatched,
    required this.dropped,
  });

  @override
  Widget build(BuildContext context) {
    final dataMap = {
      'Watched': watched.toDouble(),
      'Plan to Watch': planToWatch.toDouble(),
      'Rewatched': rewatched.toDouble(),
      'Dropped': dropped.toDouble(),
    };

    final colorList = [
      const Color(0xFFB2F5EA),
      const Color(0xFF63B3ED),
      const Color(0xFF2C5282), 
      const Color(0xFFFF784E),
    ];

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PieChart(
          dataMap: dataMap,
          animationDuration: const Duration(milliseconds: 800),
          chartType: ChartType.ring,
          chartLegendSpacing: 32,
          ringStrokeWidth: 32,
          legendOptions: const LegendOptions(
            showLegends: true,
            legendPosition: LegendPosition.right,
            legendTextStyle: TextStyle(fontWeight: FontWeight.w500),
          ),
          chartValuesOptions: const ChartValuesOptions(
            showChartValues: false,
          ),
          colorList: colorList,
          totalValue: (watched + planToWatch + rewatched + dropped).toDouble(),
        ),
      ),
    );
  }
}
