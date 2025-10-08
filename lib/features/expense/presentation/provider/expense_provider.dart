import 'package:budgetloom/features/expense/presentation/screens/expense_screen.dart';
import 'package:budgetloom/features/onBoarding/presentation/screens/welcome_screen.dart';
import 'package:budgetloom/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class ExpenseProvider extends ChangeNotifier {
  List<Widget> screens = [ExpenseScreen(), WelcomeScreen(), ProfileScreen()];
  int _selectedIndex = 0;
  final now = DateTime.now();
  late final String currentMonth = DateFormat('MMMM').format(now);

  int get selectedIndex => _selectedIndex;

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
