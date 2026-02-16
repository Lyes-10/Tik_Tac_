import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Cerat extends ConsumerStatefulWidget {
  const Cerat({super.key});

  @override
  ConsumerState<Cerat> createState() => _CeratState();
}
class _CeratState extends ConsumerState<Cerat> {
  int selectedIconIndex = 0;
  final List<IconData> categoryIcons = [
    Icons.work,
    Icons.home,
    Icons.school,
    Icons.shopping_cart,
    Icons.fitness_center,
    Icons.book,
    Icons.music_note,
    Icons.fastfood,
    Icons.pets,
    Icons.star,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back_ios, color: Colors.white,)),
                  Text('Create new category', style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),),
                ],
              ),
              SizedBox(height: 20),
              Text('Category name :', style: TextStyle(
                color: Colors.white70,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 20),
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[900],
                  hintText: 'Enter category name',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text('Choose an icon:', style: TextStyle(color: Colors.white70, fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              SizedBox(
                height: 60,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryIcons.length,
                  separatorBuilder: (_, __) => SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final isSelected = selectedIconIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIconIndex = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.deepPurple : Colors.grey[900],
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected ? Colors.deepPurpleAccent : Colors.white24,
                            width: 2,
                          ),
                        ),
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          categoryIcons[index],
                          color: isSelected ? Colors.white : Colors.white70,
                          size: 28,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 30),
              // ...existing code...
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: (){},
                  child: Text('Cancel', style: TextStyle(color: Colors.white70)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[900],
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: (){},
                  child: Text('Create', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}