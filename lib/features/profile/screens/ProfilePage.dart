// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class ProfileScreen extends StatefulWidget {
//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<Offset> _slideAnimation;
//   late bool _isDarkMode;
//
//   @override
//   void initState() {
//     super.initState();
//     _isDarkMode = false;
//
//     _animationController =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 600));
//
//     _slideAnimation =
//         Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero).animate(
//             CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
//
//     _animationController.forward();
//   }
//
//   Future<User?> _getCurrentUser() async {
//     try {
//       return FirebaseAuth.instance.currentUser;
//     } catch (e) {
//       print("Error: ${e.toString()}");
//       return null;
//     }
//   }
//
//   Future<void> _signOut(BuildContext context) async {
//     try {
//       await FirebaseAuth.instance.signOut();
//       Navigator.pushReplacementNamed(context, '/getStarted');
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error signing out: ${e.toString()}")),
//       );
//     }
//   }
//
//   void _toggleTheme() {
//     setState(() {
//       _isDarkMode = !_isDarkMode;
//     });
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final horizontalPadding = MediaQuery.of(context).size.width * 0.07;
//
//     return AnimatedTheme(
//       data: _isDarkMode
//           ? ThemeData.dark().copyWith(
//           colorScheme:
//           ColorScheme.dark())
//           : ThemeData.light().copyWith(
//           colorScheme:
//           ColorScheme.light()),
//       duration: Duration(milliseconds: 500),
//       child: Scaffold(
//         backgroundColor: Color(0xFFF0FDF4),
//         appBar: AppBar(
//           elevation: 0,
//           title: Text("Profile",style: TextStyle(fontWeight: FontWeight.bold),),
//           centerTitle: true,
//           backgroundColor: Colors.transparent,
//           actions: [
//             IconButton(
//               icon: Icon(_isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round),
//               onPressed: _toggleTheme,
//               tooltip: _isDarkMode ? "Light Mode" : "Dark Mode",
//             ),
//           ],
//         ),
//         body: SafeArea(
//           child: FutureBuilder<User?>(
//             future: _getCurrentUser(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//               if (snapshot.hasError || snapshot.data == null) {
//                 return Center(
//                     child:
//                     Text("Error: ${snapshot.error ?? "No user found"}"));
//               }
//
//               final user = snapshot.data!;
//               final displayName = user.displayName ?? "No Name";
//               final email = user.email ?? "No Email";
//               final photoUrl = user.photoURL;
//
//               return SlideTransition(
//                 position: _slideAnimation,
//                 child: Padding(
//                   padding:
//                   EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 24),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       CircleAvatar(
//                         radius: 55,
//                         backgroundColor: _isDarkMode
//                             ? Colors.grey.shade800
//                             : Color(0xFFDDEBFF),
//                         backgroundImage:
//                         photoUrl != null ? NetworkImage(photoUrl) : null,
//                         child: photoUrl == null
//                             ? Icon(Icons.person_outlined,
//                             size: 70,
//                             color: _isDarkMode ? Colors.white54 : Colors.grey)
//                             : null,
//                       ),
//                       SizedBox(height: 20),
//                       Text(
//                         displayName,
//                         style: TextStyle(
//                             fontSize: 26,
//                             fontWeight: FontWeight.bold,
//                             color: _isDarkMode ? Colors.white : Colors.black87),
//                       ),
//                       SizedBox(height: 6),
//                       Text(
//                         email,
//                         style: TextStyle(
//                             fontSize: 16,
//                             color:
//                             _isDarkMode ? Colors.white70 : Colors.black54),
//                       ),
//                       SizedBox(height: 40),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           ElevatedButton.icon(
//                             onPressed: () {
//                               Navigator.pushNamed(context, '/editProfile');
//                             },
//                             icon: Icon(Icons.edit,color: Colors.black,),
//                             label: Text("Edit Profile",style: TextStyle(color: Colors.black),),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.green,
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 20, vertical: 14),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                           ),
//                           ElevatedButton.icon(
//                             onPressed: () => _signOut(context),
//                             icon: Icon(Icons.logout,color: Colors.black,),
//                             label: Text("Log Out",style: TextStyle(color: Colors.black),),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.redAccent,
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 20, vertical: 14),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 30),
//                       ListTile(
//                         leading: Icon(Icons.settings,
//                             color: _isDarkMode ? Colors.white : Colors.black54),
//                         title: Text(
//                           "Settings",
//                           style: TextStyle(
//                               color: _isDarkMode ? Colors.white : Colors.black87,
//                               fontWeight: FontWeight.w500),
//                         ),
//                         trailing: Icon(Icons.arrow_forward_ios,
//                             size: 16,
//                             color: _isDarkMode ? Colors.white : Colors.black54),
//                         onTap: () {
//                           Navigator.pushNamed(context, '/settings');
//                         },
//                       ),
//                       ListTile(
//                         leading: Icon(Icons.help_outline,
//                             color: _isDarkMode ? Colors.white : Colors.black54),
//                         title: Text(
//                           "Help & Feedback",
//                           style: TextStyle(
//                               color: _isDarkMode ? Colors.white : Colors.black87,
//                               fontWeight: FontWeight.w500),
//                         ),
//                         trailing: Icon(Icons.arrow_forward_ios,
//                             size: 16,
//                             color: _isDarkMode ? Colors.white : Colors.black54),
//                         onTap: () {
//                           Navigator.pushNamed(context, '/helpFeedback');
//                         },
//                       )
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_providers.dart';
import '../../../providers/profile_provider.dart';
import '../../../providers/theme_provider.dart';
import '../../../routes/routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}


class _ProfileScreenState
    extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<ProfileProvider>()
          .loadProfile();
    });
  }

  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final profileProvider = context.watch<ProfileProvider>();
    final authUser = FirebaseAuth.instance.currentUser;
    final user = auth.user;
    final profileImage =
    profileProvider.userData?['profileImage'];


    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("No user found")),
      );
    }
    if (profileProvider.isLoading) {
      return const Center(
        child:
        CircularProgressIndicator(),
      );
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.themeMode == ThemeMode.dark
                  ? Icons.wb_sunny_outlined
                  : Icons.nightlight_round,
            ),
            onPressed: () {
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [


          CircleAvatar(
          radius: 55,
          backgroundImage:
          profileImage != null &&
              profileImage.isNotEmpty
              ? NetworkImage(profileImage)
              : authUser?.photoURL != null
              ? NetworkImage(
            authUser!.photoURL!,
          )
              : null,
          child: (profileImage == null ||
              profileImage.isEmpty) &&
              authUser?.photoURL == null
              ? const Icon(
            Icons.person,
            size: 50,
          )
              : null,
        ),
            const SizedBox(height: 20),

            /// NAME


      Text(
          profileProvider.userData?['name'] ??
          authUser?.displayName ??
          "User",
          style: Theme.of(context)
          .textTheme
          .headlineSmall,
    ),

            const SizedBox(height: 6),

            /// EMAIL
            Text(
              profileProvider.userData?['email'] ??authUser?.email?? "",
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 30),

            /// ACTION BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.editProfile);
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text("Edit Profile"),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    await context.read<AuthProvider>().logout();

                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.getStarted,
                          (route) => false,
                    );
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text("Logout"),
                ),
              ],
            ),

            const SizedBox(height: 30),

            /// SETTINGS
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),

            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text("Help & Feedback"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.pushNamed(context, '/helpFeedback');
              },
            ),
          ],
        ),
      ),
    );
  }
}
