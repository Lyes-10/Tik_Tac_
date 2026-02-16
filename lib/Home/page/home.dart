import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:to_do_withriverpod/catigory/widget/cerat.dart';
import 'package:to_do_withriverpod/profile/widget/profile.dart';

import '../logic/task_provider.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}
class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(taskListProvider);
    final incompleteTasks = tasks.where((t) => !t.isDone).toList();
    final completeTasks = tasks.where((t) => t.isDone).toList();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(  onPressed: () {  Navigator.push(context, MaterialPageRoute(builder: (context) => Cerat())) ;}, icon: Icon(Icons.menu,size: 30,),),
                Text('Home', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
                GestureDetector(
                  onTap: () {
                         Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => Profile(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ),
                  );
                    
                  },
                  child: ClipOval(child: Image.asset('asset/Group 159.png')))
              ],
            ),
            SizedBox(height: 40),
            if (tasks.isEmpty) ...[
              SizedBox(height: 50),
              Image.asset('asset/Checklist-rafiki 1.png'),
              Spacer(),
            ] else ...[
              Expanded(
                child: ListView(
                  children: [
                    if (incompleteTasks.isNotEmpty) ...[
                      Text(' Tasks', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: incompleteTasks.length,
                        separatorBuilder: (context, index) => Divider(color: Colors.white12),
                        itemBuilder: (context, index) {
                          final task = incompleteTasks[index];
                          final realIndex = tasks.indexOf(task);
                          return ListTile(
                            leading: Icon(
                              task.isFlagged ? Icons.flag : Icons.outlined_flag,
                              color: task.isFlagged ? Colors.red : Colors.white70,
                            ),
                            title: Text(
                              task.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: task.date != null
                                ? Text(
                                    '${task.date!.year}/${task.date!.month}/${task.date!.day}',
                                    style: TextStyle(color: Colors.white54),
                                  )
                                : null,
                            trailing: Checkbox(
                              value: task.isDone,
                              onChanged: (_) {
                                ref.read(taskListProvider.notifier).toggleDone(realIndex);
                              },
                              activeColor: Colors.deepPurple,
                              checkColor: Colors.white,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 24),
                    ],
                    if (completeTasks.isNotEmpty) ...[
                      Text('Completed Tasks', style: TextStyle(color: Colors.white70, fontSize: 18, fontWeight: FontWeight.bold)),
                      Container(
                        constraints: BoxConstraints(minHeight: 80),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: completeTasks.length,
                          separatorBuilder: (context, index) => Divider(color: Colors.white12),
                          itemBuilder: (context, index) {
                            final task = completeTasks[index];
                            final realIndex = tasks.indexOf(task);
                            return ListTile(
                              leading: Icon(
                                task.isFlagged ? Icons.flag : Icons.outlined_flag,
                                color: task.isFlagged ? Colors.red : Colors.white70,
                              ),
                              title: Text(
                                task.title,
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 18,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              subtitle: task.date != null
                                  ? Text(
                                      '${task.date!.year}/${task.date!.month}/${task.date!.day}',
                                      style: TextStyle(color: Colors.white54),
                                    )
                                  : null,
                              trailing: Checkbox(
                                value: task.isDone,
                                onChanged: (_) {
                                  ref.read(taskListProvider.notifier).toggleDone(realIndex);
                                },
                                activeColor: Colors.deepPurple,
                                checkColor: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}