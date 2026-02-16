import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:to_do_withriverpod/Home/logic/task_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class Clander extends ConsumerStatefulWidget {
  const Clander({super.key});

  @override
  ConsumerState<Clander> createState() => _ClanderState();
}

class _ClanderState extends ConsumerState<Clander> {
  DateTime selectedDate = DateTime.now();

  List<DateTime> getDaysOfWeek(DateTime date) {
    final startOfWeek = date.subtract(Duration(days: date.weekday - 1));
    return List.generate(7, (i) => startOfWeek.add(Duration(days: i)));
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(taskListProvider);
    final days = getDaysOfWeek(selectedDate);
    final tasksForDay = tasks.where((task) =>
        task.date != null &&
        task.date!.year == selectedDate.year &&
        task.date!.month == selectedDate.month &&
        task.date!.day == selectedDate.day).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            // Horizontal calendar
            SizedBox(
              height: 80,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: days.length,
                separatorBuilder: (_, __) => SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final day = days[index];
                  final isSelected = day.year == selectedDate.year &&
                      day.month == selectedDate.month &&
                      day.day == selectedDate.day;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDate = day;
                      });
                    },
                    child: Container(
                      width: 60,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.deepPurple : Colors.grey[900],
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: isSelected ? Colors.deepPurpleAccent : Colors.white24, width: 2),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 6), // reduce padding to avoid overflow
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'][day.weekday-1],
                            style: GoogleFonts.poppins(
                              color: isSelected ? Colors.white : Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(height: 4), // reduce spacing
                          Text(
                            day.day.toString(),
                            style: GoogleFonts.poppins(
                              color: isSelected ? Colors.white : Colors.white70,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Tasks for ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}', style: GoogleFonts.poppins(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 12),
            Expanded(
              child: tasksForDay.isEmpty
                  ? Center(child: Text('No tasks for this day', style: GoogleFonts.poppins(color: Colors.white54)))
                  : ListView.builder(
                      itemCount: tasksForDay.length,
                      itemBuilder: (context, index) {
                        final task = tasksForDay[index];
                        return Card(
                          color: Colors.grey[900],
                          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: ListTile(
                            title: Text(task.title, style: GoogleFonts.poppins(color: Colors.white)),
                            trailing: task.isDone ? Icon(Icons.check_circle, color: Colors.deepPurple) : null,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}