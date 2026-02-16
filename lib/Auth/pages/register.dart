import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_withriverpod/Auth/pages/login.dart';

class Register extends ConsumerStatefulWidget {
  const Register({super.key});

  @override
  ConsumerState<Register> createState() => _RegisterState();
}
class _RegisterState extends ConsumerState<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              // Logo placeholder
              SizedBox(height: 10),
             
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,

                child: Text('Register',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2)),
              ),
              SizedBox(height: 20),
              
             
              // Email field
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withOpacity(0.15),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  style: GoogleFonts.poppins(color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                    filled: true,
                    fillColor: Colors.transparent,
                    hintText: 'Email',
                    hintStyle: GoogleFonts.poppins(color: Colors.white54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 18),
              // Password field
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withOpacity(0.15),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  style: GoogleFonts.poppins(color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                    filled: true,
                    fillColor: Colors.transparent,
                    hintText: 'Password',
                    hintStyle: GoogleFonts.poppins(color: Colors.white54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 16),
               Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withOpacity(0.15),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  style: GoogleFonts.poppins(color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                    filled: true,
                    fillColor: Colors.transparent,
                    hintText: 'Confirm Password',
                    hintStyle: GoogleFonts.poppins(color: Colors.white54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 30),
            
              // Login button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  minimumSize: Size(double.infinity, 54),
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: (){
                   Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => Login(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: Text('Register', style: GoogleFonts.poppins(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600)),
              ),
              SizedBox(height: 28),
              // OR divider
              Row(
                children: <Widget>[
                  Expanded(child: Divider(color: Colors.white24, thickness: 1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text("OR", style: GoogleFonts.poppins(color: Colors.white70, fontWeight: FontWeight.w600)),
                  ),
                  Expanded(child: Divider(color: Colors.white24, thickness: 1)),
                ],
              ),
              SizedBox(height: 24),
              // Social register buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
           
              SizedBox(height: 24),
             
             
              
            ],
          ),
            ]))
      ),
    );}}