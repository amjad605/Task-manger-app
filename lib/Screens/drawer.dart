import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/Cubit/Todo_Cubit.dart';
import 'package:untitled3/Cubit/Todo_States.dart';

import 'package:untitled3/shared/sharedcomponents.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Todo_Cubit, Todo_States>(
      listener: (context, state) {},
      builder: (context, state) => Drawer(
        child: Column(
          children: [
            DrawerHeader(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.4),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              child: Row(children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                      'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=2000'),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  'Amjad Ayman',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                )
              ]),
            ),
            SwitchListTile(
              title: const Text(
                'Dark mode',
                style: TextStyle(fontSize: 19),
              ),
              value: Todo_Cubit.get(context).isdark,
              enableFeedback: true,
              onChanged: (value) async {
                Todo_Cubit.get(context).changeappmode(value);

                Cachehelper.preferences.setBool('isDark', value);
              },
              activeColor: Colors.deepPurpleAccent,
            ),
            ListTile(
              trailing: const Icon(Icons.settings),
              onTap: () {},
              title: const Text(
                'Settings',
                style: TextStyle(fontSize: 19),
              ),
            ),
            ListTile(
              trailing: const Icon(Icons.person),
              onTap: () {},
              title: const Text(
                'Profile',
                style: TextStyle(fontSize: 19),
              ),
            ),
            ListTile(
              trailing: const Icon(Icons.notifications),
              onTap: () {},
              title: const Text(
                'Notifcations',
                style: TextStyle(fontSize: 19),
              ),
            )
          ],
        ),
      ),
    );
  }
}
