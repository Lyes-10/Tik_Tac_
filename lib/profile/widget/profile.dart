import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_withriverpod/profile/widget/sittings.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}
class _ProfileState extends ConsumerState<Profile> {
  String accountName = 'John Doe';
  String password = '********';
  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Profile',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 40),
              imageUrl.isNotEmpty
                  ? CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(imageUrl),
                    )
                  : CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('asset/Group 159.png'),
                    ),
              SizedBox(height: 20),
              Text(
                accountName,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Icon(Icons.check_circle, color: Colors.white, size: 30),
                      SizedBox(height: 8),
                      Text('Completed', style: GoogleFonts.poppins(color: Colors.white70)),
                      SizedBox(height: 4),
                      Text('24', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.flag, color: Colors.white, size: 30),
                      SizedBox(height: 8),
                      Text('Flagged', style: GoogleFonts.poppins(color: Colors.white70)),
                      SizedBox(height: 4),
                      Text('5', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.white, size: 30),
                      SizedBox(height: 8),
                      Text('Events', style: GoogleFonts.poppins(color: Colors.white70)),
                      SizedBox(height: 4),
                      Text('12', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),       
              Container(
                child: Column(
                  children: [
                    Align(
                alignment: Alignment.centerLeft,
                child: Text('settings', style: GoogleFonts.poppins(color: Colors.white70, fontSize: 16),textAlign: TextAlign.center,)),
              
                    ListTile(
                      leading: Icon(Icons.settings, color: Colors.deepPurple),
                      title: Text('Settings', style: GoogleFonts.poppins(color: Colors.white)),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Sittings()));
                      },
                    ),
                     Divider(color: Colors.white12),
                         Align(
                alignment: Alignment.centerLeft,
                child: Text('Account', style: GoogleFonts.poppins(color: Colors.white70, fontSize: 16),textAlign: TextAlign.center,)),
              
                    ListTile(
                      leading: Icon(Icons.person, color: Colors.deepPurple),
                      title: Text('Change Account Name', style: GoogleFonts.poppins(color: Colors.white)),
                      subtitle: Text(accountName, style: GoogleFonts.poppins(color: Colors.white54, fontSize: 12)),
                      onTap: () async {
                        final controller = TextEditingController(text: accountName);
                        final result = await showDialog<String>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.grey[900],
                              title: Text('Change Account Name', style: GoogleFonts.poppins(color: Colors.white)),
                              content: TextField(
                                controller: controller,
                                style: GoogleFonts.poppins(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'Enter new name',
                                  hintStyle: GoogleFonts.poppins(color: Colors.white54),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('Cancel', style: GoogleFonts.poppins(color: Colors.white70)),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                                  onPressed: () => Navigator.pop(context, controller.text.trim()),
                                  child: Text('Save', style: GoogleFonts.poppins(color: Colors.white)),
                                ),
                              ],
                            );
                          },
                        );
                        if (result != null && result.isNotEmpty) {
                          setState(() {
                            accountName = result;
                          });
                        }
                      },
                    ),
                    Divider(color: Colors.white12),
                    ListTile(
                      leading: Icon(Icons.lock, color: Colors.deepPurple),
                      title: Text('Change Password', style: GoogleFonts.poppins(color: Colors.white)),
                      subtitle: Text(password, style: GoogleFonts.poppins(color: Colors.white54, fontSize: 12)),
                      onTap: () async {
                        final controller = TextEditingController();
                        final confirmController = TextEditingController();
                        String? errorText;
                        final result = await showDialog<String>(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return AlertDialog(
                                  backgroundColor: Colors.grey[900],
                                  title: Text('Change Password', style: GoogleFonts.poppins(color: Colors.white)),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: controller,
                                        obscureText: true,
                                        style: GoogleFonts.poppins(color: Colors.white),
                                        decoration: InputDecoration(
                                          hintText: 'Enter new password',
                                          hintStyle: GoogleFonts.poppins(color: Colors.white54),
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      TextField(
                                        controller: confirmController,
                                        obscureText: true,
                                        style: GoogleFonts.poppins(color: Colors.white),
                                        decoration: InputDecoration(
                                          hintText: 'Confirm new password',
                                          hintStyle: GoogleFonts.poppins(color: Colors.white54),
                                        ),
                                      ),
                                      if (errorText != null)
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Text(errorText!, style: GoogleFonts.poppins(color: Colors.red, fontSize: 12)),
                                        ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('Cancel', style: GoogleFonts.poppins(color: Colors.white70)),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                                      onPressed: () {
                                        if (controller.text.trim() != confirmController.text.trim()) {
                                          setState(() {
                                            errorText = 'Passwords do not match';
                                          });
                                        } else if (controller.text.trim().isEmpty) {
                                          setState(() {
                                            errorText = 'Password cannot be empty';
                                          });
                                        } else {
                                          Navigator.pop(context, controller.text.trim());
                                        }
                                      },
                                      child: Text('Save', style: GoogleFonts.poppins(color: Colors.white)),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        );
                        if (result != null && result.isNotEmpty) {
                          setState(() {
                            password = '*' * result.length;
                          });
                        }
                      },
                    ),
                    Divider(color: Colors.white12),
                    ListTile(
                      leading: Icon(Icons.image, color: Colors.deepPurple),
                      title: Text('Change Profile Image', style: GoogleFonts.poppins(color: Colors.white)),
                      subtitle: imageUrl.isNotEmpty
                          ? Text(imageUrl, style: GoogleFonts.poppins(color: Colors.white54, fontSize: 12))
                          : null,
                      onTap: () async {
                        final controller = TextEditingController(text: imageUrl);
                        final result = await showDialog<String>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.grey[900],
                              title: Text('Change Profile Image', style: GoogleFonts.poppins(color: Colors.white)),
                              content: TextField(
                                controller: controller,
                                style: GoogleFonts.poppins(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'Enter image URL',
                                  hintStyle: GoogleFonts.poppins(color: Colors.white54),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('Cancel', style: GoogleFonts.poppins(color: Colors.white70)),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                                  onPressed: () => Navigator.pop(context, controller.text.trim()),
                                  child: Text('Save', style: GoogleFonts.poppins(color: Colors.white)),
                                ),
                              ],
                            );
                          },
                        );
                        if (result != null && result.isNotEmpty) {
                          setState(() {
                            imageUrl = result;
                          });
                        }
                      },
                    ),
                      Align(
                alignment: Alignment.centerLeft,
                child: Text('Uptodo', style: GoogleFonts.poppins(color: Colors.white70, fontSize: 16),textAlign: TextAlign.center,)),
               Divider(color: Colors.white12),
                    ListTile(
                      leading: Icon(Icons.info, color: Colors.deepPurple),
                      title: Text('About Uptodo', style: GoogleFonts.poppins(color: Colors.white)),
                      onTap: () {}),
                       Divider(color: Colors.white12),
                       ListTile(
                      leading: Icon(Icons.question_answer, color: Colors.deepPurple),
                      title: Text('FAQ', style: GoogleFonts.poppins(color: Colors.white)),
                      onTap: () {}),
                       Divider(color: Colors.white12),
                         ListTile(
                      leading: Icon(Icons.logout, color: Colors.red),
                      title: Text('Logout', style: GoogleFonts.poppins(color: Colors.red)),
                      onTap: () {}),
                       Divider(color: Colors.white12),                  
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}