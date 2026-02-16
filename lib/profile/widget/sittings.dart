import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
class Sittings extends ConsumerStatefulWidget {
  const Sittings({super.key});

  @override
  ConsumerState<Sittings> createState() => _SittingsState();
}
class _SittingsState extends ConsumerState<Sittings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Settings', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        child:Column(
children: [
  ListTile(
    leading: Icon(Icons.color_lens, color: Colors.white),
    title: Text('App Color', style: TextStyle(color: Colors.white, fontSize: 18)),
    trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
    onTap: () {
      // Navigate to account settings
    },
  ),
  Divider(color: Colors.white12),
  ListTile(
    leading: Icon(Icons.language, color: Colors.white),
    title: Text('App languge', style: TextStyle(color: Colors.white, fontSize: 18)),
    trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
    onTap: () {
      // Navigate to notification settings
    },
  ),
  Divider(color: Colors.white12),
  ListTile(
    leading: Icon(Icons.palette, color: Colors.white),
    title: Text('Theme', style: TextStyle(color: Colors.white, fontSize: 18)),
    trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
    onTap: () {
      // Navigate to theme settings
    },
  ),
  Divider(color: Colors.white12),
  ListTile(
    leading: Icon(Icons.lock, color: Colors.white),
    title: Text('Privacy', style: TextStyle(color: Colors.white, fontSize: 18)),
    trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
    onTap: () {
      // Navigate to privacy settings
    },
  ),
  Divider(color: Colors.white12),
  ListTile(
    leading: Icon(Icons.info, color: Colors.white),
    title: Text('About', style: TextStyle(color: Colors.white, fontSize: 18)),
    trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
    onTap: () {
      // Navigate to about page
    },
  ),
],
        )
      ),
    );
  }
}