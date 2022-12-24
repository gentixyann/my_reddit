import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_reddit/core/common/loader.dart';
import 'package:my_reddit/features/auth/controlller/auth_controller.dart';
import 'package:my_reddit/models/user_model.dart';
import 'package:my_reddit/router.dart';
import 'package:my_reddit/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

import 'core/common/error_text.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;

  void getData(WidgetRef ref, User data) async {
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(data.uid)
        .first;
    ref.read(userProvider.notifier).update((state) => userModel);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return user == null
        ? const Loader()
        : ref.watch(authStateChangeProvider).when(
              data: (data) => MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: 'My Reddit',
                theme: Pallete.lightModeAppTheme,
                routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
                  // if (user != null) {
                  //   if (data != null) {
                  //     getData(ref, data);
                  //     if (userModel != null) {
                  //       print(data);
                  //       print('ログイン済み');
                  //       return loggedInRoute;
                  //     }
                  //   }
                  // }
                  if (data != null) {
                    getData(ref, data);
                    if (userModel != null) {
                      // print(userModel!.name);
                      print('dataはnullじゃない');
                      return loggedInRoute;
                    }
                  } else {
                    print('dataはnull');
                    return loggedOutRoute;
                  }
                  return loggedOutRoute;
                }),
                routeInformationParser: const RoutemasterParser(),
                // home: const LoginScreen(),
              ),
              error: (error, stackTrace) => ErrorText(error: error.toString()),
              loading: () => const Loader(),
            );
  }
}

//   @override
//   Widget build(BuildContext context) => MaterialApp(
//         title: 'Flutter app',
//         home: StreamBuilder<User?>(
//           stream: FirebaseAuth.instance.authStateChanges(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               // スプラッシュ画面などに書き換えても良い
//               return const SizedBox();
//             }
//             if (snapshot.hasData) {
//               // User が null でなない、つまりサインイン済みのホーム画面へ
//               return HomePage();
//             }
//             // User が null である、つまり未サインインのサインイン画面へ
//             return SignInPage();
//           },
//         ),
//       );
// }

// class SignInPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => const Scaffold(
//         body: Center(
//           child: Text('未サインイン時に表示するサインイン画面です。'),
//         ),
//       );
// }

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => const Scaffold(
//         body: Center(
//           child: Text('サインイン済み時に表示するホーム画面です。'),
//         ),
//       );
// }
