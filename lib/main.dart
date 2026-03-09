import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // We start at index 1 because index 0 is designated for the Drawer
  int _selectedIndex = 1;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isDrawerMenuOpen = false;

  // Use simple Center widgets for the 4 pages
  // Index 0 in this list is just a placeholder since we won't show it.
  static const List<Widget> _pages = <Widget>[
    SizedBox.shrink(), // Index 0 (Drawer button placeholder)
    Center(child: Text('Page 1', style: TextStyle(fontSize: 24))),
    Center(child: Text('Page 2', style: TextStyle(fontSize: 24))),
    Center(child: Text('Page 3', style: TextStyle(fontSize: 24))),
    Center(child: Text('Page 4', style: TextStyle(fontSize: 24))),
  ];

  void _onItemTapped(int index) {
    if (index == 0) {
      setState(() {
        _isDrawerMenuOpen = !_isDrawerMenuOpen;
      });
    } else {
      // Keep the selected index updated for pages 1-4
      setState(() {
        _selectedIndex = index;
        _isDrawerMenuOpen = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // ScaffoldKey for controlling the Drawer programmatically
      body: Stack(
        children: [
          _pages.elementAt(_selectedIndex),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: _isDrawerMenuOpen ? 0 : -MediaQuery.of(context).size.width,
            top: 0,
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  SizedBox(
                    height: 100, // Fixed height for the header
                    child: const DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                      ),
                      margin: EdgeInsets.zero,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Menu Drawer',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ...List.generate(
                    10,
                    (index) => ListTile(
                      leading: Icon(Icons.star_border), // generic icon
                      title: Text('Menu Item ${index + 1}'),
                      onTap: () {
                        setState(() {
                          _isDrawerMenuOpen = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Essential for > 3 items
        currentIndex: _isDrawerMenuOpen ? 0 : _selectedIndex, // Highlight Menu if open, else the selected page
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Page 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Page 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Page 3',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Page 4',
          ),
        ],
      ),
    );
  }
}
