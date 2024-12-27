import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class AnalyticsWidget extends StatefulWidget {
  const AnalyticsWidget({Key? key}) : super(key: key);

  @override
  State<AnalyticsWidget> createState() => _AnalyticsWidgetState();
}

class _AnalyticsWidgetState extends State<AnalyticsWidget> {
  // Data storage for the analytics charts
  List<FlSpot> juneData = [];
  List<FlSpot> julyData = [];
  List<FlSpot> augustData = [];
  List<FlSpot> septemberData = [];

  @override
  void initState() {
    super.initState();
    _fetchAnalyticsData();
  }

  // Fetch data from Firestore
  Future<void> _fetchAnalyticsData() async {
    try {
      // Fetch analytics data for different months
      final juneSnapshot = await FirebaseFirestore.instance.collection('analytics').doc('june').get();
      final julySnapshot = await FirebaseFirestore.instance.collection('analytics').doc('july').get();
      final augustSnapshot = await FirebaseFirestore.instance.collection('analytics').doc('august').get();
      final septemberSnapshot = await FirebaseFirestore.instance.collection('analytics').doc('september').get();

      setState(() {
        // Assume each document contains a list of points for that month
        juneData = _getFlSpots(juneSnapshot);
        julyData = _getFlSpots(julySnapshot);
        augustData = _getFlSpots(augustSnapshot);
        septemberData = _getFlSpots(septemberSnapshot);
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  // Helper function to convert Firestore data to FlSpot
  List<FlSpot> _getFlSpots(DocumentSnapshot snapshot) {
    List<FlSpot> spots = [];
    List<dynamic> data = snapshot['data']; // Assuming data is an array of [x, y] points

    for (var point in data) {
      spots.add(FlSpot(point[0].toDouble(), point[1].toDouble()));
    }

    return spots;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Analytics',
          style: GoogleFonts.bubblegumSans(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE989BE), Color(0xFF6A1B9A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF4F9FD), Color(0xFFE1EAF5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const SizedBox(height: 10),
              _buildSection('JUNE', const Color(0xFFE989BE)),
              const SizedBox(height: 20),
              _buildChart(juneData),
              const SizedBox(height: 30),
              _buildSection('JULY', const Color(0xFFE989BE)),
              const SizedBox(height: 20),
              _buildChart(julyData),
              const SizedBox(height: 30),
              _buildSection('AUGUST', const Color(0xFFE989BE)),
              const SizedBox(height: 20),
              _buildChart(augustData),
              const SizedBox(height: 30),
              _buildSection('SEPTEMBER', const Color(0xFFE989BE)),
              const SizedBox(height: 20),
              _buildChart(septemberData),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          title,
          style: GoogleFonts.bubblegumSans(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: color,
          ),
        ),
      ),
    );
  }

  Widget _buildChart(List<FlSpot> data) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 150,
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: data,
                  isCurved: true,
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE989BE), Color(0xFF6A1B9A)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  barWidth: 4,
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF6A1B9A).withOpacity(0.3),
                        const Color(0xFF6A1B9A).withOpacity(0.3),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  dotData: FlDotData(show: false),
                ),
              ],
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toInt().toString(),
                        style: GoogleFonts.bubblegumSans(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF444444),
                        ),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toInt().toString(),
                        style: GoogleFonts.bubblegumSans(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF444444),
                        ),
                      );
                    },
                  ),
                ),
              ),
              gridData: FlGridData(
                show: true,
                drawHorizontalLine: true,
                drawVerticalLine: false,
                horizontalInterval: 1,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: const Color(0xFFCCCCCC),
                  strokeWidth: 1,
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: const Border(
                  left: BorderSide(color: Color(0xFFCCCCCC), width: 1),
                  bottom: BorderSide(color: Color(0xFFCCCCCC), width: 1),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
