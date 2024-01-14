// import 'package:flutter/material.dart';
// import 'package:project/core/constants.dart';
// import 'package:project/core/notifiers.dart';
//
// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile'),
//       ),
//       body: const Column(
//         children: [
//           CircleAvatar(
//             backgroundImage: AssetImage('images/wegiel_energetyka.jpg'),
//             radius: 100,
//           ),
//           SizedBox(height: kDouble20),
//           ListTile(
//             leading: Icon(Icons.person),
//             title: Text('Flutter Mapp'),
//           ),
//           ListTile(
//             leading: Icon(Icons.email),
//             title: Text('info@fluttermapp.com'),
//           ),
//           ListTile(
//             leading: Icon(Icons.web),
//             title: Text('FlutterMapp.com'),
//           ),
//         ],
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () {
//       //     isDarkModeNotifier.value = !isDarkModeNotifier.value;
//       //   },
//       //   child: ValueListenableBuilder(
//       //     valueListenable: isDarkModeNotifier,
//       //     builder: (context, isDark, child) {
//       //       if (!isDark) {
//       //         return const Icon(Icons.dark_mode);
//       //       } else {
//       //         return const Icon(Icons.light_mode);
//       //       }
//       //     },
//       //   ),
//       // ),
//     );
//   }
// }
//
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// class ProfilePage extends StatelessWidget {
//   ProfilePage({Key? key}) : super(key: key);
//
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const CircleAvatar(
//               backgroundImage: AssetImage('images/wegiel_energetyka.jpg'),
//               radius: 100,
//             ),
//             const SizedBox(height: 20),
//             ListTile(
//               leading: const Icon(Icons.person),
//               title: const Text('Flutter Mapp'),
//             ),
//             ListTile(
//               leading: const Icon(Icons.email),
//               title: const Text('info@fluttermapp.com'),
//             ),
//             ListTile(
//               leading: const Icon(Icons.web),
//               title: const Text('FlutterMapp.com'),
//             ),
//             ElevatedButton(
//               onPressed: () => signInWithGoogle(context),
//               child: const Text("Zaloguj się przez Google"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> signInWithGoogle(BuildContext context) async {
//     try {
//       final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
//       final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;
//
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication?.accessToken,
//         idToken: googleSignInAuthentication?.idToken,
//       );
//
//       final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Zalogowano jako ${userCredential.user?.email}')),
//       );
//     } on FirebaseAuthException catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Błąd logowania: ${e.message}')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Błąd logowania Google: $e')),
//       );
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/core/constants.dart';
import 'package:project/core/notifiers.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});


  final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.profile),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('images/zarowka.jpg'),
            radius: 100,
          ),
          const SizedBox(height: kDouble20),
           const ListTile(
           ),
          // ListTile(
          //   leading: Icon(Icons.email),
          //   title: Text("email"),
          // ),
          // ListTile(
          //   leading: Icon(Icons.web),
          //   title: Text(localizations.web),
          // ),
          FloatingActionButton.extended(
            onPressed: () async {
              final result = await signInWithGoogle();


              if (result != null) {
                String message =
                    result.contains('@') ? 'Zalogowano Pomyślnie jako $result' : result;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message)),
                );
              }
            },
            icon: Image.asset(
              'images/google.png',
              height: 32,
              width: 32,
            ),
            label: Text(localizations.login),
          ),
        ],
      ),
    );
  }


  Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);


      return userCredential.user?.email;
    } on FirebaseAuthException catch (e) {return incorrectMessage;
    } catch (e) { return incorrectlyMessage;
    }
  }
}
