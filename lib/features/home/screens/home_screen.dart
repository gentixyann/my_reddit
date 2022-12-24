import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_reddit/core/common/loader.dart';
import 'package:my_reddit/features/auth/controlller/auth_controller.dart';
import 'package:my_reddit/features/home/drawers/community_list_drawer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return user == null
        ? const Loader()
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                'Home',
              ),
              centerTitle: false,
              leading: Builder(
                builder: (context) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => displayDrawer(context),
                  );
                },
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
                Builder(builder: (context) {
                  return IconButton(
                    icon: CircleAvatar(
                      backgroundImage: NetworkImage(user.profilePic),
                    ),
                    onPressed: () {},
                  );
                }),
              ],
            ),
            body: Center(
              child: Text(user.uid),
            ),
            drawer: const CommunityListDrawer(),
          );
  }
}
