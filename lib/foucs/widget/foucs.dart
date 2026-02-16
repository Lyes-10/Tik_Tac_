import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Foucs extends ConsumerStatefulWidget {
  const Foucs({super.key});

  @override
  ConsumerState<Foucs> createState() => _FoucsState();
}

class _FoucsState extends ConsumerState<Foucs> {
  // Example phone usage data: hours used per day (Mon-Sun)
  final List<double> phoneUsageHours = [2, 3.5, 1, 4, 2.5, 5, 3];
  int totalSeconds = 25 * 60; // default 25 minutes
  int remainingSeconds = 25 * 60;
  String selectedMode = 'Day';
  void _chooseMode() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Day', style: TextStyle(color: Colors.white)),
              onTap: () => Navigator.pop(context, 'Day'),
            ),
            ListTile(
              title: Text('Week', style: TextStyle(color: Colors.white)),
              onTap: () => Navigator.pop(context, 'Week'),
            ),
            ListTile(
              title: Text('Month', style: TextStyle(color: Colors.white)),
              onTap: () => Navigator.pop(context, 'Month'),
            ),
          ],
        );
      },
    );
    if (result != null) {
      setState(() {
        selectedMode = result;
        if (result == 'Day') {
          totalSeconds = 25 * 60;
        } else if (result == 'Week') {
          totalSeconds = 7 * 25 * 60;
        } else if (result == 'Month') {
          totalSeconds = 30 * 25 * 60;
        }
        remainingSeconds = totalSeconds;
        isRunning = false;
        _timer?.cancel();
      });
    }
  }

  bool isRunning = false;
  Timer? _timer;

  void _startTimer() {
    setState(() {
      isRunning = true;
      remainingSeconds = totalSeconds;
    });
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0 && isRunning) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        timer.cancel();
        setState(() {
          isRunning = false;
        });
      }
    });
  }

  void _stopTimer() {
    setState(() {
      isRunning = false;
    });
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  // Example top 4 apps (mock data)
  final List<Map<String, dynamic>> topApps = [
    {'name': 'WhatsApp', 'icon': FontAwesomeIcons.whatsapp, 'hours': 2.5},
    {'name': 'YouTube', 'icon': FontAwesomeIcons.youtube, 'hours': 1.8},
    {'name': 'Instagram', 'icon': FontAwesomeIcons.instagram, 'hours': 1.2},
    {'name': 'Facebook', 'icon': FontAwesomeIcons.facebook, 'hours': 0.9},
  ];

  @override
  Widget build(BuildContext context) {
    double progress = 1 - (remainingSeconds / totalSeconds);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Focus Mode',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 220,
                width: 220,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularPercentIndicator(
                      radius: 110.0,
                      lineWidth: 12.0,
                      percent: progress,
                      center: Text(
                        _formatTime(remainingSeconds),
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: Colors.grey[900]!,
                      progressColor: Colors.deepPurple,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              isRunning
                  ? ElevatedButton(
                      onPressed: _stopTimer,
                      child: Text(
                        'Stop',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 16,
                        ),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: _startTimer,
                      child: Text(
                        'Start',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 16,
                        ),
                      ),
                    ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Overview',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _chooseMode,
                    icon: Icon(Icons.arrow_drop_down, color: Colors.deepPurple),
                    label: Text(
                      'Choose: $selectedMode',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      backgroundColor: Colors.deepPurple.withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Text(
                'Phone Usage (hours per day)',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                height: 220,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 6,
                    barTouchData: BarTouchData(enabled: true),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: GoogleFonts.poppins(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const days = [
                              'Mon',
                              'Tue',
                              'Wed',
                              'Thu',
                              'Fri',
                              'Sat',
                              'Sun',
                            ];
                            return Text(
                              days[value.toInt()],
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            );
                          },
                        ),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(show: false),
                    barGroups: List.generate(
                      7,
                      (i) => BarChartGroupData(
                        x: i,
                        barRods: [
                          BarChartRodData(
                            toY: phoneUsageHours[i],
                            color: Colors.deepPurple,
                            width: 22,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32),
              Text(
                'Top 4 Apps Used',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: topApps.length,
                separatorBuilder: (_, __) => SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final app = topApps[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: FaIcon(
                        app['icon'],
                        color: Colors.deepPurple,
                        size: 32,
                      ),
                      title: Text(
                        app['name'],
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Text(
                        '${app['hours']} hrs',
                        style: GoogleFonts.poppins(color: Colors.white70),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
