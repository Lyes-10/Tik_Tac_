

import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_withriverpod/clander/widget/clander.dart';
import 'package:to_do_withriverpod/foucs/widget/foucs.dart';
import 'package:to_do_withriverpod/profile/widget/profile.dart';
import '../Home/logic/task_provider.dart';
import '../Home/page/home.dart';

class BottomNav extends ConsumerStatefulWidget {
	const BottomNav({Key? key}) : super(key: key);

	@override
	ConsumerState<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends ConsumerState<BottomNav> {
	int _selectedIndex = 0;
	int _previousIndex = 0;

			static final List<Widget> _pages = <Widget>[
					Home(),
					Foucs(),
					// The Add Task page is not used, as we show a modal instead
					Center(child: Text('Add Task', style: TextStyle(fontSize: 24))),
          Profile(),
          Clander(),
          	
					
				
			];

				void _showAddTaskModal(BuildContext context) {
					DateTime? selectedDate;
					bool isFlagged = false;
					final titleController = TextEditingController();
					showModalBottomSheet(
						context: context,
						isScrollControlled: true,
						backgroundColor: Colors.grey[900],
						shape: const RoundedRectangleBorder(
							borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
						),
						builder: (context) {
							return StatefulBuilder(
								builder: (context, setModalState) {
									return Padding(
										padding: EdgeInsets.only(
											left: 20,
											right: 20,
											top: 24,
											bottom: MediaQuery.of(context).viewInsets.bottom + 24,
										),
										child: Column(
											mainAxisSize: MainAxisSize.min,
											crossAxisAlignment: CrossAxisAlignment.start,
											children: [
												Text('Add Task', style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold)),
												SizedBox(height: 16),
												TextField(
													controller: titleController,
													decoration: InputDecoration(
														hintText: 'Task title',
														hintStyle: TextStyle(color: Colors.white54),
														filled: true,
														fillColor: Colors.black,
														border: OutlineInputBorder(
															borderRadius: BorderRadius.circular(12),
															borderSide: BorderSide.none,
														),
													),
													style: TextStyle(color: Colors.white),
												),
												SizedBox(height: 16),
												Row(
													children: [
														// Date picker icon
														IconButton(
															icon: Icon(Icons.calendar_today, color: Colors.white70),
															tooltip: 'Pick a date',
															onPressed: () async {
																final now = DateTime.now();
																final picked = await showDatePicker(
																	context: context,
																	initialDate: now,
																	firstDate: now,
																	lastDate: DateTime(now.year + 5),
																	builder: (context, child) {
																		return Theme(
																			data: ThemeData.dark().copyWith(
																				colorScheme: ColorScheme.dark(
																					primary: Colors.deepPurple,
																					onPrimary: Colors.white,
																					surface: Colors.grey[900]!,
																					onSurface: Colors.white,
																				),
																				dialogBackgroundColor: Colors.black,
																			),
																			child: child!,
																		);
																	},
																);
																if (picked != null) {
																	setModalState(() {
																		selectedDate = picked;
																	});
																}
															},
														),
														Text(
															selectedDate == null
																	? 'No date'
																	: '${selectedDate!.year}/${selectedDate!.month}/${selectedDate!.day}',
															style: TextStyle(color: Colors.white70),
														),
														Spacer(),
														// Flag icon
														IconButton(
															icon: Icon(
																isFlagged ? Icons.flag : Icons.outlined_flag,
																color: isFlagged ? Colors.red : Colors.white70,
															),
															tooltip: 'Mark as important',
															onPressed: () {
																setModalState(() {
																	isFlagged = !isFlagged;
																});
															},
														),
														Text('Flag', style: TextStyle(color: Colors.white70)),
													],
												),
												SizedBox(height: 16),
												ElevatedButton(
													style: ElevatedButton.styleFrom(
														backgroundColor: Colors.deepPurple,
														minimumSize: Size(double.infinity, 48),
														shape: RoundedRectangleBorder(
															borderRadius: BorderRadius.circular(12),
														),
													),
													onPressed: () {
														if (titleController.text.trim().isNotEmpty) {
															ref.read(taskListProvider.notifier).addTask(
																Task(
																	title: titleController.text.trim(),
																	date: selectedDate,
																	isFlagged: isFlagged,
																),
															);
														}
														Navigator.pop(context);
													},
													child: Text('Add Task', style: TextStyle(fontSize: 18, color: Colors.white)),
												),
											],
										),
									);
								},
							);
						},
					);
				}

		void _onItemTapped(int index) {
			setState(() {
				_previousIndex = _selectedIndex;
				_selectedIndex = index;
			});
		}

		@override
		Widget build(BuildContext context) {
								return Scaffold(
										body: PageTransitionSwitcher(
												duration: Duration(milliseconds: 400),
												reverse: _selectedIndex < _previousIndex,
																		transitionBuilder: (child, animation, secondaryAnimation) {
																			return FadeThroughTransition(
																				animation: animation,
																				secondaryAnimation: secondaryAnimation,
																				child: child,
																				fillColor: Colors.black,
																			);
																		},
												child: _pages[_selectedIndex],
										),
					floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
					floatingActionButton: FloatingActionButton(
						backgroundColor: Colors.deepPurple,
						onPressed: () {
							_showAddTaskModal(context);
						},
						child: Icon(Icons.add, color: Colors.white),
						tooltip: 'Add Task',
					),
					bottomNavigationBar: BottomAppBar(
						color: Colors.black,
						shape: const CircularNotchedRectangle(),
						notchMargin: 8.0,
						child: SizedBox(
							height: 60,
							child: Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: <Widget>[
									Row(
										children: [
											MaterialButton(
												minWidth: 40,
												onPressed: () => _onItemTapped(0),
												child: Column(
													mainAxisAlignment: MainAxisAlignment.center,
													children: [
														Icon(Icons.home, color: _selectedIndex == 0 ? Colors.deepPurple : Colors.white70),
														Text('Home', style: TextStyle(color: _selectedIndex == 0 ? Colors.deepPurple : Colors.white70)),
													],
												),
											),
											MaterialButton(
												minWidth: 40,
												onPressed: () => _onItemTapped(1),
												child: Column(
													mainAxisAlignment: MainAxisAlignment.center,
													children: [
														Icon(Icons.check_circle_outline, color: _selectedIndex == 1 ? Colors.deepPurple : Colors.white70),
														Text('Focus', style: TextStyle(color: _selectedIndex == 1 ? Colors.deepPurple : Colors.white70)),
													],
												),
											),
										],
									),
									Row(
										children: [
											MaterialButton(
												minWidth: 40,
												onPressed: () => _onItemTapped(4),
												child: Column(
													mainAxisAlignment: MainAxisAlignment.center,
													children: [
														Icon(Icons.calendar_today, color: _selectedIndex == 4 ? Colors.deepPurple : Colors.white70),
														Text('Clander', style: TextStyle(color: _selectedIndex == 4 ? Colors.deepPurple : Colors.white70)),
													],
												),
											),
											MaterialButton(
												minWidth: 40,
												onPressed: () => _onItemTapped(3),
												child: Column(
													mainAxisAlignment: MainAxisAlignment.center,
													children: [
														Icon(Icons.person, color: _selectedIndex == 3 ? Colors.deepPurple : Colors.white70),
														Text('Profile', style: TextStyle(color: _selectedIndex == 3 ? Colors.deepPurple : Colors.white70)),
													],
												),
											),
										],
									),
								],
							),
						),
					),
				);
		}
}

