import 'package:absorber_clone/services/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool inBattle = ref.watch(inBattleProvider);
    return SafeArea(
        child: Container(
            color: Colors.blue,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  inBattle
                      ? ElevatedButton(
                          onPressed: () {
                            print("fight pressed");
                          },
                          child: Row(
                            children: const [
                              Icon(Icons.handshake_outlined),
                              SizedBox(width: 5),
                              Text('Fight!'),
                            ],
                          ),
                        )
                      : const SizedBox(width: 1),
                  ElevatedButton(
                      onPressed: () {
                        print("Stats pressed");
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.castle_outlined),
                          SizedBox(width: 5),
                          Text('Dungeon'),
                        ],
                      )),
                  ElevatedButton(
                      onPressed: () {
                        print("Stats pressed");
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.bar_chart),
                          SizedBox(width: 5),
                          Text('Stats'),
                        ],
                      )),
                  ElevatedButton(
                      onPressed: () {
                        print("Log pressed");
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.receipt_long_outlined),
                          SizedBox(width: 5),
                          Text('Log'),
                        ],
                      )),
                ]))));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.maxFinite, 80);
}
