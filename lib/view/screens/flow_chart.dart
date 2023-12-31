import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/core/class/pair.dart';
import 'package:pharmageddon_web/core/constant/app_padding.dart';
import 'package:pharmageddon_web/core/resources/app_text_theme.dart';
import 'package:pharmageddon_web/print.dart';

import '../../core/constant/app_color.dart';
import '../../core/constant/app_text.dart';
import '../../core/functions/functions.dart';
import '../../model/order_model.dart';

class FlowChart extends StatefulWidget {
  const FlowChart({
    super.key,
    required this.data,
  });

  final List<OrderModel> data;

  @override
  State<FlowChart> createState() => _FlowChartState();
}

class _FlowChartState extends State<FlowChart> {
  List<OrderModel> data = [];
  List<FlSpot> spots = [];
  double maxX = 0.0, width = 1000, _maxTotalPrice = 0.0;
  double maxY = 110.0;
  final _interval = 5.0;
  final _gradientColors = [
    AppColor.contentColorCyan,
    AppColor.contentColorBlue,
  ];
  bool _isCollapsed = true;

  @override
  void initState() {
    _draw();
    super.initState();
  }

  void _draw() {
    _isCollapsed = !_isCollapsed;
    _isCollapsed ? _drawDataCollapse() : _drawDataExpand();
    setState(() {});
  }

  void _drawDataExpand() {
    _maxTotalPrice = 0;
    spots.clear();
    data.clear();
    data.addAll(widget.data);
    data = data.reversed.toList();
    double i = 0;
    // calc max total price
    for (final e in data) {
      final x = e.totalPrice ?? 0.0;
      _maxTotalPrice = max(_maxTotalPrice, x);
    }
    for (final e in data) {
      final x = e.totalPrice ?? 0.0;
      spots.add(FlSpot(i, x));
      i += _interval;
    }
    maxX = data.length * _interval;
    maxY = _maxTotalPrice + (_maxTotalPrice * 0.05);
    width = max(width, data.length * 40);
  }

  final Map<String, Pair<double, String>> _dataCollapsed = {};
  List<Pair<double, String>> list = [];

  void _drawDataCollapse() {
    maxY = 110.0;
    _maxTotalPrice = 0;
    spots.clear();
    list.clear();
    data.clear();
    data.addAll(widget.data.toList());
    data = data.reversed.toList();
    maxX = data.length * _interval;
    // calc max total price
    for (final e in data) {
      final date = DateTime.tryParse(e.createdAt ?? '') ?? DateTime.now();
      final k = '${date.day} - ${date.month}';
      final x = e.totalPrice ?? 0.0;
      final old = _dataCollapsed[k]?.key ?? 0.0;
      printme.green('${e.createdAt} $k : $old');
      _dataCollapsed[k] = Pair(old + x, k);
      _maxTotalPrice = max(_maxTotalPrice, old + x);
      maxY = max(maxY, _maxTotalPrice);
    }
    printme.red(_dataCollapsed.length);
    double i = 0;
    for (final e in _dataCollapsed.entries) {
      list.add(Pair(e.value.key, e.value.value));
      spots.add(FlSpot(i, e.value.key));
      i += _interval;
    }
    maxX = list.length * _interval;
    maxY = _maxTotalPrice + (_maxTotalPrice * 0.05);
    width = max(width, list.length * 40);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        clipBehavior: Clip.hardEdge,
        padding: AppPadding.padding5,
        decoration: BoxDecoration(
          color: AppColor.pageBackground,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: AppColor.cardColor,
              ),
              onPressed: _draw,
              child: Text(
                _isCollapsed ? AppText.expand.tr : AppText.collapse.tr,
              ),
            ),
            Expanded(
              child: LineChart(
                LineChartData(
                  maxX: maxX,
                  maxY: maxY,
                  minX: 0,
                  minY: 0,
                  gridData: FlGridData(
                    show: true,
                    verticalInterval: _interval,
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      axisNameWidget: Text(
                        AppText.days.tr,
                        style: AppTextStyle.f12cardColor,
                      ),
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 60,
                        interval: 1,
                        getTitlesWidget: bottomTitleWidgets,
                      ),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: false,
                      gradient: LinearGradient(colors: _gradientColors),
                      barWidth: 3,
                      isStrokeCapRound: true,
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: _gradientColors
                              .map((color) => color.withOpacity(0.3))
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final i = value.toInt() ~/ _interval;
    var t = ' ';
    if (_isCollapsed) {
      if (i < list.length && value.toInt() % _interval == 0) {
        t = list[i].value;
      } else {
        t = '';
      }
    } else {
      if (i < data.length && value.toInt() % _interval == 0) {
        t = formatDM(data[i].createdAt);
      } else {
        t = '';
      }
    }
    final text = Center(
      child: Transform.rotate(
        angle: pi / 2,
        child: Text(t, style: AppTextStyle.f12cardColor),
      ),
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    String text = value.toString();
    if (value > 100 || value.toInt() % _interval.toInt() != 0) text = '';
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: AppTextStyle.f12cardColor),
    );
  }

  double _getPercentY(double value) {
    return value * 100 / _maxTotalPrice;
  }

  void _drawDataCollapsePercent() {
    maxY = 110.0;
    _maxTotalPrice = 0;
    spots.clear();
    list.clear();
    data.clear();
    data.addAll(widget.data.toList());
    maxX = data.length * _interval;
    // calc max total price
    for (final e in data) {
      final date = DateTime.tryParse(e.createdAt ?? '') ?? DateTime.now();
      final k = '${date.day} - ${date.month}';
      final x = e.totalPrice ?? 0.0;
      final old = _dataCollapsed[k]?.key ?? 0.0;
      _dataCollapsed[k] = Pair(old + x, k);
      _maxTotalPrice = max(_maxTotalPrice, old + x);
    }
    double i = 0;
    for (final e in _dataCollapsed.entries) {
      list.add(Pair(_getPercentY(e.value.key), e.value.value));
      spots.add(FlSpot(i, _getPercentY(e.value.key)));
      i += _interval;
    }
    maxX = list.length * _interval;
    width = max(width, list.length * 40);
  }

  void _drawDataExpandPercent() {
    _maxTotalPrice = 0;
    maxY = 110.0;
    spots.clear();
    data.clear();
    data.addAll(widget.data);
    double i = 0;
    // calc max total price
    for (final e in data) {
      final x = e.totalPrice ?? 0.0;
      _maxTotalPrice = max(_maxTotalPrice, x);
    }
    for (final e in data) {
      final x = e.totalPrice ?? 0.0;
      spots.add(FlSpot(i, _getPercentY(x)));
      i += _interval;
    }
    maxX = data.length * _interval;
    width = max(width, data.length * 40);
  }
}
