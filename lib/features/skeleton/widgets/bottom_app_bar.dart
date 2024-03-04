import 'package:flutter/material.dart';

class BottomAppWidget extends StatefulWidget {
  const BottomAppWidget({super.key});

  @override
  State<BottomAppWidget> createState() => _BottomAppWidgetState();
}

class _BottomAppWidgetState extends State<BottomAppWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).colorScheme.onPrimary,
      height: 50,
      clipBehavior: Clip.antiAlias,
      shape: const CircularNotchedRectangle(),
      elevation: 0,
      notchMargin: 4,
      child: Builder(builder: (context) {
        return SingleChildScrollView(
            child: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.transparent,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.transparent,
              ),
              label: '',
            ),
          ],
        ));
      }),
    );
  }
}



// final bottomAppBar = 