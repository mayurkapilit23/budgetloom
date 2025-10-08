import 'package:budgetloom/features/expense/presentation/widgets/custom_expense_container.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [CustomExpenseContainer(), CustomExpenseContainer()],
              ),
              SizedBox(height: 30),
              Text('data'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        elevation: 0,
        onPressed: () {},
        child: Icon(EvaIcons.plus, color: Colors.white),
      ),
    );
  }
}
