import 'package:budgetloom/features/expense/presentation/provider/expense_provider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final eProvider = Provider.of<ExpenseProvider>(context);

    return Scaffold(
      body: eProvider.screens[eProvider.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // no shifting animation
        currentIndex: eProvider.selectedIndex,
        onTap: eProvider.onItemTapped,
        elevation: 0,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,

        showUnselectedLabels: false,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(EvaIcons.homeOutline),
            activeIcon: Icon(EvaIcons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(EvaIcons.infoOutline),
            activeIcon: Icon(EvaIcons.info),
            label: "Calender",
          ),
          BottomNavigationBarItem(
            icon: Icon(EvaIcons.personOutline),
            activeIcon: Icon(EvaIcons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
