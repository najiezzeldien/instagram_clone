import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/state/auth/backend/authenticator.dart';
import 'package:instagram_clone_course/state/auth/models/auth_result.dart';
import 'package:instagram_clone_course/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_clone_course/state/auth/providers/is_logged_in_provider.dart';
import 'firebase_options.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
      ),
      themeMode: ThemeMode.dark,
      home: Consumer(
        builder: (context, ref, child) {
          final isLoggedIn =
              ref.watch(authStateProvider).result == AuthResult.success;
          isLoggedIn.log();
          if (isLoggedIn) {
            return const MainView();
          } else {
            return const LoginView();
          }
        },
      ),
    );
  }
}

// when you are already logged in
class MainView extends StatelessWidget {
  const MainView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home View'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          return TextButton(
            onPressed: () async {
              await ref.read(authStateProvider.notifier).logOut();
            },
            child: const Text("LogOut"),
          );
        },
      ),
    );
  }
}

// for when you are not logged in
class LoginView extends ConsumerWidget {
  const LoginView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login View"),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: ref.read(authStateProvider.notifier).logInWithGoogle,
            child: const Text(
              "Sign in with Google",
            ),
          ),
          TextButton(
            onPressed: ref.read(authStateProvider.notifier).logInWithFacebook,
            child: const Text(
              "Sign in with Facebook",
            ),
          ),
        ],
      ),
    );
  }
}
