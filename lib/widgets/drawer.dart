import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
      DrawerHeader(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Stack(children: const [
          Positioned(
            bottom: 16.0, 
            left: 16.0, 
            child: Text(
              'StickyNotifs',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
              ))
          )
        ]),
      )
    ]));
  }
}
