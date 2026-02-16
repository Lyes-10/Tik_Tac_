import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_withriverpod/Auth/pages/register.dart';
import 'package:to_do_withriverpod/Home/page/home.dart';
import 'package:to_do_withriverpod/bottonNav/bottonNav.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
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
              Text('Login',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2)),
              SizedBox(height: 8),
              Text('Welcome back! Please login to your account.',
                  style: GoogleFonts.poppins(color: Colors.white70, fontSize: 16),textAlign: TextAlign.center,),
              SizedBox(height: 40),
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
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text('Forgot Password?', style: GoogleFonts.poppins(color: Colors.deepPurpleAccent)),
                ),
              ),
              SizedBox(height: 10),
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
                      pageBuilder: (context, animation, secondaryAnimation) => BottomNav(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: Text('Login', style: GoogleFonts.poppins(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600)),
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
              // Sign up link
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => Register(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: GoogleFonts.poppins(color: Colors.white70, fontSize: 16),
                    children: [
                      TextSpan(
                        text: "Sign Up",
                        style: GoogleFonts.poppins(
                          color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}


