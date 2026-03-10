import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  final VoidCallback onClose;

  const DrawerMenu({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const SizedBox(
              height: 100, // Fixed height for the header
              child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.deepPurple),
                margin: EdgeInsets.zero,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Menu Drawer',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
            ),
            ...List.generate(
              20,
              (index) => ListTile(
                leading: const Icon(Icons.star_border), // generic icon
                title: Text('Menu Item ${index + 1}'),
                onTap: onClose,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
