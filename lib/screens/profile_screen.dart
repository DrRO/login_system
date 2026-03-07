import 'package:flutter/material.dart';

import '../cubit/home/home_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var profile = HomeCubit.get(context).profile;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),

      body: profile == null
          ? const Center(child: CircularProgressIndicator())
          : Center(
            child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(profile.avatar),
            ),



            const SizedBox(height: 20),

            Text(
              profile.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              profile.email,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
                    ],
                  ),
          ),
    );
  }
}