// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class profileScreen extends StatelessWidget {
//   @override
//
//   Future<User?>_getCurrentUser()async{
//      try{
//       return FirebaseAuth.instance.currentUser;
//      }
//      catch(e){
//        print("Error:${e.toString()}");
//        return null;
//      }
//   }
//   Future<void>_signOut(BuildContext context)async{
//     try{
//       await FirebaseAuth.instance.signOut();
//       Navigator.pushReplacementNamed(context, '/login');
//     }
//     catch(e){
//      ScaffoldMessenger.of(context).showSnackBar(
//        SnackBar(content: Text("Error signing out:${e.toString()}")),
//      );
//     }
//   }
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         title: Text("Home"),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//           child: FutureBuilder<User?>(
//               future: _getCurrentUser(),
//               builder: (context,snapshot){
//                 if(snapshot.connectionState==ConnectionState.waiting){
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 if(snapshot.hasError || snapshot.data==null){
//                   return Center(child: Text("Error:${snapshot.error}"));
//                 }
//
//                 final user=snapshot.data!;
//                 final displayName=user.displayName??"No Name";
//                 final email=user.email??"No Email";
//                 final photoUrl=user.photoURL;
//
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 40,),
//                       Center(
//                         child: CircleAvatar(
//                           radius: 50,
//                           backgroundColor: const Color(0xFFDDEBFF),
//                           backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
//                           child: photoUrl == null
//                               ? const Icon(Icons.person_outlined, size: 60, color: Colors.grey)
//                               : null,
//                         ),
//                       ),
//                       const SizedBox(height: 24),
//                       Center(
//                         child: Text(
//                           displayName,
//                           style: const TextStyle(
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Center(
//                         child: Text(
//                           email,
//                           style: const TextStyle(
//                             fontSize: 16,
//                             color: Colors.black54,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 40),
//                       Center(
//                         child: SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButton(
//                             onPressed: () => _signOut(context),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.blue,
//                               foregroundColor: Colors.white,
//                               padding: const EdgeInsets.symmetric(vertical: 16),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             child: const Text("Log out"),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }
//           )
//       )
//     );
//   }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class profileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<profileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _isDarkMode = false;

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));

    _slideAnimation =
        Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero).animate(
            CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _animationController.forward();
  }

  Future<User?> _getCurrentUser() async {
    try {
      return FirebaseAuth.instance.currentUser;
    } catch (e) {
      print("Error: ${e.toString()}");
      return null;
    }
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/getStarted');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error signing out: ${e.toString()}")),
      );
    }
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = MediaQuery.of(context).size.width * 0.07;

    return AnimatedTheme(
      data: _isDarkMode
          ? ThemeData.dark().copyWith(
          colorScheme:
          ColorScheme.dark())
          : ThemeData.light().copyWith(
          colorScheme:
          ColorScheme.light()),
      duration: Duration(milliseconds: 500),
      child: Scaffold(
        backgroundColor: Color(0xFFF0FDF4),
        appBar: AppBar(
          elevation: 0,
          title: Text("Profile",style: TextStyle(fontWeight: FontWeight.bold),),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round),
              onPressed: _toggleTheme,
              tooltip: _isDarkMode ? "Light Mode" : "Dark Mode",
            ),
          ],
        ),
        body: SafeArea(
          child: FutureBuilder<User?>(
            future: _getCurrentUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError || snapshot.data == null) {
                return Center(
                    child:
                    Text("Error: ${snapshot.error ?? "No user found"}"));
              }

              final user = snapshot.data!;
              final displayName = user.displayName ?? "No Name";
              final email = user.email ?? "No Email";
              final photoUrl = user.photoURL;

              return SlideTransition(
                position: _slideAnimation,
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundColor: _isDarkMode
                            ? Colors.grey.shade800
                            : Color(0xFFDDEBFF),
                        backgroundImage:
                        photoUrl != null ? NetworkImage(photoUrl) : null,
                        child: photoUrl == null
                            ? Icon(Icons.person_outlined,
                            size: 70,
                            color: _isDarkMode ? Colors.white54 : Colors.grey)
                            : null,
                      ),
                      SizedBox(height: 20),
                      Text(
                        displayName,
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: _isDarkMode ? Colors.white : Colors.black87),
                      ),
                      SizedBox(height: 6),
                      Text(
                        email,
                        style: TextStyle(
                            fontSize: 16,
                            color:
                            _isDarkMode ? Colors.white70 : Colors.black54),
                      ),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pushNamed(context, '/editProfile');
                            },
                            icon: Icon(Icons.edit,color: Colors.black,),
                            label: Text("Edit Profile",style: TextStyle(color: Colors.black),),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () => _signOut(context),
                            icon: Icon(Icons.logout,color: Colors.black,),
                            label: Text("Log Out",style: TextStyle(color: Colors.black),),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      ListTile(
                        leading: Icon(Icons.settings,
                            color: _isDarkMode ? Colors.white : Colors.black54),
                        title: Text(
                          "Settings",
                          style: TextStyle(
                              color: _isDarkMode ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w500),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,
                            size: 16,
                            color: _isDarkMode ? Colors.white : Colors.black54),
                        onTap: () {
                          Navigator.pushNamed(context, '/settings');
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.help_outline,
                            color: _isDarkMode ? Colors.white : Colors.black54),
                        title: Text(
                          "Help & Feedback",
                          style: TextStyle(
                              color: _isDarkMode ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w500),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,
                            size: 16,
                            color: _isDarkMode ? Colors.white : Colors.black54),
                        onTap: () {
                          Navigator.pushNamed(context, '/helpFeedback');
                        },
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
