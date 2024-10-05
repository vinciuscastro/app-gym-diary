import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final User? user;
  const AppDrawer({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user?.displayName ?? 'Usuario'),
            accountEmail: Text(user?.email ?? ''),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(user?.photoURL ?? ''),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Perfil'),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          const Spacer(),
          ListTile(
            title: const Text('Sair'),
            leading: const Icon(Icons.exit_to_app),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/auth');
            },
          ),
        ],
      ),
    );
  }
}
