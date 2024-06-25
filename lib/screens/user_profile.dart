import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final user = FirebaseAuth.instance.currentUser!.uid;

class UserProfileWidget extends StatefulWidget {
  const UserProfileWidget({super.key});

  @override
  State<UserProfileWidget> createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget> {
  String profilePhotoUrl = '';
  String username = '';

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      var userDocumentSnapshot = await FirebaseFirestore.instance.collection('users').doc(user).get();

      if (userDocumentSnapshot.exists) {
        var userDocument = userDocumentSnapshot.data() as Map<String, dynamic>;
        setState(() {
          profilePhotoUrl = userDocument['profilePhoto'] ?? '';
          username = userDocument['username'] ?? '';
        });
      } else {
        print("Document does not exist");
      }
    } catch (e) {
      print("Error fetching user profile: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.2),
      child: Row(
        children: [
          const SizedBox(width: 10),
          CircleAvatar(
            backgroundImage: profilePhotoUrl != ''
                ? NetworkImage(profilePhotoUrl)
                : Image.asset('assets/place_holder.png').image,
            radius: 14,
          ),
          const SizedBox(width: 10),
          Text(
            'Hello, $username',
            style: const TextStyle(fontSize: 14),
          ),
          const Spacer(),
          
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Sign Out'),
                    content: const Text('Are you sure you want to log out?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      FilledButton(
                        child: const Text('Log Out'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          FirebaseAuth.instance.signOut();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.switch_account_sharp),
            color: Theme.of(context).colorScheme.onTertiaryContainer,
            iconSize: 30,
          ),
        ],
      ),
    );
  }
}
