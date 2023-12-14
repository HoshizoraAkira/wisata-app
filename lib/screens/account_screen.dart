import 'package:flutter/material.dart';
import 'package:wisata_app/helper/session_manager.dart';
import 'package:wisata_app/widgets/button_nav_bar.dart';

class AccountScreen extends StatelessWidget {

  Future<void> _logout() async {
    await SessionManager.clearUserData();
  }

  const AccountScreen({super.key});

  static String? uname = SessionManager().getUsername();
  static String? email = SessionManager().getEmail();

  Future<void> checkLoginStatus(BuildContext context) async {
    await SessionManager().checkLoginStatus(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const ButtonNavBar(selectedMenu: MenuState.profile),
      appBar: AppBar(
        title: const Text('User Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {

            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '$uname',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                '$email',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _logout();
                  checkLoginStatus(context);
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
