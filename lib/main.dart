import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ChartSeriesController? _chartSeriesController;
  late Offset position;
  int? pointIndex;
  late final List<ChartData> chartData = <ChartData>[
    ChartData(1, 24),
    ChartData(2, 20),
    ChartData(3, 23),
    ChartData(4, 57),
    ChartData(5, 30),
    ChartData(6, 41),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: SfCartesianChart(
              onChartTouchInteractionUp: (tapArgs) {
                if (pointIndex != null) {
                  CartesianChartPoint<dynamic> dragPoint =
                      _chartSeriesController!.pixelToPoint(tapArgs.position);
                  chartData.removeAt(pointIndex!);

                  chartData.insert(chartData.length - 1,
                      ChartData(dragPoint.x, dragPoint.y as double?));

                  _chartSeriesController!
                      .updateDataSource(updatedDataIndex: pointIndex!);
                }
              },
              onChartTouchInteractionMove: (tapArgs) {
                if (pointIndex != null) {
                  CartesianChartPoint<dynamic> dragPoint =
                      _chartSeriesController!.pixelToPoint(tapArgs.position);
                  chartData.removeAt(pointIndex!);

                  chartData.insert(chartData.length - 1,
                      ChartData(dragPoint.x, dragPoint.y as double?));

                  _chartSeriesController!
                      .updateDataSource(updatedDataIndex: pointIndex!);
                }
              },
              series: <CartesianSeries<ChartData, num>>[
                LineSeries<ChartData, num>(
                  onPointLongPress: (pointInteractionDetails) {
                    pointIndex = pointInteractionDetails.pointIndex;
                  },
                  dataSource: chartData,
                  onRendererCreated: (ChartSeriesController controller) {
                    _chartSeriesController = controller;
                  },
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final num x;
  final double? y;
}